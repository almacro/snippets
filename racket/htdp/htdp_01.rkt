;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdp_01) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;#lang racket


;;; Exercise 2.1.1
;;; Find out whether DrRacket has operations
;;; for squaring a number
;(sqr N)
(sqr 4) ; -> 16

;(expt N 2)
(expt 4 2) ; -> 16

;;; for computing the sine of an angle
;(sin N) with N in radians
(sin 1.57) ; -> 0.9999996829318346
(sin -1.57) ; -> -0.9999996829318346

;;; for determining the maximum of two numbers
;(max N M)
(max -1 1) ; -> 1
(max 0 9) ; -> 9
(max -12 2) ; -> 2


;;; Exercise 2.1.2
;;; Evaluate:
;;;
;;;   (sqrt 4)
;;;   (sqrt 2)
;;;   (sqrt -1)
;;;
;;;
;;; in DrRacket.
(sqrt 4) ; -> 2
(sqrt 2) ; -> 1.4142135623730951
(sqrt -1) ; -> 0+1i

;;; Then find out if DrRacket knows an operation for
;;; determining the tangent of an angle
; the operation for determining the tangent of an angle is `tan`
(tan (/ pi 4)) ; -> 0.9999999999999999
(tan (/ pi 3)) ; -> 1.7320508075688767

(define (area-of-disk r)
  (* 3.14 (* r r)))

(define (area-of-ring outer inner)
  (- (area-of-disk outer)
     (area-of-disk inner)))


;;; Exercise 2.2.1
;;; Define the program `Fahrenheit->Celsius`, which consumes a temperature
;;; measured in Fahrenheit and produces the Celsius equivalent.
;;; Use a chemistry or physics book to look up the conversion formula.
;;; e.g.,
;;; https://www.nist.gov/pml/weights-and-measures/si-units-temperature
(define (Fahrenheit->Celsius temp)
  (/ (- temp 32) 1.8))

(convert-gui Fahrenheit->Celsius)
