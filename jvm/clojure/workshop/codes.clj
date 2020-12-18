;;; Develop an `encode` function and a `decode` function. The `encode`
;;; function should replace letters with numbers that are not easily
;;; guessable. For that purpose, each letter will take the character's
;;; number value in the ASCII table, add another number to it (the
;;; number of words in the sentence to encode), and finally, compute
;;; the square value of that number. The `decode` function should
;;; revert to the original string.

(defn encode-letter
  [s x]
  (let [code (Math/pow (+ x (int (first (char-array s)))) 2)]
    (str "#" (int code))))

(defn encode
  [s]
  (let [number-of-words (count (clojure.string/split s #" "))]
    (clojure.string/replace
     s
     #"\w"
     (fn [s] (encode-letter s number-of-words)))))

(defn decode-letter
  [x y]
  (let [number (Integer/parseInt (subs x 1))
        letter (char (- (Math/sqrt number) y))]
  (str letter)))

(defn decode
  [s]
  (let [number-of-words (count (clojure.string/split s #" "))]
    (clojure.string/replace
     s
     #"\#\d+"
     (fn [s] (decode-letter s number-of-words)))))
