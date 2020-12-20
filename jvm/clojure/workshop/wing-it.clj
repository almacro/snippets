;;; WingIt
;;;
;;; * Support travel by walking or driving, using `itinerary` and `cost`
;;;   functions between starting and endpoints of travel
;;;
;;; * Interact with functions in REPL
;;;
;;; * The `itinerary` function returns a HashMap with the keys:
;;; ** `:distance`  of trip in kilometers
;;; ** `:cost`      of trip in dollars
;;; ** `:duration`  of trip in hours
;;;
;;; * The `itinerary` function takes a HashMap parameter containing:
;;; ** `:from`
;;; ** `:to`
;;; ** `:transport`
;;; ** `:vehicle`
;;;
;;; * `:from` and `:to` each contain a HashMap with :lat and :lon
;;;   keys, representing latitude and longitude of a location on the
;;;   planet
;;;
;;; * `:transport` can be either `:walking` or `:driving`
;;;
;;; * `:vehicle` is useful for the `:transport` mode of `:driving`,
;;;   and can be one of:
;;; ** `:sporche`
;;; ** `:sleta`
;;; ** `:tayato`
;;;
;;; * The `distance` function is computed as the Haversine forumula
;;;   for the great-circle distance between two points on a sphere
;;;   given their longitudes and latitudes:
;;;
;;;     $$ 110.25 \times \sqrt{(lat2 - lat1)^2 + \cos(lat1) \times (lon2 - lon1)^2} $$
;;;
;;; * The `cost` function is computed in the case of transport being
;;;   `:driving` based on the `:vehicle` used:
;;;
;;; ** `:sporche` consumes, on average, 0.12 liters of petrol per
;;;    kilometer, costing $1.50 per liter
;;;
;;; ** `:tayato` consumes, on average, 0.07 liters of petrol per
;;;    kilometer, costing $1.50 per liter
;;;
;;; ** `:sleta` consumes, on average, 0.2 kilowatt hour (kwh) of
;;;    electricity per kilometer, costing $0.10 per kwh
;;;
;;; ** The cost is to be considered 0 for the transport mode of `:walking`
;;;
;;; * The `duration` function is computed with the average speed of
;;;   `:driving` as 70 km per hour, and `:walking` as 5 km per hour
;;;
;;; Example usage:
;;; (def paris {:lat 48.856483 :lon 2.352413})
;;; (def bordeaux {:lat 44.834999 :lon -0.575490})
;;; (itinerary {:from paris :to bordeaux :transport :walking})
;;; (itinerary {:from paris :to bordeaux :transport :driving :vehicle :tayato})

;;; Define `walking-speed` and `driving-speed` constants
(def walking-speed 4)   ; km/h, was 5
(def driving-speed 70)  ; km/h

(def walking-hours #(apply (comp * /) [% walking-speed]))
(def driving-hours #(apply (comp * /) [% driving-speed]))

;;; Create constants reprsenting two locations with `:lat` and `:lon` coordinates
(def berlin {:lat 52.54291 :lon 13.36742})
(def munich {:lat 48.16898 :lon 11.50205})

;;; Create `distance` function that takes two parameters representing
;;; locations to calculate distance between
(defn distance [{lat1 :lat lon1 :lon} 
                {lat2 :lat lon2 :lon}]
  (let [sqr #(* % %)
        deg-len 110.25
        x (- lat1 lat2)
        y (* (- lon1 lon2) (Math/cos lat2))]
    (* deg-len (Math/sqrt (+ (sqr x) (sqr y))))))

;;; Create a multimethod called `itinerary` that uses `:transport` as
;;; a dispatch value
(defmulti itinerary :transport)

;;; Create the `itinerary` function for the `:walking` dispatch value
(defmethod itinerary :walking
  [{:keys [from to]}]
  (let [kms (distance from to)
        hours (walking-hours kms)  ;(/ kms walking-speed 1.0) ;(walking-hours kms)
        cost 0]
    {:cost cost, :distance kms, :duration hours}))

;;; Create a `vehicle-cost-fns` dispatch table
(def petrol-price 1.50)  ; per liter
(def petrol-cost (partial * petrol-price))

(def electricity-price 0.10) ; per kilowatt-hour
(def electricity-cost (partial * electricity-price))
                               
(def vehicle-cost-fns
  {:sporche (fn [km] (petrol-cost km 0.12))
   :sleta   (fn [km] (electricity-cost km 0.2))
   :tayato  (fn [km] (petrol-cost km 0.07))
   })

;;; Create the `itinerary` function for the `:driving` dispatch value
(defmethod itinerary :driving
  [{:keys [from to vehicle]}]
  (let [kms (distance from to)
        hours (driving-hours kms)  ;(* kms driving-speed)
        vehicle-cost-fn (vehicle-cost-fns vehicle)
        cost (vehicle-cost-fn kms)]
    {:cost cost, :distance kms, :duration hours}))
