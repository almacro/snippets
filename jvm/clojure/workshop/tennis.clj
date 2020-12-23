;;; [4.12] parsing csv with semantic-csv
(ns packt-clj.tennis
  (:require
   [clojure.data.csv :as csv]
   [clojure.java.io :as io]
   [semantic-csv.core :as sc]))


(defn first-match [csv]
  (with-open [r (io/reader csv)]
    (->> (csv/read-csv r)
         sc/mappify
         first)))


;; (defn five-matches [csv]
;;   (with-open [r (io/reader csv)]
;;     (->> (csv/read-csv r)
;;          sc/mappify
;;          (map #(select-keys % [:tourney_year_id
;;                                :winner_name
;;                                :loser_name
;;                                :winner_sets_won
;;                                :loser_sets_won]))
;;          (take 5)
;;          doall)))


(defn five-matches [csv]
  (with-open [r (io/reader csv)]
    (->> (csv/read-csv r)
         sc/mappify
         (map #(select-keys % [:tourney_year_id
                               :winner_name
                               :loser_name
                               :winner_sets_won
                               :loser_sets_won]))
         (sc/cast-with {:winner_sets_won sc/->int
                        :loser_sets_won sc/->int})
         (take 5)
         doall)))


;;; [4.13] querying the data with filter
(defn federer-wins [csv]
    (with-open [r (io/reader csv)]
    (->> (csv/read-csv r)
         sc/mappify
         (filter #(= "Roger Federer" (:winner_name %)))
         (map #(select-keys % [:winner_name
                               :loser_name
                               :winner_sets_won
                               :loser_sets_won
                               :winner_games_won
                               :loser_games_won                               
                               :tourney_year_id
                               :tourney_slug]))
         doall)))


;;; [4.14] a dedicated query function
(defn match-query [csv pred]
    (with-open [r (io/reader csv)]
    (->> (csv/read-csv r)
         sc/mappify
         (filter pred)
         (map #(select-keys % [:winner_name
                               :loser_name
                               :winner_sets_won
                               :loser_sets_won
                               :winner_games_won
                               :loser_games_won                               
                               :tourney_year_id
                               :tourney_slug]))
         doall)))


;;; [4.15] Using filter to find a tennis rivalry 
;;;
;;; rewrite match query so that sets/games that are won/lost are given
;;; as numbers rather than strings
(defn match-query [csv pred]
    (with-open [r (io/reader csv)]
    (->> (csv/read-csv r)
         sc/mappify
         (sc/cast-with {:winner_sets_won sc/->int
                        :loser_sets_won sc/->int
                        :winner_games_won sc/->int
                        :loser_games_won sc/->int})
         (filter pred)
         (map #(select-keys % [:winner_name
                               :loser_name
                               :winner_sets_won
                               :loser_sets_won
                               :winner_games_won
                               :loser_games_won                               
                               :tourney_year_id
                               :tourney_slug]))
         doall)))


;;; [4.16] arbitrary tennis rivalries
;;;
;;; use the tennis dataset to write a function that provides
;;; information about a tennis rivalry. the call signature should be:
;;;   (defn rivalry-data [csv player-1 player-2])
;;;
;;; the function should return a map with the following fields:
;;; * :first-victory-player-1
;;; * :first-victory-player-2
;;; * :total-matches
;;; * :total-victories-player-1
;;; * :total-victories-player-2
;;; * :most-competitive-matches
;;;
;;; the `:total-*` fields should be integers and the other fields should
;;; be lists of matches, possibly empty. the matches should be maps
;;; with fields as given in the previous match-query example. 

(defn rivalry-data [csv player-1 player-2]
  (with-open [r (io/reader csv)]
    (let [matches-for-players #(= (hash-set (:winner_name %) (:loser_name %))
                                  #{player-1 player-2})
          all-matches (->> (csv/read-csv r)
                           sc/mappify
                           (sc/cast-with {:winner_sets_won sc/->int
                                          :loser_sets_won sc/->int
                                          :winner_games_won sc/->int
                                          :loser_games_won sc/->int})
                           (filter matches-for-players)
                           (map #(select-keys % [:winner_name
                                                 :loser_name
                                                 :winner_sets_won
                                                 :loser_sets_won
                                                 :winner_games_won
                                                 :loser_games_won                               
                                                 :tourney_year_id
                                                 :tourney_slug]))
                           doall)
          total-matches (count all-matches)
          sorted-matches (sort-by :tourney_year_id all-matches)
          wins-by-player (fn[player] #(= (:winner_name %) player))
          by-player1-wins (wins-by-player player-1)
          by-player2-wins (wins-by-player player-2)          
          player1-match-wins (filter by-player1-wins sorted-matches)
          player2-match-wins (filter by-player2-wins sorted-matches)
          first-victory-player-1 (first player1-match-wins)
          first-victory-player-2 (first player2-match-wins)
          total-victories-player-1 (count player1-match-wins)
          total-victories-player-2 (count player2-match-wins)
          by-competitive-score #(= 1 (- (:winner_sets_won %) (:loser_sets_won %)))
          most-competitive-matches (filter by-competitive-score sorted-matches)]
      {:first-victory-player-1 first-victory-player-1
       :first-victory-player-2 first-victory-player-2
       :total-matches total-matches
       :total-victories-player-1 total-victories-player-1
       :total-victories-player-2 total-victories-player-2
       :most-competitive-matches most-competitive-matches
       })))
