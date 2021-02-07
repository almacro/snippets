;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdp_03) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;;;   Programmers are rarely handed mathematical expressions to turn into programs. Instead they
;;;   typically receive informal problem descriptions that often contain irrelevant and sometimes
;;;   ambiguous information. The programmers' first task is to extract the relevant information
;;;   and then to formulate appropriate expressions.

;;;   Here is a typical example:

;;;     Company XYZ & Co. pays all its employees $12 per hour. A typical employee works between
;;;     20 and 65 hours per week. Develop a program that determines the wage of an employee from
;;;     the number of hours of work.

;;;   The last sentence is the first to mention the actual task: to write a program that
;;;   determines one quantity based on some other quantity. More specifically, the program
;;;   consumes one quantity, the number of hours of work, and produces another one, the wage in
;;;   dollars. The first sentence implies how to compute the result, but doesn't state it
;;;   explicitly. In this particular example, though, this poses no problem. If an employee works
;;;   h hours, the wage is

;;;     $$ w = h \times 12 $$

;;;   Now that we have a rule, we can formulate a Scheme program:

(define (wage h)
  (* 12 h))

;;;   The program is called wage; its parameter h stands for the hours an employee works; and its
;;;   result is (* 12 h), the corresponding wage.


;;; Exercise 2.3.1
;;; Utopia's tax accountants always use programs that compute income taxes
;;; even though the tax rate is a solid, never-changing 15%.
;;; Define the program `tax`, which determines the tax on the gross pay.
(define (tax g)
  (* 0.15 g))

;;; Also define netpay. The program determines the net pay of an employee from the number of
;;; hours worked. Assume an hourly rate of $12.
(define (netpay h)
  (- (wage h) (tax (wage h))))


;;; Exercise 2.3.2
;;; The local supermarket needs a program that can compute the value of a bag
;;; of coins. Define the program sum-coins. It consumes four numbers: the number of pennies,
;;; nickels, dimes, and quarters in the bag; it produces the amount of money in the bag.
(define (sum-coins pennies nickels dimes quarters)
  (+ (* .01 pennies)
     (* .05 nickels)
     (* .10 dimes)
     (* .25 quarters)))

;;; Exercise 2.3.3
;;; An old-style movie theater has a simple profit function. Each customer
;;; pays $5 per ticket. Every performance costs the theater $20, plus $.50 per attendee.
;;; Develop the function total-profit. It consumes the number of attendees (of a show) and
;;; produces how much income the attendees produce.
(define (total-profit n)
  (- (* 5 n) (+ 20 (* .5 n))))
