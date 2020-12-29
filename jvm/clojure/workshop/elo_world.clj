(ns packt-clj.elo-world
  (:require
   [clojure.data.csv :as csv]
   [clojure.java.io :as io]
   [semantic-csv.core :as sc]
   [clojure.math.numeric-tower :as math]))

;;; Write a function that parses a CSV file of tennis matches using
;;; `reduce`. This function will calculate player ratings and also
;;; keep track of success of predicting match results.
;;;
;;; The accumulator map will need to build up the following information:
;;; * Player ratings
;;;   A map linking each player to his rating. The map gets updated with
;;;   new ratings for each player in the match being analyzed.
;;; * Success count:
;;;   For each match where one of the two players has a better than 50%
;;;   chance of winning, did the expected winner actually win? The count of
;;;   successes will be divided by the total number of match predictions
;;;   to determine the precision of predictions.
;;; * Total match count:
;;;   The total number of matches that have been considered.
;;; * Prediction count:
;;;   The number of matches where a winner could be predicted - that is, the
;;;   matches where the forecast was not 50-50. Since those matches are excluded
;;;   from the success count, these will be excluded from the prediction count.

(defn match-probability [player-1-rating player-2-rating]
  (/ 1
     (+ 1
        (math/expt 10 (/ (- player-2-rating player-1-rating) 400)))))

(defn recalculate-rating [previous-rating k-factor expected-outcome real-outcome]
  (+ previous-rating (* k-factor (- real-outcome expected-outcome))))

(defn elo-world [csv k-factor]
  (let [beginner-rating 400
        recalculate-rating (fn [previous-rating expected-outcome real-outcome]
                             (+ previous-rating (* k-factor (- real-outcome expected-outcome))))]
    (with-open [r (io/reader csv)]
      (->> (csv/read-csv r)
           sc/mappify
           (reduce (fn [{:keys [players total-match-count correct-predictions predictable-match-count] :as acc}
                        {:keys [winner_slug loser_slug]}]
                     (let [winner-rating (or (players winner_slug) beginner-rating)
                           loser-rating (or (players loser_slug) beginner-rating)
                           prediction? (not= winner-rating loser-rating)
                           winner-probability (match-probability winner-rating loser-rating)
                           loser-probability  (match-probability loser-rating winner-rating)
                           expected-won? (> winner-probability loser-probability)
                           winner-rating (recalculate-rating winner-rating winner-probability 1)
                           loser-rating (recalculate-rating loser-rating loser-probability 0)]
                       (-> acc
                           (assoc-in [:players winner_slug] winner-rating)
                           (assoc-in [:players loser_slug] loser-rating)
                           (update :total-match-count inc)
                           (assoc :correct-predictions (+ correct-predictions
                                                   (if (and prediction? expected-won?) 1 0)))
                           (assoc :predictable-match-count (+ predictable-match-count
                                                      (if prediction? 1 0)))))
                   )
                   {:players {}
                    :total-match-count 0
                    :correct-predictions 0
                    :predictable-match-count 0})))))

