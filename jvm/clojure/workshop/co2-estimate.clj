;;; Create a function called `co2-estimate` that takes one integer parameter
;;; called `year` and returns the estimated level of CO2 ppm for that year.
(def base-co2  382)
(def base-year 2006)

(defn co2-estimate
  "Return the estimated atmospheric CO2 level in PPM for the given `year`"
  [year]
  (let [year-diff (- year base-year)]
    (+ base-co2 (* 2 year-diff))))
