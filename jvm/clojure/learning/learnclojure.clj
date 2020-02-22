(ns learnclojure)

;;; as seen on Learning Clojure cast on Safari Learning
;;; https://learning.oreilly.com/videos/learning-clojure

;;; Getting Started

(print "Hello World")

(+ 1 1)  ;2

(- 2 1)  ;1

(* 2 4)  ;8

(/ 4 2)  ;2

(* 3 (- 2 1))  ;3

;;; Types

(type 1)  ;java.lang.Long

(type 2.1)  ;java.lang.Double

(type true)  ;java.lang.Boolean

(type "Hello")  ;java.lang.String

(type (keyword "a"))  ;clojure.lang.Keyword
(type :a)  ;clojure.lang.Keyword

(type (quote a))  ;clojure.lang.Symbol

(type 'a)  ;clojure.lang.Symbol

(type '(1 2 3))  ;clojure.lang.PersistentList

(type (list 1 2 3))  ;clojure.lang.PersistentList

(type (vector 1 2 3))  ;clojure.lang.PersistentVector

(nth (vector 1 2 3) 2)  ;3

(first (list 1 2 3))  ;1

(last (list 1 2 3))  ;3

{:a 1 :b 2 :c 3}  ;{:a 1, :b 2, :c 3}

(type {:a 1 :b 2 :c 3})  ;clojure.lang.PersistentArrayMap

(type #{1 2 3 4})  ;clojure.lang.PersistentHashSet

;; literal collection syntax
(type '(1 2 3))   ;clojure.lang.PersistentList
(type (list 1 2 3))   ;clojure.lang.PersistentList

(type [1 2 3])  ;clojure.lang.PersistentVector
(type (vector 1 2 3))  ;clojure.lang.PersistentVector

(type {:a 1 :b 2})  ;clojure.lang.PersistentArrayMap, optimized for small collection
(type (hash-map :a 1 :b 2))  ;clojure.lang.PersistentHashMap, not optimized

(type #{1 2 3})  ;clojure.lang.PersistentHashSet
(type (hash-set 1 2 3))  ;clojure.lang.PersistentHashSet

;;; Control Flow

(def x "Hello Clojure")  ;#'learnclojure/x

(let [x "Steve"]
  (print "Hello, " x))
; Hello, Steve

;; if
(if (empty? x)
  "X is empty"
  "X is not empty")
;"X is not empty"

(if nil 
  "Yes" 
  "No")
;"No"

(if (empty? x)
  nil
  (do
    (println "Ok")
    :ok))
;Ok
;:ok

;; if-not lets us do away with nil logic branch
(if-not (empty? x)
  (do
    (println "Ok")
    :ok))
;Ok
;:ok

;; when-not is like if-not with an implicit do
(when-not (empty? x)
  (println "Ok")
  :ok)
;Ok
;:ok

;; when is inverse of when-not
(when (not (empty? x)) :ok)
;:ok

;; case is for basic pattern matching
(def x "Hello")  ;#'learnclojure/x
(case x
  "Goodbye" :goodbye
  "Hello" :hello
  :nothing)
;:hello

(case x
  "Goodbye" :goodbye
  "Hi" :hello
  :nothing)
;nothing

;; cond
(cond 
  (= x "Goodbye") :goodbye
  (= (reverse x) "olleH") :olleh
  :otherwise :nothing)
;:nothing

(apply str (reverse x))
;"olleH"
(cond 
  (= x "Goodbye") :goodbye
  (= (apply str (reverse x)) "olleH") :olleh
  :otherwise :nothing)
;:olleh

;;; Functions

;; declare anonymous function
(fn [] "Hello")
;#object[learnclojure$eval2100$fn__2101 0x34e1d70d "learnclojure$eval2100$fn__2101@34e1d70d"]

(type (fn [] "Hello"))
;learnclojure$eval2104$fn__2105

;; invoke anonymous function
((fn [] "Hello"))
"Hello"

(def hello (fn [] "Hello"))
;#'learnclojure/hello
(hello)
;"Hello"

;; shorthand for anonymous function
(#(str "Hello"))
;"Hello"

;; define named function
(defn hello [] "Hello")
;#'learnclojure/hello

;; define function with arg
(defn hello [name] (str "Hello, " name))
;#'learnclojure/hello
(hello "Jane")
;"Hello, Jane"

;; define function with multiple args
(defn hello [name, title] (str "Hello, " title " " name))
;#'learnclojure/hello
(hello "Frances" "Admiral")
;"Hello, Admiral Frances"

;; add doc string
(defn hello 
  "Greets a person named <name> with their <title>"
  [name, title]
  (str "Hello, " title " " name))
;#'learnclojure/hello

(require '[clojure.repl :refer [doc]])  ;nil
(doc hello)
;-------------------------
;learnclojure/hello
;([name title])
;  Greets a person named <name> with their <title>
;nil

;; varargs
(defn hello [& args] (str "Hello," (apply str args)))
;#'learnclojure/hello

(hello "Fred" "Julie")
;"Hello,FredJulie"

(defn hello
  ([] "Hello, World")
  ([name] (str "Hello, " name)))
;#'learnclojure/hello
(hello)
;"Hello, World"
(hello "Steve")
;"Hello, Steve"

;"Hello, World"
(defn hello
  ([] (hello "World"))
  ([name] (str "Hello, " name)))
;#'learnclojure/hello
(hello)
;"Hello, World"

;; destructuring
(defn hello [config]
  (str "Hello, " (:name config)))
;#'learnclojure/hello
(hello {:name "Joe"})
;"Hello, Joe"

(defn hello [{name :name}]
  (str "Hello, " name))
;#'learnclojure/hello
(hello {:name "Joe"})
;"Hello, Joe"

(defn hello [[name title]]
  (str "Hello, " title " " name))
;#'learnclojure/hello
(hello ["Lucy" "Admiral"])
;"Hello, Admiral Lucy"

;;; Collections

;; list
(def x (list 1 2 3))
;#'learnclojure/x
(cons 0 x)
;(0 1 2 3)
x
;(1 2 3)

(first x)   ;1
(last x)    ;3
(nth x 1)   ;2

(cons 0 x)  ;(0 1 2 3)
(conj x 0)  ;(0 1 2 3)

;; vector
(def v [1 2 3])

(first v)  ;1
(last v)   ;3
(nth v 1)  ;2

(cons 0 v)  ;(0 1 2 3)
(conj v 0)  ;[1 2 3 0]

(concat x v)  ;(1 2 3 1 2 3)
(type (concat x v))  ;clojure.lang.LazySeq

;; map
(def m {:a 1 :b 2})
;#'learnclojure/m
(type m)
;clojure.lang.PersistentArrayMap
(array-map :a 1 :b 2)  ;{:a 1, :b 2}
(hash-map :a 1 :b 2)   ;{:b 2, :a 1}

(assoc {:a 1} :b 2)    ;{:a 1, :b 2}
(assoc-in {:settings {:a 1 :b 2}} [:settings :a] "a")
;{:settings {:a "a", :b 2}}

(update-in {:settings {:a 1 :b 2}} [:settings :a] inc)
;{:settings {:a 2, :b 2}}

(get m :a)  ;1
(:a m)      ;1
(m :a)      ;1, can break if m is nil

;; set
(def s #{1 2 3})
;#'learnclojure/s
(conj s 4)
;#{1 4 3 2}

(disj s 3)
;#{1 2}
(contains? s 3)
;true

(get s 3)  ;3
(get s 4)  ;nil

;;; Recursion
;def my_sum(vals):
;  total = 0
;  for val in vals:
;    total += val
;  return val

(defn my-sum [total vals]
  (if (empty? vals)
    total
    (my-sum (+ (first vals) total) (rest vals))))
;#'learnclojure/my-sum
(my-sum 0 [0 1 2 3 4])  ;10

(defn my-sum
  ([vals] (my-sum 0 vals))
  ([total vals] 
   (if (empty? vals)
     total
     (my-sum (+ (first vals) total) (rest vals)))))
;#'learnclojure/my-sum
(my-sum [0 1 2 3 4])  ;10

(defn my-sum
  ([vals] (my-sum 0 vals))
  ([total vals] 
   (if (empty? vals)
     total
     (recur (+ (first vals) total) (rest vals)))))
;#'learnclojure/my-sum
(my-sum [0 1 2 3 4])  ;10

(defn my-sum [vals]
  (loop [total 0 vals vals]
    (if (empty? vals)
      total
      (recur (+ (first vals) total) (rest vals)))))
;#'learnclojure/my-sum
(my-sum [0 1 2 3 4])  ;10

(reduce (fn [total vals] (+ total vals)) 0 [0 1 2 3 4])
;10

(defn summer [total val] (+ total val))
;#'learnclojure/summer
(reduce summer [0 1 2 3 4])
;10

(reduce + 0 [1 2 3 4])
;10

(reduce + [1 2 3 4])
;10

(defn filter-even [acc next-val]
  (if (even? next-val)
    (conj acc next-val)
    acc))
;#'learnclojure/filter-even
(reduce filter-even [] [0 1 2 3 4 5 6])
;[0 2 4 6]

(filter even? [0 1 2 3 4 5 6])
;[0 2 4 6]

(defn map-inc [acc next-val]
  (conj acc (inc next-val)))
;#'learnclojure/map-inc
(reduce map-inc [] [0 1 2 3 4 5 6])
;[1 2 3 4 5 6 7]

(map inc [0 1 2 3 4 5 6])
;[1 2 3 4 5 6 7]

(defn group-even [acc next-val]
(let [key (if (even? next-val) :even :odd)]
  (update-in acc [key] #(conj % next-val))))
;#'learnclojure/group-even
(reduce group-even {} [0 1 2 3 4 5 6])
;{:even (6 4 2 0), :odd (5 3 1)}

(group-by #(if (even? %) :even :odd) [0 1 2 3 4 5 6])
;{:even [0 2 4 6], :odd [1 3 5]}

