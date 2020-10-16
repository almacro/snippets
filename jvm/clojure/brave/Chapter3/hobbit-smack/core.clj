(ns hobbit-smack.core
  (:gen-class))

(def asym-hobbit-body-parts [{:name "head" :size 3} 
                             {:name "left-eye" :size 1} 
                             {:name "left-ear" :size 1} 
                             {:name "mouth" :size 1} 
                             {:name "nose" :size 1} 
                             {:name "neck"  :size 2} 
                             {:name "left-shoulder"  :size 3} 
                             {:name "left-upper-arm"  :size 3} 
                             {:name "chest"  :size 10} 
                             {:name "back"  :size 10} 
                             {:name "left-forearm"  :size 3} 
                             {:name "abdomen"  :size 6} 
                             {:name "left-kidney"  :size 1} 
                             {:name "left-hand"  :size 2} 
                             {:name "left-knee"  :size 2} 
                             {:name "left-thigh"  :size 4} 
                             {:name "left-lower-leg"  :size 3} 
                             {:name "left-achilles"  :size 1} 
                             {:name "left-foot"  :size 2}])

(defn matching-part [part] {:name (clojure.string/replace (:name part) #"^left-" "right-") 
                            :size (:size part)})

(defn symmetrize-body-parts 
  "Expects a seq of maps that have :name and :size"
  [asym-body-parts]
  (loop [remaining-asym-body-parts asym-body-parts final-body-parts []]
    (if (empty? remaining-asym-body-parts)
      final-body-parts
      (let [[part & remaining] remaining-asym-body-parts]
        (recur remaining (into final-body-parts (set [part (matching-part part)])))))))

(defn better-symmetrize-body-parts
  "Expects a sequence of maps that have :name and :size"
  [asym-body-parts]
  (reduce (fn [final-body-parts part]
            (into final-body-parts (set [part (matching-part part)])))
          []
          asym-body-parts))

; create a more generic form of symmetrize-body-parts
; take an expander and a list of body parts and return a body parts model
(defn expand-body-parts
  [expander body-parts]
  "Takes an expander function and a list of body parts. Returns a sequence of maps that have :name and :size"
  (reduce (fn [final-body-parts part]
            (into final-body-parts (set [part (matching-part part)])))
   [] 
   (expander body-parts)))

(def spider-parts ["eye" "leg"])

(defn spider-body-expander
  [parts]
  "Produce an expanded list of parts to an asymmetric parts model for a spider body"
  (let [parts (reduce #(into %1 %2) 
                      []
                      (map (fn [part] 
                             (reduce (fn [acc index] 
                                       (conj acc (str part "-" index))) 
                                     [] 
                                     [1 2 3 4])) 
                           parts))
        asym-parts (reduce #(conj %1 {:name (str "left-" %2) :size 1})
                           []
                           parts)]
    asym-parts))
