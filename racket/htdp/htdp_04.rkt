;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdp_04) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;;; Exercise 2.4.1.
;;; Evaluate the following sentences in DrScheme, one at a time:

;; (+ (10) 20)
;;  function call: expected a function after the open parenthesis, but found a number
;;  10 is not a function

;; (10 + 20)
;;  function call: expected a function after the open parenthesis, but found a number
;;  10 is not a function, infix is not scheme syntax

;; (+ +)
;;  +: expected a function call, but there is no open parenthesis before this function
;;  syntax for a call to + does not parse

;;; Exercise 2.4.2.   Enter the following sentences, one by one, into DrScheme's Definitions
;;; window and click Execute:

;; orig
;; (define (f 1)
;;   (+ x 10))
;;  define: expected a variable, but found a number
;; fix-1
;; (define (f x)
;;   (+ x 10))

;; orig
;; (define (g x)
;;   + x 10)
;;  define: expected only one expression for the function body, but found 2 extra parts
;; fix-1
;; (define (g x)
;;   (+ x 10)
;;  read-syntax: expected a `)` to close `(`
;; fix-2
;; (define (g x)
;;   (+ x 10))

;; orig
;;  (define h(x)
;;    (+ x 10))

;;; Read the error messages, fix the offending definition in an appropriate manner, and repeat
;;; until all definitions are legal.