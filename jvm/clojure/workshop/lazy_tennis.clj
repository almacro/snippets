(ns lazy-tennis
  (:require [clojure.math.numeric-tower :as math]
            [clojure.java.io :as io]
            [clojure.data.csv :as csv]
            [semantic-csv.core :as sc]))

;;;; Exercise 7.03: A Tennis History Tree

(defn match-probability [player-1-rating player-2-rating]
  (/ 1
     (+ 1
        (math/expt 10 (/ (- player-2-rating player-1-rating) 400)))))

;(defn recalculate-rating [previous-rating k-factor expected-outcome real-outcome]
;  (+ previous-rating (* k-factor (- real-outcome expected-outcome))))
(defn recalculate-rating [k-factor previous-rating expected-outcome real-outcome]
  (+ previous-rating (* k-factor (- real-outcome expected-outcome))))

(defn elo-world-simple [csv k-factor]
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

(defn elo-db
  ([csv k] (elo-db csv k 400))
  ([csv k beginner-rating]
   (with-open [r (io/reader csv)]
     (->> (csv/read-csv r)
          sc/mappify
          (sc/cast-with {:winner_sets_won sc/->int
                         :loser_sets_won sc/->int
                         :winner_games_won sc/->int
                         :loser_games_won sc/->int})
          (reduce (fn [{:keys [players] :as acc}
                       {:keys [:winner_name :winner_slug
                               :loser_name :loser_slug] :as match}]
                    (let [winner-rating (get players winner_slug beginner-rating)
                          loser-rating (get players loser_slug beginner-rating)
                          winner-probability (match-probability winner-rating loser-rating)
                          loser-probability (- 1 winner-probability)]
                      (-> acc
                          (assoc-in [:players winner_slug] (recalculate-rating k winner-rating winner-probability 1))
                          (assoc-in [:players loser_slug] (recalculate-rating k loser-rating loser-probability 0))
                          (update :matches (fn [ms]
                                             (conj ms (assoc match
                                                             :winner_rating winner-rating
                                                             :loser_rating loser-rating)))))))
                  {:players {}
                   :matches []})
          :matches
          reverse))))

;; run `elo-db` function on CSV file and store the matches in a var
;;; (def ratings (elo-db "match_scores_1991-2016_unindexed_csv.csv" 35))

;; verify ratings are available
;;; (map #(select-keys % [:winner_rating :loser_rating]) (take 5 ratings))

(defn player-in-match? [{:keys [winner_slug loser_slug]} player-slug]
  ((hash-set winner_slug loser_slug) player-slug))

(defn match-tree-by-player [m player-slug]
  (lazy-seq
   (cond (empty? m)
         '()  ; No more matches
         (player-in-match? (first m) player-slug)
         (cons (first m)  ; Build the tree!
               (cons
                [(match-tree-by-player (rest m) (:winner_slug (first m)))
                 (match-tree-by-player (rest m) (:loser_slug (first m)))]
                '()))
         ::otherwise
         (match-tree-by-player (rest m) player-slug))))  ;Keep walking through the tree


;;;; Exercise 7.04: A Custom `take` Function

(defn take-matches
  ([limit tree] (take-matches limit tree identity))
  ([limit tree f]
  (cond (zero? limit)
        ' ()
        (= 1 limit)
        (f (first tree))
        :otherwise-continue
        (cons
         (f (first tree))
         (cons
          [(take-matches (dec limit) (first (second tree)) f)
           (take-matches (dec limit) (second (second tree)) f)]
          ' ())))))

(defn matches-with-ratings [limit tree]
  (take-matches limit
                tree
                (fn [match]
                  (-> match
                      (update :winner_rating int)
                      (update :loser_rating int)
                      (select-keys [:winner_name :loser_name :winner_rating :loser_rating])
                      (assoc :winner_probability_percentage
                             (->> (match-probability (:winner_rating match)
                                                     (:loser_rating match))
                                  (* 100)
                                  int))))))

;;;; Activity 7.01: Historical, Player-Centric Elo

(defn focus-history [tree player-slug focus-depth opponent-depth f]
  (cond
    (zero? focus-depth)
    '()
    (= 1 focus-depth)
    (f (first tree))
    :otherwise
    (cons
     (f (first tree))
     (cons [(if (player-in-match? (ffirst (second tree)) player-slug)
              (focus-history (first (second tree)) player-slug (dec focus-depth) opponent-depth f)
              (take-matches opponent-depth (first (second tree)) f))
            (if (player-in-match? (first (second (second tree))) player-slug)
              (focus-history (second (second tree)) player-slug (dec focus-depth) opponent-depth f)
              (take-matches opponent-depth (second (second tree)) f))]
           '()))))
