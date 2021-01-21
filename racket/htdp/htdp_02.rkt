;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdp_02) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;;; Exercise 2.2.1
;;; Define the program `Fahrenheit->Celsius`, which consumes a temperature
;;; measured in Fahrenheit and produces the Celsius equivalent.
;;; Use a chemistry or physics book to look up the conversion formula.
;;; e.g.,
;;; https://www.nist.gov/pml/weights-and-measures/si-units-temperature
(define (Fahrenheit->Celsius temp)
  (/ (- temp 32) 1.8))

;;; When the function is fully developed, test it using the teachpack convert.rkt.
;;; The teachpack provides three functions:
;;; * convert-gui
;;; * convert-repl
;;; * convert-file
;(convert-gui Fahrenheit->Celsius)

;(convert-repl Fahrenheit->Celsius)

;(convert-file "in.dat" Fahrenheit->Celsius "out.dat")

;;; Exercise 2.2.2
;;; Define the program `dollar->euro`, which consumes a number of dollars and
;;; produces the euro equivalent. Use the currency table in the newspaper to look
;;; up the current exchange rate, e.g.:
;;;   https://finance.yahoo.com/quote/EURUSD%3DX?p=EURUSD%3DX
(define (dollar->euro dollars)
  (* 0.822774 dollars))

;;; Exercise 2.2.3.   Define the program `triangle`. It consumes the length of
;;; a triangle's side and the perpendicular height. The program produces the area
;;; of the triangle. Use a geometry book to look up the formula for computing the
;;; area of a triangle.
(define (triangle base height)
  (* 0.5 base height))

;;; Exercise 2.2.4.   Define the program convert3. It consumes three digits,
;;; starting with the least significant digit, followed by the next most significant
;;; one, and so on. The program produces the corresponding number.
;;; For example, the expected value of
;;;   (convert3 1 2 3)
;;; is 321.
;;; Use an algebra book to find out how such a conversion works. 
(define (convert3 d1 d2 d3)
  (+ (* 100 d3) (* 10 d2) d1))

;;; Exercise 2.2.5
;;; A typical exercise in an algebra book asks the reader to evaluate an
;;; expression like
;;;   $$ \frac{n}{3} + 2 $$
;;; for n = 2, n = 5, and n = 9.
;;; Using Scheme, we can formulate such an expression as a program and use
;;; the program as many times as necessary.
;;; Here is the program that corresponds to the above expression:
(define (f n)
  (+ (/ n 3) 2))
;;; First determine the result of the expression at n = 2, n = 5, and n = 9
;;; by hand, then with DrScheme's stepper.
;(f 2) ; -> 8/3
;(f 5) ; -> 11/3
;(f 9) ; -> 5

;;; Also formulate the following three expressions as programs
;;; 1. n^2 + 10
(define (g n)
  (+ (* n n) 10))
;(g 2) ; -> 14
;(g 5) ; -> 35
;(g 9) ; -> 91
;;; 2. (1/2)   n^2 + 20
(define (p n)
  (+ (* 1/2 n n) 20))
;(p 2) ; -> 22
;(p 5) ; -> 65/2
;(p 9) ; -> 121/2
;;; 3. 2 - (1/n)
(define (q n)
  (- 2 (/ 1 n)))
;(q 2) ; -> 3/2
;(q 5) ; -> 9/5
;(q 9) ; -> 17/9
