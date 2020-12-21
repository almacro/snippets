;;; Write two functions that report the minimum and maximum values for
;;; each of the numeric fields in `game-users` for all the users and
;;; for each status category.
(defn max-game-values
  []
  (let [num-fields #{:current-points :remaining-lives :experience-level}
        status-categories (set (->> (map (partial :status) game-users)))]
    (map (fn [status]
           {status 
           (map (fn [field]
                  {field (apply max (map field (filter #(= (:status %) status) game-users)))})
                num-fields)})
         status-categories)))
(defn min-game-values
  []
  (let [num-fields #{:current-points :remaining-lives :experience-level}
        status-categories (set (->> (map (partial :status) game-users)))]
    (map (fn [status]
           {status 
           (map (fn [field]
                  {field (apply min (map field (filter #(= (:status %) status) game-users)))})
                num-fields)})
         status-categories)))

;;; The functions should take three arguments:
;;; * the field to query
;;; * the status to query
;;; * the list of users
;;;
;;; They should be called like this:
;;; (max-value-by-status :current-points :active game-users)
;;; (min-value-by-status :remaining-lives :imprisoned game-users)
;;
;; (defn max-value-by-status
;;   [field status users]
;;   (let [by-status #(= (:status %) status)]
;;     (apply max 0 (map field (filter by-status users)))))
;; (defn min-value-by-status
;;   [field status users]
;;   (let [by-status #(= (:status %) status)]
;;     (apply min (map field (filter by-status users)))))

(defn max-value-by-status
  [field status users]
  (let [by-status #(= (:status %) status)
        least-max Integer/MIN_VALUE
        found-max (->> (filter by-status users)
                       (map field)
                       (apply max least-max))]
    (when-not (= found-max least-max) found-max)))
(defn min-value-by-status
  [field status users]
  (let [by-status #(= (:status %) status)
        most-min  Integer/MAX_VALUE
        found-min (->> (filter by-status users)
                       (map field)
                       (apply min most-min))]
    (when-not (= found-min most-min) found-min)))
