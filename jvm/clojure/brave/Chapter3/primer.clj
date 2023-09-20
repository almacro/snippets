;;; execute the true part                                                                                                                                    
(if true
  "By Zeus' hammer!"
  "By Aquaman's trident!")

;; execute the else part                                                                                                                                     
(if false
  "By Zeus' hammer!"
  "By Aquaman's trident!")

;;; returns nothing                                                                                                                                          
(if false
  "By Odin's elbow!")

;;; use do for multiple forms in true/false clauses                                                                                                          
(if true
    (do (println "Success!")
        "By Zeus' hammer!")
    (do (println "Failure!")
        "By Aquaman's trident!"))

;;; when is like if+do, has no else clause                                                                                                                   
(when true
  (println "Success!")
  "abra cadabra")

;;; nil, true, false...                                                                                                                                      
(nil? 1)
(nil? nil)

;;; string is truthy                                                                                                                                         
(if "bears eat beets"
    "bears beets Battlestar Galactica")

;;; falsey value is falsey                                                                                                                                   
(if nil
    "This won't be the result because nil is falsey"
    "nil is falsey")

;;; equality operator                                                                                                                                        
(= 1 1)

(= nil nil)

(= 1 2)

;;; boolean ops: and/or                                                                                                                                      
(or false nil :large_I_mean_venti :why_cant_I_just_say_large)

(or (= 0 1) (= "yes" "no"))

(or nil)

(and :free_wifi :hot_coffee)

(and :feelin_super_cool nil false)

;;; name values with def
(def failed-protagonist-names
  ["Larry Potter" "Doreen the Explorer" "The Incredible Bulk"])

failed-protagonist-names
;;;; ["Larry Potter" "Doreen the Explorer" "The Incredible Bulk"]

;;; imperative style, bad
(def severity :mild)
(def error-message "OH GOD! IT'S A DISASTER! WE'RE ")
(if (= severity :mild)
  (def error-message (str error-message "MILDLY INCONVENIENCED!"))
  (def error-message (str error-message "DOOOOOOOMED!")))

;;; clojure style, good!
(defn error-message
  [severity]
  (str "OH GOD! IT'S A DISASTER! WE'RE "
       (if (= severity :mild)
         "MILDLY INCONVENIENCED!"
         "DOOOOOOOMED!")))

(error-message :mild)

;;; numbers
93
1.2
1/5

(type 93)     ;; java.lang.Long
(type 1.2)    ;; java.lang.Double
(type 1/5)    ;; clojure.lang.Ratio

;;; strings
"Lord Voldemort"
"\"He who must not be named\""
"\"Great cow of Moscow!\" - Hermes Conrad"

;;;; no string interpolation
(def name "Chewbacca")
(str "\"Uggllglglglglglglglll\" - " name)

;;; maps
;;;; empty map literal
{}

;;;; keywords as keys
{:first-name "Charlie"
:last-name "McFishwich"}

;;;; strings can be keys
{"string-key" +}

;;;; nested maps
{:name {:first "John" :middle "Jacob" :last "Jingleheimerschmidt"}}

;;;; create map with hash-map
(hash-map :a 1 :b 2)
;;;;; => {:a 1 :b 2}

;;;; map lookups
(get {:a 0 :b 1} :b)

(get {:a 0 :b {:c "ho hum"}} :b)

;;;; nil returned if key not found
(get {:a 0 :b 1} :c)

;;;; specify default value
(get {:a 0 :b 1} :c "unicorns?")

;;;; lookup values in nested context
(get-in {:a 0 :b {:c "ho hum"}} [:b :c])

;;;; use map as a function with key as argument
({:name "The Human Coffeepot"} :name)

;;; keywords
:a
:rumplestiltsken
:34
:_?

;;;; keywords as functions
(:a {:a 1 :b 2 :c 3})

;;;; equivalent of
(get {:a 1 :b 2 :c 3} :a)

;;; add default value
(:d {:a 1 :b 2 :c 3} "No gnome knows homes like Noah knows")

;;; vectors
[3 2 1]

;;;; get 0th item
(get [3 2 1] 0)

;;;; get by index, again
(get ["a" {:name "Pugsley Winterbottom"} "c"] 1)

;;;; use vector function to create vector
(vector "creepy" "full" "moon")

;;;; use conj function to add item to end of vector
(conj [1 2 3] 4)

;;; lists
;;;; list literal

;;;; retrieve by index with nth
(nth '(:a :b :c) 0)
(nth '(:a :b :c) 2)

;;;; use list function to make list
(list 1 "two" {3 4})

;;;; conj adds item to front of list
(conj '(1 2 3) 4)

;;; sets
;;;; set literal
#{"kurt vonnegut" 20 :icicle}

;;;; use hash-set to make a set
(hash-set 1 1 2 2)

;;; use conj to add new item to set
(conj #{:a :b} :b)

;;;; use set to make set from vector
(set [3 3 3 4 4])

;;;; use contains? to check membershiip
(contains? #{:a :b} :a)

(contains? #{:a :b} 3)

(contains? #{nil} nil)

;;;; use keyword to check membership
(:a #{:a :b})

;;;; get to get set element
(get #{:a :b} :a)

(get #{:a nil} nil)

(get #{:a :b} "kurt vonnegut")

;;; functions
(+ 1 2 3 4)
(* 1 2 3 4)
(first [1 2 3 4])

;;;; get PLUS
(or + -)

;;;; get 6
((or + -) 1 2 3)

;;;; also get 6
((and (= 1 1) +) 1 2 3)

((first [+ 0]) 1 2 3)

;;;; not a function
(1 2 3 4)
("test" 1 2 3)

;;;; map a function
(inc 1.1)
(map inc [0 1 2 3])

;;;; recursive evaluation
(+ (inc 199) (/ 100 (- 7 2)))

;;; defining functions
;;;; - defn
;;;; - function name
;;;; - a docstring describing the function [optional]
;;;; - parameters listed in brackets
;;;; - function body
(defn too-enthusiastic
  "Return a cheer that might be a bit too enthusiastic"
  [name]
  (str "OH. MY. GOD! " name " YOU ARE DEFINITELY LIKE THE BEST "
  "MAN SLASH WOMAN EVER I LOVE YOU AND WE SHOULD RUN AWAY SOMEWWHERE"))

;;;; arity
;;;;; zero-arity
(defn no-params []
  "I take no parameters!")

;;;;; 1-arity
(defn one-param
 [x]
 (str "I take one parameter: " x))

;;;;; 2-arity
(defn two-params
  [x y]
  (str "Two parameters! That's nothing! Pah! I will smoosh them "
       "together to spite you!" x y))

;;; arity overloading
(defn multi-arity
  ;; 3-arity arguments and body
  ([first-arg second-arg third-arg]
     (do-things first-arg second-arg third-arg))
  ;; 2-arity arguments and body
  ([first-arg second-arg]
     (do-things first-arg second-arg))
  ;; 1-arity arguments and body
  ([first-arg]
     (do-things first-arg)))

(defn x-chop
  "Describe the kind of chop you're inflicting on someone"
  ([name chop-type]
     (str "I " chop-type " chop " name "! Take that!"))
  ([name]
     (x-chop name "karate")))

(x-chop "Kanye West" "slap")

(defn weird-arity
  ([]
     "Destiny dressed you this morning, my friend, and now Fear is
     trying to pull off your pants. If you give up, if you give in,
     you're gonna end up naked with Fear just standing there laughing
     at your dangling unmentionables! - the Tick")
  ([number]
   (inc number)))

(defn codger-communication
  [whippersnapper]
  (str "Get off my lawn, " whippersnapper "!!!"))

(defn codger
  [& whippersnappers]
  (map codger-communication whippersnappers))

(codger "Billy" "Anne-Marie" "The Incredible Bulk")

(defn favorite-things
  [name & things]
  (str "Hi, " name ", here are my favorite things: "
       (clojure.string/join ", " things)))

(favorite-things "Doreen" "gum" "shoes" "kara-te")

;;; Destructuring
;;;; Return the first element of a collection
(defn my-first
  [[first-thing]] ; Notice that first-thing is within a vector
  first-thing)

(my-first ["oven" "bike" "war-axe"])

(defn chooser
  [[first-choice second-choice & unimportant-choices]]
  (println (str "Your first choice is: " first-choice))
  (println (str "Your second choice is: " second-choice))
  (println (str "We're ignoring the rest of your choices. "
                "Here they are in case you need to cry over them: "
                (clojure.string/join ", " unimportant-choices))))

(chooser ["Marmalade", "Handsome Jack", "Pigpen", "Aquaman"])

(defn announce-treasure-location
  [{lat :lat lng :lng}]
  (println (str "Treasure lat: " lat))
  (println (str "Treasure lng: " lng)))

;;;; take corresponding keys
(defn announce-treasure-location
  [{:keys [lat lng]}]
  (println (str "Treasure lat: " lat))
  (println (str "Treasure lng: " lng)))

;;;; retain original map
(defn receive-treasure-location
  [{:keys [lat lng] :as treasure-location}]
  (println (str "Treasure lat: " lat))
  (println (str "Treasure lng: " lng))

  ;; One would assume that this would put in new coordinates for your ship
  (steer-ship! treasure-location))

;;; function body
;;;; last form in body is function result
(defn illustrative-function
  []
  (+ 1 304)
  30
  "joe")

(defn number-comment
  [x]
  (if (> x 6)
    "Oh my gosh! What a big number!"
    "That number's OK, I guess"))

;;; anonymous functions
;;;; (fn [param-list]
;;;;  function body)
(map (fn [name] (str "Hi, " name))
     ["Darth Vader" "Mr. Magoo"])

((fn [x] (* x 3)) 8)

(def my-special-multiplier (fn [x] (* x 3)))

;;;; compact syntax
#(* % 3)

(#(* % 3) 8)

;;;; map an anonymous function
(map #(str "Hi, " %)
     ["Darth Vader" "Mr. Magoo"])

;;;; anonymous function with multiple args
(#(str %1 " and " %2) "cornbread" "butter beans")

;;;; anonymous function with rest args
(#(identity %&) 1 "blarg" :yip)

;;; returning functions
(defn inc-maker
  "Create a custom incrementor"
  [inc-by]
  #(+ % inc-by))

(def inc3 (inc-maker 3))

;;; putting it all together
;;; smack around hobbits
;;;; vector of maps, each map has name of body part and relative size
(def asym-hobbit-body-parts [{:name "head" :size 3}
                             {:name "left-eye" :size 1}
                             {:name "left-ear" :size 1}
                             {:name "mouth" :size 1}
                             {:name "nose" :size 1}
                             {:name "neck" :size 2}
                             {:name "left-shoulder" :size 3}
                             {:name "left-upper-arm" :size 3}
                             {:name "chest" :size 10}
                             {:name "back" :size 10}
                             {:name "left-forearm" :size 3}
                             {:name "abdomen" :size 6}
                             {:name "left-kidney" :size 1}
                             {:name "left-hand" :size 2}
                             {:name "left-knee" :size 2}
                             {:name "left-thigh" :size 4}
                             {:name "left-lower-leg" :size 3}
                             {:name "left-achilles" :size 1}
                             {:name "left-foot" :size 2}])

;;;; map left-hand side to right-hand side
(defn matching-part
  [part]
  {:name (clojure.string/replace (:name part) #"^left-" "right-")
     :size (:size part)})

(defn symmetrize-body-parts
  "Expects a seq of maps that have a :name and :size"
  [asym-body-parts]
  (loop [remaining-asym-parts asym-body-parts
         final-body-parts []]
    (if (empty? remaining-asym-parts)
      final-body-parts
      (let [[part & remaining] remaining-asym-parts]
        (recur remaining
               (into final-body-parts
                     (set [part (matching-part part)])))))))

;;;;(symmetrize-body-parts asym-hobbit-body-parts)

;;; let
(let [x 3]
  x)

(def dalmatian-list
  ["Pongo" "Perdita" "Puppy 1" "Puppy 2"])
(let [dalmatians (take 2 dalmatian-list)]
  dalmatians)

(let [[pongo & dalmatians] dalmatian-list]
  [pongo dalmatians])

;;; loop
(loop [iteration 0]
  (println (str "Iteration " iteration))
  (if (> iteration 3)
    (println "Goodbye!")
    (recur (inc iteration))))

;;;; recursive definition
(defn recursive-printer
  ([]
     (recursive-printer 0))
  ([iteration]
     (println iteration)
     (if (> iteration 3)
       (println "Goodbye!")
       (recursive-printer (inc iteration)))))

;;; regular expressions
;;;; #"regular-expression"
(re-find #"^left-" "left-eye")

(re-find #"^left-" "cleft-chin")

(re-find #"^left-" "wongleblart")

(matching-part {:name "left-eye" :size 1})
(matching-part {:name "head" :size 3})

;;;; better symemetrizer with reduce
;;;;; sum with reduce
(reduce + [1 2 3 4])

;;;;; works like
(+ (+ (+ 1 2) 3) 4)

;;;;; reduce with initial value
(reduce + 15 [1 2 3 4])

;;;;; custom implementation of reduce
(defn my-reduce
  ([f initial coll]
   (loop [result initial
          remaining coll]
     (if (empty? remaining)
       result
       (recur (f result (first remaining)) (rest remaining)))))
  ([f [head & tail]]
      (my-reduce f head tail)))

;;;;; reduce version of symmetrizer
(defn better-symmetrize-body-parts
  "Expects a seq of maps that have a :name and :size"
  [asym-body-parts]
  (reduce (fn [final-body-parts part]
            (into final-body-parts (set [part (matching-part part)])))
          []
          asym-body-parts))

;;;; hobbit violence
(defn hit
  [asym-body-parts]
  (let [sym-parts (better-symmetrize-body-parts asym-body-parts)
        body-part-sum-size (reduce + (map :size sym-parts))
        target (rand body-part-sum-size)]
    (loop [[part & remaining] sym-parts
          accumulated-size (:size part)]
             (if (> accumulated-size target)
           part
           (recur remaining (+ accumulated-size (:size (first remaining))))))))

;;; exercises
;;; 1. Use the str, vector, list, hash-map, and hash-set functions.

(str "oh " "happy " "day!")
(str 2 " + " 2 " = " (+ 2 2))

[3 4 5]
(map #(* % %) [3 4 5])

'(7 8 9)
(count '(2 3 4))

(hash-map :stack :tall :color :green :unit 100)

(hash-set 1 2 3 3 5)

;;; 2. Write a function that takes a number and adds 100 to it.

(defn hundred-adder
  [x]
  (+ x 100))

;;; 3. Write a function, dec-maker, that works exactly like the
;;; function inc-maker except with subtraction:

(defn dec-maker
  "Create a custom decrementor"
  [dec-by]
  #(- % dec-by))

(def dec9 (dec-maker 9))
(dec9 10)

;;; 4. Write a function, mapset, that works like map except the return
;;; value is a set

(defn mapset
  [f coll]
  (set (map f coll)))

(mapset inc [1 1 2 2])

;;; 5. Create a function that’s similar to symmetrize-body-parts
;;; except that it has to work with weird space aliens with radial
;;; symmetry.  Instead of two eyes, arms, legs, and so on, they have
;;; five.

(defn radialize-part
  [part]
  (if (clojure.string/starts-with? (:name part) "left")
      (let [name (clojure.string/replace (:name part) #"^left-" "")]
        [(map #(hash-map :name (str name "-" %) :size (:size part)) (map inc (range 5)))])
      [part]))

(defn radial-symmetrize-body-parts
  [asym-body-parts]
  (reduce (fn [final-body-parts part]
              (into final-body-parts (set [(radialize-part part)])))
          []
          asym-body-parts))

;;; 6. Create a function that generalizes symmetrize-body-parts and
;;; the function you created in Exercise 5. The new function should
;;; take a collection of body parts and the number of matching body
;;; parts to add.

(defn N-radialize-part
  [part n]
  (if (clojure.string/starts-with? (:name part) "left")
      (let [name (clojure.string/replace (:name part) #"^left-" "")]
        [(map #(hash-map :name (str name "-" %) :size (:size part)) (map inc (range n)))])
      [part]))

(defn N-symmetrize-body-parts
  [asym-body-parts n]
  (reduce (fn [final-body-parts part]
              (into final-body-parts (set [(N-radialize-part part n)])))
          []
          asym-body-parts))
