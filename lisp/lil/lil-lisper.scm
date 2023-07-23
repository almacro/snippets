(define (atom? x) (not (pair? x)))

;;; Is it true that this is an atom?
;;;   atom
(atom? 'atom)

;;; Is it true that this is an atom?
;;;   turkey
(atom? 'turkey)

;;; Is it true that this is an atom?
;;;   1492
(atom? '1492)

;;; Is it true that this is an atom?
;;;   3turkeys
(atom? '3turkeys)

;;; Is it true that this is an atom?
;;;   u
(atom? 'u)

;;; Is it true that this is an atom?
;;;   *abc$
(atom? '*abc$)

;;; Is it true that this is a list?
;;;   (atom)
(list? '(atom))

;;; Is it true that this is a list?
;;;   (atom turkey or)
(list? '(atom turkey or))

;;; Is it true that this is a list?
;;;   (atom turkey) or
(list? '(atom turkey) or)

;;; Is it true that this is a list?
;;;   ((atom turkey) or)
(list? '((atom turkey) or))

;;; Is it true that this is an S-expression?
;;;   xyz
(or (atom? 'xyz) (list? 'xyz))

;;; Is it true that this is an S-expression?
;;;   (x y z)
(or (atom? '(x y z)) (list? '(x y z)))

;;; Is it true that this is an S-expression?
;;;   ((x y) z)
(or (atom? '((x y) z)) (list? '((x y) z)))

;;; Is it true that this is a list?
;;;   (how are you doing so far)
(list? '(how are you doing so far))

;;; How many S-expressions are in the list
;;;   (how are you doing so far)
;;; and what are they?
(apply + 
       (map (lambda (x) (if x 1 0))
	    (map (lambda (x) (or (atom? x) (list? x)))
		 '(how are you doing so far))))

;;; Is it true that this is a list?
;;;   (((how) are) ((you) (doing so)) far)
(list? '(((how) are) ((you) (doing so)) far))

;;; How many s-expressions are in the list
;;;   (((how) are) ((you) (doing so)) far)
;;; and what are they?
(apply + 
       (map (lambda (x) (if x 1 0))
	    (map (lambda (x) (or (atom? x) (list? x)))
		 '(((how) are) ((you) (doing so)) far))))

;;; Is it true that this is a list?
;;;   ()
(list? '())

;;; Is it true that this is an atom?
;;;   ()
(atom? '())

;;; Is it true that this is a list?
;;;   (() () () ())
(list? '(() () () ()))

;;; What is the car of L, where L is the argument
;;;   (a b c)
(let ((L '(a b c)))
  (car L))

;;; What is the car of L, where L is the argument
;;;   ((a b c) x y z)
(let ((L '((a b c) x y z)))
  (car L))

;;; what is the car of L, where L is the argument
;;;   hotdog
(let ((L hotdog))
  (car L))

;;; *******************************************
;;; * The Law of Car                          *
;;; *                                         *
;;; * Car is defined only for non-null lists. *
;;; *******************************************

;;; What is the car of L, where L is the argument
;;;   (((hotdogs)) (and) (pickle) relish)
(let ((L '(((hotdogs)) (and) (pickle) relish)))
  (car L))

;;; What is (car L), where L is the argument
;;;   (((hotdogs)) (and) (pickle) relish)
(let ((L '(((hotdogs)) (and) (pickle) relish)))
  (car L))

;;; What is (car (car L)), where L is the argument
;;;   (((hotdogs)) (and) (pickle) relish)
(let ((L '(((hotdogs)) (and) (pickle) relish)))
  (car (car L)))

;;; What is (car (car L)), where L is the argument
;;;   (((hotdogs)) (and))
(let ((L '(((hotdogs)) (and))))
  (car (car L)))

;;; What is the cdr of L, where L is the argument
;;;   (a b c)
(let ((L '(a b c)))
  (cdr L))

;;; What is the cdr of L, where L is the argument
;;;   ((a b c) x y z)
(let ((L '((a b c) x y z)))
  (cdr L))

;;; What is (cdr A), where A is the argument
;;;   hotdogs
(let ((A 'hotdogs))
  (cdr A))

;;; What is (cdr L), where L is the argument
;;;   ()
(let ((L '()))
  (cdr L))

;;; *******************************************
;;; * The Law of Cdr                          *
;;; *                                         *
;;; * Cdr is defined only for non-null lists. *
;;; * The cdr of any non-null list is always  *
;;; * another list.                           * 
;;; *******************************************

;;; What is (car (cdr L)) where L is the argument
;;;   ((b) (x y) ((c)))
(let ((L '((b) (x y) ((c)))))
  (car (cdr L)))

;;; What is (cdr (cdr L)) where L is the argument
;;;   ((b) (x y) ((c)))
(let ((L '((b) (x y) ((c)))))
  (cdr (cdr L)))

;;; What is (cdr (car L)) where L is the argument
;;;   (a (b (c)) d)
(let ((L '(a (b (c)) d)))
  (cdr (car L)))

;;; What does car take as an argument?
;;; It takes any non null list as its argument
;;;
;;; (car LIST)
;;; Return the car of LIST.  If arg is nil, return nil.
;;; Error if arg is not nil and not a cons cell.

;;; What does cdr take as an argument?
;;; It takes any non null list as its argument
;;;
;;; (cdr LIST)
;;; Return the cdr of LIST.  If arg is nil, return nil.
;;; Error if arg is not nil and not a cons cell.

;;; What is the cons of the atom A and the list L, where
;;;   a is the argument: peanut
;;;   and L is the argument: (butter and jelly)
(let ((A 'peanut)
      (L '(butter and jelly)))
  (cons A L))

;;; What is the cons of S and L, where
;;;   S is: (mayonnaise and)
;;;   and L is: (peanut butter and jelly)
(let ((S '(mayonnaise and))
      (L '(peanut butter and jelly)))
  (cons S L))

;;; What is (cons S L), where
;;;   S is: ((help) this)
;;;   and L is: (is very ((hard) to learn))
(let ((S '((help) this))
      (L '(is very ((hard) to learn))))
  (cons S L))

;;; What does cons take as its arguments?
;;; cons taks two arguments
;;;   the first one is any S-expression
;;;   the second one is any list
;;;
;;; (cons CAR CDR)
;;; Create a new cons, give it CAR and CDR as components, and return it.

;;; What is (cons S L), where
;;;   S is: (a b (c))
;;;   and L is: ()
(let ((S '(a b (c)))
      (L '()))
  (cons S L))

;;; What is (cons S L) where
;;;   S is: a
;;;   and L is: ()
(let ((S 'a)
      (L '()))
  (cons S L))

;;; What is (cons S L), where
;;;   S is: a
;;;   and L is: b
(let ((S 'a)
      (L 'b))
  (cons S L))

;;; *******************************************
;;; * The Law of Cons                         *
;;; *                                         *
;;; * Cons takes two arguments. The second    *
;;; * argument of cons must be a list. The    *
;;; * result is a list.                       * 
;;; *******************************************

;;; What is (cons S (car L)), where
;;;   S is: a
;;;   and L is: ((b) c d)
(let ((S 'a)
      (L '((b) c d)))
  (cons S (car L)))

;;; What is (cons S (cdr L))
;;;   S is: a
;;;   and L is: ((b) c d)
(let ((S 'a)
      (L '((b) c d)))
  (cons S (cdr L)))

;;; Is it true that the list L is the null list, where
;;;   L is: ()
(let ((L '()))
  (null? L))

;;; Is (null L) true or false, where
;;;   L is: (a b c)
(let ((L '(a b c)))
  (null? L))

;;; Is (null A) true or false, where
;;;   A is: spaghetti
(let ((A 'spaghetti))
  (null? A))

;;; *******************************************
;;; * The Law of Null                         *
;;; *                                         *
;;; * Null is defined only for lists.         *
;;; *******************************************

;;; Is it true or false, that S is an atom, where
;;;   S is: Harry
(let ((S 'Harry))
  (atom? S))

;;; Is (atom? S) true or false, where
;;;   S is: Harry
(let ((S 'Harry))
  (atom? S))

;;; Is (atom? S) true or false, where
;;;   S is: (Harry had a heap of apples)
(let ((S '(Harry had a heap of apples)))
  (atom? S))

;;; How many arguments does ATOM? take,
;;; and what are they?
;;;
;;; It takes one argument
;;; The argument can be any S-expression

;;; Is (atom? (car l)) true or false, where
;;;   L is: (Harry had a heap of apples)
(let ((L '(Harry had a heap of apples)))
  (atom? (car L)))

;;; Is (atom? (cdr l)) true or false, where
;;;   L is: (Harry had a heap of apples)
(let ((L '(Harry had a heap of apples)))
  (atom? (cdr L)))

;;; Is (atom? (cdr l)) true or false, where
;;;   L is: (Harry)
(let ((L '(Harry)))
  (atom? (cdr L)))

;;; Is (atom? (car (cdr l))) true or false, where
;;;   L is: (swing low sweet cherry)
(let ((L '(swing low sweet cherry)))
  (atom? (car (cdr L))))

;;; Is (atom? (car (cdr l))) true or false, where
;;;   L is: (swing (low sweet) cherry)
(let ((L '(swing (low sweet) cherry)))
  (atom? (car (cdr L))))

;;; True or false: A1 and A2 are the same atom?, where
;;;   A1 is: Harry
;;;   and A2 is: Harry
(let ((A1 'Harry)
      (A2 'Harry))
  (eq? A1 A2))

;;; Is (eq? A1 A2) true or false, where
;;;   A1 is: margarine
;;;   and A2 is: butter
(let ((A1 'margarine)
      (A2 'butter))
  (eq? A1 A2))

;;; How many arguments does EQ? take
;;; and what are they?
;;;
;;; It takes two arguments
;;; Both of them must be atoms
;;;
;;; (eq? OBJ1 OBJ2)
;;; Return t if the two args are the same Lisp object.

;;; Is (eq? L1 L2) true or false, where
;;;   L1 is: ()
;;;   and L2 is: (strawberry)
(let ((L1 '())
      (L2 '(strawberry)))
  (eq? L1 L2))

;;; *******************************************
;;; * The Law of Eq?                           *
;;; *                                         *
;;; * Eq? takes two arguments. Each must be    *
;;; * an atom.                                *
;;; *******************************************

;;; Is (eq? (car L) A) true or false, where
;;;   L is: (Mary had a little lamb chop)
;;;   and A is: Mary
(let ((L '(Mary had a little lamb chop))
      (A 'Mary))
  (eq? (car L) A))

;;; Is (eq? (cdr L) A) true or false, where
;;;   L is: (soured milk)
;;;   and A is: milk
(let ((L '(soured milk))
      (A 'milk))
  (eq? (cdr L) A))

;;; Is (eq? (car L) (car (cdr L))) true or false, where
;;;   L is: (beans beans we need jelly beans)
(let ((L '(beans beans we need jelly beans)))
  (eq? (car L) (car (cdr L))))

;;; === EXERCISES ===
;;; 1.1 Think of ten different atoms and write them down
cesium
hydrogen
carbon
oxygen
helium
nitrogen
titanium
strontium
plutonium
uranium

;;; 1.2 Using the atoms of exercise 1.1, make up twenty different lists
(uranium plutonium)
(hydrogen oxygen oxygen)
(carbon oxygen oxygen)
(cesium strontium)
(hydrogen oxygen nitrogen)
(carbon titanium)
(hydrogen helium)
(plutonium strontium uranium nitrogen titanium oxygen carbon hydrogen cesium)
(cesium oxygen)
(carbon nitrogen oxygen)
(helium titanium)
(hydrogen uranium)
(nitrogen strontium)
(hydrogen oxygen nitrogen strontium uranium)
(cesium carbon helium titanium plutonium)
(carbon nitrogen plutonium)
(cesium helium nitrogen uranium)
(nitrogen plutonium strontium)
(uranium plutonium titanium)
(cesium hydrogen carbon oxygen helium nitrogen titanium strontium plutonium uranium)

;;; 1.3 The list (all these problems) can be constructed by
;;;   (cons A (cons B (cons C D)))
;;; where A is: all
;;;       B is: these
;;;       C is: problems
;;;   and D is: ()
;;; 
;;; Write down how you would construct the following lists:
;;;   (all (these problems))
(let ((A 'all)
      (B 'these)
      (C 'problems)
      (D '()))
  (cons A (cons (cons B (cons C D)) D)))

;;;   (all (these) problems)
(let ((A 'all)
      (B 'these)
      (C 'problems)
      (D '()))
  (cons A (cons (cons B D) (cons C D))))

;;;   ((all these) problems)
(let ((A 'all)
      (B 'these)
      (C 'problems)
      (D '()))
  (cons (cons A (cons B D)) (cons C D)))

;;;   ((all these problems))
(let ((A 'all)
      (B 'these)
      (C 'problems)
      (D '()))
  (cons (cons A (cons B (cons C D))) D))

;;; 1.4 What is (car (cons A L)), where
;;;   A is: french
;;;   L is: (fries)
(let ((A 'french)
      (L '(fries)))
  (car (cons A L)))

;;; and what is (cdr (cons A L)), where
;;;   A is: oranges
;;;   L is: (apples and peaches)
(let ((A 'oranges)
      (L '(apples and peaches)))
  (cdr (cons A L)))

;;; 1.5 Find an atom X that makes (eq? X Y) true, where
;;;   Y is: lisp
(let ((X (car '(lisp is fun)))
      (Y 'lisp))
  (eq? X Y))

;;; 1.6 If A is an atom, is there a list L that makes
;;;   (null (cons A L))
;;; true?
;;;
;;; No

;;; 1.7 Determine the value of
;;;   (cons S L) where
;;;   S is: x
;;;   L is: y
(let ((S 'x)
      (L 'y))
  (cons S L))

;;;   (cons S L) where
;;;   S is: ()
;;;   L is: ()
(let ((S '())
      (L '()))
  (cons S L))

;;;   (car S) where
;;;   S is: x
(let ((S 'x))
  (car S))

;;;   (cdr L) where
;;;   L is: (())
(let ((L '(())))
  (cdr L))

;;; True or false,
;;;   (atom? (car L)), where
;;;   L is: ((meatballs) and spaghetti)
(let ((L '((meatballs) and spaghetti)))
  (atom? (car L)))

;;;   (null? (cdr L)), where
;;;    L is: ((meatballs))
(let ((L '((meatballs))))
  (null? (cdr L)))

;;;   (eq? (car L) (car (cdr L))), where
;;;   L is: (two meatballs)
(let ((L '(two meatballs)))
  (eq? (car L) (car (cdr L))))

;;;   (atom? (cons A L)), where
;;;   L is: (ball)
;;;   A is: meat
(let ((L '(ball))
      (A 'meat))
  (atom? (cons A L)))

;;; Get the atom Harry in L,
;;;   where L is: (apples in (Harry has a backyard))
(let ((L '(apples in (Harry has a backyard))))
  (car (car (cdr (cdr L)))))

;;;   where L is: (apples and Harry)
(let ((L '(apples and Harry)))
  (car (cdr (cdr L))))

;;;   where L is (((apples) and ((Harry))) in his backyard)
(let ((L '(((apples) and ((Harry))) in his backyard)))
  (car (car (car (cdr (cdr (car L)))))))

;;; True of false: (lat? L)
;;; where L is: (Jack Sprat could eat no chicken fat)
;;;
;;; True,
;;; because each S-expression in L is an atom

;;; True of false: (lat? L)
;;; where L is: ((Jack) Sprat could eat no chicken fat)
;;;
;;; False,
;;; since (car L) is a list

;;; True of false: (lat? L)
;;; where L is: (Jack (Sprat could) eat no chicken fat)
;;;
;;; False,
;;; since one of the S-expressions in L is a list

;;; True of false: (lat? L)
;;; where L is: ()
;;;
;;; True,
;;; because () contains no lists and because it does not
;;; contain any lists, it is a LAT

;;; True of false:
;;;   a LAT is a list of atoms

;;; Write the function LAT? using some, but not necessarily all,
;;; of the following functions:
;;;   car cdr cons null atom? eq?

(define lat?
  (lambda (l)
    (cond
     ((null? l) #t)
     ((atom? (car l)) (lat? (cdr l)))
     (#t #f))))

;;; The application (lat? L), where
;;;   L is: (lat '(bacon and eggs))
;;;
;;; has the value t--true--because L is a LAT
(lat? '(bacon and eggs))

;;; How do you determine the answer t for the application?:
;;;   (lat? L)

;;; What is the first question asked by (lat L)
;;;
;;; (null? L)

;;; What is the meaning of the COND-LINE
;;;   ((null? L) t)
;;;
;;; where L is: (bacon and eggs)

;;; What is the next question?
;;;
;;; (atom? (car L))

;;; What is the meaning of the line
;;;   ((atom? (car L)) (lat (cdr L)))
;;;
;;; where L is: (bacon and eggs)

;;; What is the meaning of
;;;   (lat? (cdr L))

;;; This is the function MEMBER?
(define member?
  (lambda (a lat)
    (cond
     ((null? lat) #f)
     (#t (or
	  (eq? (car lat) a)
	  (member? a (cdr lat)))))))

;;; What is the value of
;;;  (member? A LAT)
;;; where A is: meat
;;; and LAT is: (mashed potatoes and meat gravy)
(let ((A 'meat)
      (LAT '(mashed potatoes and meat gravy)))
  (member? A LAT))

;;; *******************************************
;;; * The First Commandment                   *
;;; *                                         *
;;; * Always ask NULL as the first question   *
;;; * in expressing any function.             *
;;; *******************************************

;;; === EXERCISES ===
;;; For these exercises,
;;;   L1 is: (german chocolate cake)
;;;   L2 is: (poppy seed cake)
;;;   L3 is: ((linzer) (torte) ())
;;;   L4 is: ((bleu cheese) (and) (red) (wine))
;;;   L5 is: (() ())
;;;   A1 is: coffee
;;;   A2 is: seed
;;;   A3 is: poppy

;;; 2.1 What are the values of
;;;   (lat? L1)
(let ((L1 '(german chocolate cake)))
  (lat? L1))

;;;   (lat? L2)
(let ((L2 '(poppy seed cake)))
  (lat? L2))

;;;   (lat? L3)
(let ((L3 '((linzer) (torte) ())))
  (lat? L3))

;;; 2.2 For each case in Exercise 2.1 step through the application
;;;     as we did in this chapter

;;; 2.3 What is the value of
;;;   (member? A1 L1)
(let ((A1 'coffee)
      (L1 '(german chocolate cake)))
  (member? A1 L1))

;;;   (member? A2 L2)
(let ((A2 'seed)
      (L2 '(poppy seed cake)))
  (member? A2 L2))

;;; 2.4 Rewrite all the functions in the chapter using IF instead of COND

(define lat?
  (lambda (l)
    (if (null? l)
	#t
	(and (atom? (car l))
	     (lat? (cdr l))))))

(define member?
  (lambda (a lat)
    (if (null? lat)
	#f
	(or
	 (eq? (car lat) a)
	 (member? a (cdr lat))))))

;;; 2.5 Write the function NONLAT? which determines whether a list is the
;;;     empty list or does not contain S-expressions

(define nonlat?
  (lambda (l)
    (if (null? l)
	#t
	(and (list? (car l))
	     (nonlat? (cdr l))))))

;;;   (nonlat? L1)
(let ((L1 '(german chocolate cake)))
  (nonlat? L1))

;;;   (nonlat? L2)
(let ((L2 '(poppy seed cake)))
  (nonlat? L2))

;;;   (nonlat? L3)
(let ((L3 '((linzer) (torte) ())))
  (nonlat? L3))

;;;   (nonlat? L4)
(let ((L4 '((bleu cheese) (and) (red) (wine))))
  (nonlat? L4))

;;;   (nonlat? L5)
(let ((L5 '(() ())))
  (nonlat? L5))

;;; 2.6 Write a function MEMBER-CAKE? which determines whether a LAT
;;;     contains the atom CAKE

(define member-cake?
  (lambda (l)
    (if (null? l)
	#f
	(let ((m (car l)))
	  (or (and (atom? m) (eq? m 'cake))
	      (member-cake? (cdr l)))))))

;;;   (member-cake? L1)
(let ((L1 '(german chocolate cake)))
  (member-cake? L1))

;;;   (member-cake? L2)
(let ((L2 '(poppy seed cake)))
  (member-cake? L2))

;;;   (member-cake? L3)
(let ((L3 '((linzer) (torte) ())))
  (member-cake? L3))

;;;   (member-cake? L4)
(let ((L4 '((bleu cheese) (and) (red) (wine))))
  (member-cake? L4))

;;;   (member-cake? L5)
(let ((L5 '(() ())))
  (member-cake? L5))

;;; 2.7 Consider the following definition of MEMBER?
(define member2?
  (lambda (a lat)
    (cond
     ((null? lat) #f)
     (#t (or
	  (member2? a (cdr lat))
	  (eq? a (car lat)))))))

;;; Do (member2? A L) and (member? A L) give the same answer when we
;;;     use the same arguments?
;;; Consider the examples A1 and L1, A1 and L2, and A2 and L2

;;;   (member? A1 L1)
(let ((A1 'coffee)
      (L1 '(german chocolate cake)))
  (member? A1 L1))

;;;   (member2? A1 L1)
(let ((A1 'coffee)
      (L1 '(german chocolate cake)))
  (member2? A1 L1))

;;;   (member? A1 L2)
(let ((A1 'coffee)
      (L2 '(poppy seed cake)))
  (member? A1 L2))

;;;   (member2? A1 L2)
(let ((A1 'coffee)
      (L2 '(poppy seed cake)))
  (member2? A1 L2))

;;;   (member? A2 L2)
(let ((A2 'seed)
      (L2 '(poppy seed cake)))
  (member? A2 L2))

;;;   (member2? A2 L2)
(let ((A2 'seed)
      (L2 '(poppy seed cake)))
  (member2? A2 L2))

;;; 2.9 What happens when you step through (member? A2 L3)?
;;;     Fix this problem by having MEMBER? ignore lists

(define member?
  (lambda (a lat)
    (cond
     ((null? lat) #f)
     (#t (let ((e (car lat)))
	   (or
	    (and (atom? e) (eq? e a))
	    (member? a (cdr lat))))))))

;;;   (member? A2 L3)
(let ((A2 'seed)
      (L3 '((linzer) (torte) ())))
  (member? A2 L3))


;;; 2.10 The function MEMBER? tells whether some atom appears at least
;;;      once in a LAT. Write a function MEMBER-TWICE? which tells
;;;      whether some atom appears at least twice in a LAT. 

(define member-twice?
  (lambda (a lat)
    (cond
     ((null? lat) #f)
     (#t (cond
	  ((eq? (car lat) a) (member? a (cdr lat)))
	  (#t (member-twice? a (cdr lat))))))))

(let ((A3 'chocolate)
      (L1 '(german chocolate chocolate cake)))
  (member-twice? A3 L1))

(let ((A3 'chocolate)
      (L1 '(german chocolate cake)))
  (member-twice? A3 L1))

(let ((A3 'chocolate))
  (member-twice? A3 '()))

(let ((A 'boom)
      (L '(the boom boom room)))
  (member-twice? A L))

(let ((A 'room)
      (L '(the boom boom room)))
  (member-twice? A L))

(let ((A 'room)
      (L '(the boom boom room room)))
  (member-twice? A L))

;;; *******************************************
;;; *          Cons The Magnificent           *
;;; *******************************************

;;; first try
(define rember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     (#t (cond
	  ((eq? (car lat) a) (cdr lat))
	  (#t (rember a (cdr lat))))))))

;;; What is the value of (rember A LAT) where
;;;   A is: 'bacon
;;;   LAT is: (bacon lettuce and tomato)
(let ((A 'bacon)
      (LAT '(bacon lettuce and tomato)))
  (rember A LAT))

(let ((A 'and)
      (LAT '(bacon lettuce and tomato)))
  (rember A LAT))

;;; *******************************************
;;; * The Second Commandment                  *
;;; *                                         *
;;; * Use cons to build lists.                *
;;; *******************************************

;;; second try
(define rember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     (#t (cond
	  ((eq? (car lat) a) (cdr lat))
	  (#t (cons (car lat)
		   (rember a (cdr lat)))))))))

;;; What is the value of (rember A LAT) where
;;;   A is: 'and
;;;   LAT is: (bacon lettuce and tomato)
(let ((A 'and)
      (LAT '(bacon lettuce and tomato)))
  (rember A LAT))

;;; third try, simplify
(define rember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) a) (cdr lat))
     (#t (cons (car lat)
	       (rember a (cdr lat)))))))

;;; What is the value of (rember A LAT) where
;;;   A is: 'sauce
;;;   LAT is: (soy sauce and tomato sauce)
(let ((A 'sauce)
      (LAT '(soy sauce and tomato sauce)))
  (rember A LAT))

(define firsts
  (lambda (l)
    (cond
     ((null? l) '())
     (#t (cons (car (car l))
	       (firsts (cdr l)))))))

;;; What is (firsts L), where
;;;   L is: ((apple peach pumpkin)
;;;          (plum pear cherry)
;;;          (grape raisin pea)
;;;          (bean carrot eggplant))
(let ((L '((apple peach pumpkin)
          (plum pear cherry)
          (grape raisin pea)
          (bean carrot eggplant))))
  (firsts L))

;;; What is (firsts L), where
;;;   L is: ((a b) (c d) (e f))
(let ((L '((a b) (c d) (e f))))
  (firsts L))

;;; What is (firsts L), where
;;;   L is: ()
(let ((L '()))
  (firsts L))

;;; What is (firsts L), where
;;;   L is: ((five plums) (four) (eleven green oranges))
(let ((L '((five plums) (four) (eleven green oranges))))
  (firsts L))

(define seconds
  (lambda (l)
    (cond
     ((null? l) '())
     (#t (cons (car (cdr (car l)))
	       (seconds (cdr l)))))))

;;; Consider the function seconds.
;;; What is (seconds L), where
;;;   L is: ((a b) (c d) (e f))
(let ((L '((a b) (c d) (e f))))
  (seconds L))

;;; ********************************************
;;; * The Third Commandment                    *
;;; *                                          *
;;; * When building a list, describe the first *
;;; * typical element, and then cons it onto   *
;;; * the natural recursion.                   *
;;; ********************************************

(define insertR
  (lambda (new old lat)
  (cond
   ((null? lat) '())
   (#t (cond
	((eq? (car lat) old) (cons old (cons new (cdr lat))))
	(#t (cons (car lat) (insertR new old (cdr lat)))))))))

;;; What is (insertR NEW OLD LAT), where
;;;   NEW is: topping
;;;   OLD is: fudge
;;;   and LAT is: (ice cream with fudge for dessert)
(let ((NEW 'topping)
      (OLD 'fudge)
      (LAT '(ice cream with fudge for dessert)))
  (insertR NEW OLD LAT))

;;; (insertR NEW OLD LAT), where
;;;   NEW is: jalapeño
;;;   OLD is: and
;;;   and LAT is: (tacos tamales and salsa)
(let ((NEW 'jalapeño)
      (OLD 'and)
      (LAT '(tacos tamales and salsa)))
  (insertR NEW OLD LAT))

;;; (insertR NEW OLD LAT), where
;;;   NEW is: e
;;;   OLD is: d
;;;   and LAT is: (a b c d f g d h)
(let ((NEW 'e)
      (OLD 'd)
      (LAT '(a b c d f g d h)))
  (insertR NEW OLD LAT))

(define insertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     (#t (cond
	  ((eq? (car lat) old) (cons new lat))
	  (#t (cons (car lat) (insertL new old (cdr lat)))))))))

;;; (insertL NEW OLD LAT), where
;;;   NEW is: jalapeño
;;;   OLD is: and
;;;   and LAT is: (tacos tamales and salsa)
(let ((NEW 'jalapeño)
      (OLD 'and)
      (LAT '(tacos tamales and salsa)))
  (insertL NEW OLD LAT))

(define subst
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     (#t (cond
	 ((eq? (car lat) old) (cons new (cdr lat)))
	 (#t (cons (car lat) (subst new old (cdr lat)))))))))

;;; (subst NEW OLD LAT), where
;;;   NEW is: jalapeño
;;;   OLD is: and
;;;   and LAT is: (tacos tamales and salsa)
(let ((NEW 'jalapeño)
      (OLD 'and)
      (LAT '(tacos tamales and salsa)))
  (subst NEW OLD LAT))

(define subst2
  (lambda (new o1 o2 lat)
    (cond
     ((null? lat) '())
     (#t (cond
	  ((or (eq? (car lat) o1)
	       (eq? (car lat) o2))
	   (cons new (cdr lat)))
	  (#t (cons (car lat) (subst2 new o1 o2 (cdr lat)))))))))

;;; (subst2 NEW O1 O2), where
;;;   NEW is: vanilla
;;;   O1 is: chocolate
;;;   O2 is: banana
;;;   and LAT is: (banana ice cream with chocolate topping)
(let ((NEW 'vanilla)
      (O1 'chocolate)
      (O2 'banana)
      (LAT '(banana ice cream with chocolate topping)))
  (subst2 NEW O1 O2 LAT))

;;; === EXERCISES ===
;;; For these exercises,
;;;   L1 is: ((paella spanish) (wine red) (and beans))
;;;   L2 is: ()
;;;   L3 is: (cincinnati chili)
;;;   L4 is: (texas hot chili)
;;;   L5 is: (soy sauce and tomato sauce)
;;;   L6 is: ((spanish) () (paella))
;;;   L7 is: ((and hot) (but dogs))
;;;   A1 is: chili
;;;   A2 is: hot
;;;   A3 is: spicy
;;;   A4 is: sauce
;;;   A5 is: soy

;;; 3.1 Write the function SECONDS which takes a list of lats
;;;   and makes a new lat consisting of second atom from each
;;;   lat in the list
(define seconds
  (lambda (l)
    (cond
     ((null? l) '())
     (#t (cons (car (cdr (car l)))
	       (seconds (cdr l)))))))

(let ((L1 '((paella spanish) (wine red) (and beans))))
  (seconds L1))

(let ((L2 '()))
  (seconds L2))

(let ((L7 '((and hot) (but dogs))))
  (seconds L7))

;;; 3.2 Write the function DUPLA of A and L which makes a new
;;;   lat containing as many A's as there are elements in L
(define dupla
  (lambda (a l)
    (cond
     ((null? l) '())
     (#t (cons a (dupla a (cdr l)))))))

(let ((A2 'hot)
      (L4 '(texas hot chili)))
  (dupla A2 L4))

(let ((A2 'hot)
      (L2 '()))
  (dupla A2 L2))

(let ((A1 'chili)
      (L5 '(soy sauce and tomato sauce)))
  (dupla A1 L5))

;;; 3.3 Write the function DOUBLE of A and L which is a converse to REMBER
;;;   The function doubles the first A in L instead of removing it
(define double
  (lambda (a l)
    (cond
     ((null? l) '())
     (#t (cond
	  ((eq? (car l) a) (cons a (cons a (cdr l))))
	  (#t (cons (car l)
		    (double a (cdr l)))))))))

(let ((A2 'hot)
      (L2 '()))
  (double A2 L2))

(let ((A1 'chili)
      (L3 '(cincinnati chili)))
  (double A1 L3))

(let ((A2 'hot)
      (L4 '(texas hot chili)))
  (double A2 L4))

;;; 3.4 Write the function SUBST-SAUCE of A and L which substitutes A for
;;;   the first atom SAUCE in L
(define subst-sauce
  (lambda  (a l)
    (cond
     ((null? l) '())
     (#t (cond
	  ((eq? (car l) 'sauce) (cons a (cdr l)))
	  (#t (cons (car l) (subst-sauce a (cdr l)))))))))

(let ((A1 'chili)
      (L4 '(texas hot chili)))
  (subst-sauce A1 L4))

(let ((A1 'chili)
      (L5 '(soy sauce and tomato sauce)))
  (subst-sauce A1 L5))

(let ((A1 'sauce)
      (L2 '()))
  (subst-sauce A1 L2))


;;; 3.5  Write the function SUBST3 of NEW, O1, O2, O3 and LAT which -
;;;   like subst2 - substitutes A for the first occurence of either
;;;   O1, O2, or O3 in LAT by A.
(define subst3
  (lambda (new o1 o2 o3 lat)
    (cond
     ((null? lat) '())
     (#t (cond
	  ((member? (car lat) (list o1 o2 o3)) (cons new (cdr lat)))
	  (#t (cons (car lat) (subst3 new o1 o2 o3 (cdr lat)))))))))

(let ((A1 'chili)
      (A2 'hot)
      (A4 'sauce)
      (A5 'soy)
      (L5 '(soy sauce and tomato sauce)))
  (subst3 A5 A1 A2 A4 L5))

(let ((A1 'chili)
      (A2 'hot)
      (A3 'spicy)
      (A4 'sauce)
      (L4 '(texas hot chili)))
  (subst3 A4 A1 A2 A3 L4))

(let ((A1 'chili)
      (A2 'hot)
      (A3 'spicy)
      (A5 'soy)
      (L2 '()))
  (subst3 A3 A1 A2 A5 L2))

;;; 3.6 Write the function substN of NEW, SLAT and LAT which replaces the
;;;   first atom in LAT that also occurs in SLAT by the atom NEW
(define substN
  (lambda (new slat lat)
  (cond
   ((null? lat) '())
   (#t (cond
       ((member? (car lat) slat) (cons new (cdr lat)))
       (#t (cons (car lat) (substN new slat (cdr lat)))))))))

(let ((A2 'hot)
      (L3 '(cincinnati chili))
      (L4 '(texas hot chili)))
  (substN A2 L3 L4))

(let ((A4 'sauce)
      (L3 '(cincinnati chili))
      (L5 '(soy sauce and tomato sauce)))
  (substN A4 L3 L5))

(let ((A4 'sauce)
      (L3 '(cincinnati chili))
      (L2 '()))
  (substN A4 L3 L2))

;;; 3.9 Write the function REMBER2 of A and L which removes the
;;;   second occurrence of A in L
(define rember2
  (lambda (a l)
    (cond
     ((null? l) '())
     (#t (cond
	  ((eq? (car l) a) (cons a (rember a (cdr l))))
	  (#t (cons (car l) (rember2 a (cdr l)))))))))

(let ((A1 'chili)
      (L3 '(cincinnati chili)))
  (rember2 A1 L3))

(let ((A4 'sauce)
      (L5 '(soy sauce and tomato sauce)))
  (rember2 A4 L5))

(let ((A4 'sauce)
      (L2 '()))
  (rember2 A4 L2))

;;; *******************************************
;;; *             Numbers Games               *
;;; *******************************************

;;; Is (atom? N) true or false, where
;;;   N is: 14
(let ((N 14))
  (atom? N))

;;; Is -3 a number?
(let ((N -3))
  (number? N))

;;; Is 3.1415 a number?
(let ((N 3.1415))
  (number? N))
  
;;; What is (add1 N) where
;;;   N is:67
(let ((N 67))
  (add1 N))

;;; What is (sub1 N) where
;;;   N is: 5
(let ((N 5))
  (sub1 N))

;;; Is (zero? N) true or false, where
;;;   N is: 0
(let ((N 0))
  (zero? N))

;;; Is (zero? N) true or false, where
;;;   N is: 1492
(let ((N 1492))
  (zero? N))

;;; What is (+ N M) where
;;;   N is: 46
;;;   M is: 12
(let ((N 46)
      (M 12))
  (+ N M))

;;; Try to write the function MY-+
;;;   Hint: it uses zero?, add1 and sub1
(define my-+
  (lambda (n m)
    (cond
     ((zero? m) n)
     (#t (my-+ (add1 n) (sub1 m))))))

(my-+ 12 15)

;;; What is (- N M), where
;;;   N is: 17
;;;   M is: 9
(let ((N 17) (M 9)) (- N M))

;;; What is (- N M), where
;;;   N is: 3
;;;   M is: 5
(let ((N 3) (M 5)) (- N M))

;;; Write the function MY--
(define my--
  (lambda (n m)
    (cond
     ((zero? m) n)
     (#t (sub1 (my-- n (sub1 m)))))))

(my-- 3 5)

(define addvec
  (lambda (vec)
    (cond
     ((null? vec) 0)
     (#t (my-+ (car vec) (addvec (cdr vec)))))))

;;; What is (addvec VEC), where
;;;   VEC is: (3 5 2 8)
(let ((VEC '(3 5 2 8)))
  (addvec VEC))

;;; What is (addvec VEC), where
;;;   VEC is: (15 6 7 12 3)
(let ((VEC '(15 6 7 12 3)))
  (addvec VEC))

;;; *******************************************
;;; * The Fourth Commandment (premliminary)   *
;;; *                                         *
;;; * When recurring on a list of atoms, LAT, *
;;; * or a vec, VEC, ask two questions about  *
;;; * them, and use (cdr LAT) or (cdr VEC)    *
;;; * for the natural recursion.              *
;;; *                                         *
;;; * When recurring on a number, N, ask two  *
;;; * questions, and use (sub1 N) for the     *
;;; * natural recursion.                      *
;;; *******************************************

;;; What is (* N M), where
;;;   N is: 5
;;;   and M is: 3
(let ((N 5) (M 3)) (* N M))

;;; What is (* N M), where
;;;   N is: 13
;;;   and M is: 4
(let ((N 13) (M 4)) (* N M))

(define my-*
  (lambda (n m)
    (cond
     ((zero? m) 0)
     (#t (+ n (my-* n (sub1 m)))))))

(my-* 5 3)
(my-* 13 4)

;;; ********************************************
;;; * The Fifth Commandment                    *
;;; *                                          *
;;; * When building a value with +, always use *
;;; * 0 for the value of the terminating line, *
;;; * for adding 0 does not change the value   *
;;; * of an addition.                          *
;;; *                                          *
;;; * When building a value with *, always use *
;;; * 1 for the value of the terminating line, *
;;; * for multiplying by 1 does not change the *
;;; * value of a multiplication.               *
;;; *                                          *
;;; * When building a value with CONS, always  *
;;; * consider () for the value of the         * 
;;; * terminating line.                        *
;;; ********************************************

;;; my solution
(define vec+
  (lambda (vec1 vec2)
    (cond
     ((or (null? vec1) (null? vec2)) '())
     (#t (cons (my-+ (car vec1) (car vec2)) (vec+ (cdr vec1) (cdr vec2)))))))

;;; What is (vec+ VEC1 VEC2), where
;;;   VEC1 is: (3 6 9 11 4)
;;;   and VEC2 is: (8 5 2 0 7)
(let ((VEC1 '(3 6 9 11 4))
      (VEC2 '(8 5 2 0 7)))
  (vec+ VEC1 VEC2))

;;; What is (vec+ VEC1 VEC2), where
;;;   VEC1 is: '(2 3)
;;;   and VEC2 is: '(4 6)
(let ((VEC1 '(2 3))
      (VEC2 '(4 6)))
  (vec+ VEC1 VEC2))


;;; book solution
(define vec+
  (lambda (vec1 vec2)
    (cond
     ((null? vec1) '())
     (#t (cons (+ (car vec1) (car vec2))
	       (vec+
		(cdr vec1) (cdr vec2)))))))

;;; What is (vec+ VEC1 VEC2), where
;;;   VEC1 is: '(3 7)
;;;   and VEC2 is: '(4 6)
(let ((VEC1 '(3 7))
      (VEC2 '(4 6)))
  (vec+ VEC1 VEC2))

;;; second book solution
(define vec+
  (lambda (vec1 vec2)
    (cond
     ((null? vec1) vec2)
     (#t (cons (+ (car vec1) (car vec2))
	       (vec+
		(cdr vec1) (cdr vec2)))))))

;;; Handle when vecs are not the same length
(let ((VEC1 '(3 7))
      (VEC2 '(4 6 8 1)))
  (vec+ VEC1 VEC2))

;;; third book solution
(define vec+
  (lambda (vec1 vec2)
    (cond
     ((null? vec1) vec2)
     ((null? vec2) vec1)
     (#t (cons (+ (car vec1) (car vec2))
	       (vec+
		(cdr vec1) (cdr vec2)))))))

;;; Handle longer first arg VEC1
(let ((VEC1 '(3 7 8 1))
      (VEC2 '(4 6)))
  (vec+ VEC1 VEC2))

;;; What is (> N M) where
;;;   N is: 12
;;;   and M is: 13
(let ((N 12) (M 13)) (> N M))

;;; What is (> N M) where
;;;   N is: 12
;;;   and M is: 11
(let ((N 12) (M 11)) (> N M))

(define my->
  (lambda (n m)
    (cond
     ((zero? m) #t)
     ((zero? n) #f)
     (#t (my-> (sub1 n) (sub1 m))))))

(let ((N 12) (M 13)) (my-> N M))
(let ((N 12) (M 11)) (my-> N M))

(let ((N 11) (M 11)) (my-> N M))

;; fix for equal args
(define my->
  (lambda (n m)
    (cond
     ((zero? n) #f)
     ((zero? m) #t)
     (#t (my-> (sub1 n) (sub1 m))))))

(define my-<
  (lambda (n m)
    (cond
     ((zero? m) #f)
     ((zero? n) #t)
     (#t (my-< (sub1 n) (sub1 m))))))

(let ((N 12) (M 13)) (my-< N M))
(let ((N 12) (M 11)) (my-< N M))

(let ((N 11) (M 11)) (my-< N M))

;;; Here is the definition of MY-=
(define my-=
  (lambda (n m)
    (cond
     ((zero? m) (zero? n))
     ((zero? n) #f)
     (#t (my-= (sub1 n) (sub1 m))))))

;;; Rewrite MY-+ using MY-< and MY->
(define my-=
  (lambda (n m)
    (cond
     ((my-< n m) #f)
     ((my-> n m) #f)
     (#t #t))))

(let ((N 12) (M 13)) (my-= N M))
(let ((N 12) (M 11)) (my-= N M))

;;; Write the function MY-^
;;; Hint: See The Fourth and Fifth Commandments
(define my-^
  (lambda (n m)
    (cond
     ((zero? m) 1)
     (#t (my-* n (my-^ n (sub1 m)))))))

;;; (MY-^ N M) where
;;;   N is: 1
;;;   M is: 1
(let ((N 1) (M 1))
  (my-^ N M))

;;; (MY-^ N M) where
;;;   N is: 2
;;;   M is: 3
(let ((N 2) (M 3))
  (my-^ N M))

;;; (MY-^ N M) where
;;;   N is: 5
;;;   M is: 3
(let ((N 5) (M 3))
  (my-^ N M))

;;; MY-LENGTH
;;; my version
(define my-length
  (lambda (lat)
    (cond
     ((null? lat) 0)
     (#t (my-+ 1 (my-length (cdr lat)))))))

;;; What is the value of (MY-LENGTH LAT), where
;;;   LAT is: (hotdogs with mustard sauerkraut and pickles)
(let ((LAT '(hotdogs with mustard sauerkraut and pickles)))
  (my-length LAT))

;;; What is (MY-LENGTH LAT), where
;;;   LAT is: (ham and cheese on rye)
(let ((LAT '(ham and cheese on rye)))
  (my-length LAT))

;;; book version
(define my-length
  (lambda (lat)
    (cond
     ((null? lat) 0)
     (#t (add1 (my-length (cdr lat)))))))

;;; PICK
;;; my solution
(define pick
  (lambda (n lat)
    (cond
     ((null? lat) '())
     ((my-= n 1) (car lat))
     (#t (pick (sub1 n) (cdr lat))))))

;;; What is (PICK N LAT), where
;;;   N is: 4
;;;   and LAT is: (lasagna spaghetti ravioli macaroni meatball)
(let ((N 4)
      (LAT '(lasagna spaghetti ravioli macaroni meatball)))
  (pick N LAT))

;;; What is (PICK N LAT), where
;;;   N is: 0
;;;   and LAT is: ()
(let ((N 0)
      (LAT '()))
  (pick N LAT))

;;; book solution
(define pick
  (lambda (n lat)
    (cond
     ((null? lat) '())
     ((zero? (sub1 n)) (car lat))
     (#t (pick (sub1 n) (cdr lat))))))

;;; Does the order of the two terminal conditions matter?
;;; Think about it
;;; Try it out
(define pick
  (lambda (n lat)
    (cond
     ((zero? (sub1 n)) (car lat))
     ((null? lat) '())
     (#t (pick (sub1 n) (cdr lat))))))

(define rempick
  (lambda (n lat)
    (cond
     ((zero? (sub1 n)) (cdr lat))
     ((null? lat) '())
     (#t (cons (car lat) (rempick (sub1 n) (cdr lat)))))))


;;; What is (REMPICK N LAT), where
;;;   N is: 3
;;;   and LAT is: (hotdogs with hot mustard)
(let ((N 3)
      (LAT '(hotdogs with hot mustard)))
  (rempick N LAT))

;;; What is (REMPICK N LAT), where
;;;   N is: 0
;;;   and LAT is: ()
(let ((N 0) (LAT '()))
  (rempick N LAT))

;;; Is (NUMBER? A) true or false, where
;;;   A is: tomato
(let ((A 'tomato))
  (number? A))

;;; Is (NUMBER? A) true or false, where
;;;   A is: 76
(let ((A 76))
  (number? A))

;;; Can you write NUMBER?, which is true if its
;;; argument is a numeric atom and false if its
;;; argument is a non-numeric atom?
;;; No, it is a primitive function.

;;; Now, using NUMBER?, write a function NO-NUMS,
;;; which gives as a final value a LAT obtained
;;; by removing all the numbers from the LAT.
;;; For example where
;;;   LAT is: (5 pears 6 prunes 9 dates)
;;;   (NO-NUMS LAT) is: (pears prunes dates)
(define no-nums
  (lambda (lat)
    (cond
     ((null? lat) '())
     (#t (cond
	  ((number? (car lat)) (no-nums (cdr lat)))
	  (#t (cons (car lat) (no-nums (cdr lat)))))))))

(let ((LAT '(5 pears 6 prunes 9 dates)))
  (no-nums LAT))

;;; Now write ALL-NUMS which builds a VEC as a
;;; final value given a LAT
(define all-nums
  (lambda (lat)
    (cond
     ((null? lat) '())
     (#t (cond ((number? (car lat))
		(cons (car lat)
		      (all-nums (cdr lat))))
	       (#t (all-nums (cdr lat))))))))

(let ((LAT '(5 pears 6 prunes 9 dates)))
  (all-nums LAT))

;;; Write the function EQAN? which is true if its
;;; two arguments, A1 and A2, are the same atom.
;;; Remember to use = for numbers and EQ for all
;;; others.
;;; my solution
(define eqan?
  (lambda (a1 a2)
    (cond
     ((number? a1)
      (cond
       ((number? a2) (= a1 a2))
       (#t #f)))
     (#t (eq? a1 a2)))))

;;; book solution
(define eqan?
  (lambda (a1 a2)
    (cond
     ((number? a1)
      (cond
       ((number? a2) (= a1 a2))
       (#t #f)))
     ((number? a2) #f)
     (#t (eq? a1 a2)))))

(eqan? 1 'love)
(eqan? 3 3)
(eqan? '() '())
(eqan? 'one 'one)

;;; === EXERCISES ===
;;; For these exercises,
;;;   VEC1 is: (1 2)
;;;   VEC2 is: (3 2 4)
;;;   VEC3 is: (2 1 3)
;;;   VEC4 is: (6 2 1)
;;;   L is: ()
;;;   ZERO is: 0
;;;   ONE is: 1
;;;   THREE is: 3
;;;   OBJ is: (x y)

;;; 4.1 Write the function DUPLICATE of N and OBJ which
;;;   builds a LAT containing N objects OBJ.
;;;   Examples:
;;;     (duplicate THREE OBJ) is: ((x y) (x y) (x y))
;;;     (duplicate ZERO OBJ) is: ()
;;;     (duplicate ONE VEC1) is: ((1 2))
(define duplicate
  (lambda (n obj)
    (cond
     ((zero? n) '())
     (#t (cons obj (duplicate (sub1 n) obj))))))

(let ((THREE 3)
      (OBJ '(x y)))
  (duplicate THREE OBJ))

(let ((ZERO 0)
      (OBJ '()))
  (duplicate ZERO OBJ))

(let ((ONE 1)
      (VEC1 '(1 2)))
  (duplicate ONE VEC1))

;;; 4.2 Write the function MULTIVEC that builds a number by multiplying
;;;   all the numbers in a VEC
;;;   Examples:
;;;     (multivec VEC2) is: 24
;;;     (multivec VEC3) is: 6
;;;     (multivec L) is: 1
(define multivec
  (lambda (vec)
    (cond
     ((null? vec) 1)
     (#t (* (car vec) (multivec (cdr vec)))))))

(let ((VEC2 '(3 2 4)))
  (multivec VEC2))

(let ((VEC3 '(2 1 3)))
  (multivec VEC3))

(let ((L '()))
  (multivec L))

;;; 4.5 Write the function INDEX of A and LAT that returns the place of
;;;   the atom A in LAT. You may assume that A is a member of LAT
;;;   Hint: Can LAT be empty?
;;;   Examples:
;;;     When A is: car
;;;     LAT1 is: (cons cdr car null? eq?)
;;;     B is: motor
;;;     LAT2 is: (car engine auto motor)
;;;
;;;   we have (index A LAT1) is: 3
;;;   we have (index A LAT2) is: 1
;;;   we have (index B LAT2) is: 4
(define index
  (lambda (a lat)
    (cond
     ((eq? (car lat) a) 1)
     (#t (add1 (index a (cdr lat)))))))

(let ((A 'car)
      (LAT1 '(cons cdr car null? eq?)))
  (index A LAT1))

(let ((A 'car)
      (LAT2 '(car engine auto motor)))
  (index A LAT2))

(let ((B 'motor)
      (LAT2 '(car engine auto motor)))
  (index B LAT2))

;;; 4.6 Write the function PRODUCT of VEC1 and VEC2 that multiplies
;;;   corresponding numbers in VEC1 and VEC2 and builds a new VEC
;;;   from the results. The vecs, VEC1 and VEC2, may differ in length.
;;;   Examples:
;;;     (product VEC1 VEC2) is: (3 4 4)
;;;     (product VEC2 VEC3) is: (6 2 12)
;;;     (product VEC3 VEC4) is: (12 2 3)
(define product
  (lambda (vec1 vec2)
    (cond
     ((null? vec1) vec2)
     ((null? vec2) vec1)
     (#t (cons
	  (* (car vec1) (car vec2))
	  (product (cdr vec1) (cdr vec2)))))))

(let ((VEC1 '(1 2))
      (VEC2 '(3 2 4)))
  (product VEC1 VEC2))

(let ((VEC2 '(3 2 4))
      (VEC3 '(2 1 3)))
  (product VEC2 VEC3))

(let ((VEC3 '(2 1 3))
      (VEC4 '(6 2 1)))
  (product VEC3 VEC4))

;;; 4.7 Write the function DOT-PRODUCT of VEC1 and VEC2 that multiplies
;;;   corresponding numbers in vec1 and vec2 and builds a new NUMBER by
;;;   summing the results. The vecs, VEC1 and VEC2, are the same length.
;;;   Examples:
;;;     (dot-product VEC2 VEC2) is: 29
;;;     (dot-product VEC2 VEC4) is: 26
;;;     (dot-product VEC3 VEC4) is: 17
(define dot-product
  (lambda (vec1 vec2)
    (cond
     ((null? vec1) 0)
     (#t (+ (* (car vec1) (car vec2))
	    (dot-product (cdr vec1) (cdr vec2)))))))

(let ((VEC2 '(3 2 4)))
  (dot-product VEC2 VEC2))

(let ((VEC2 '(3 2 4))
      (VEC4 '(6 2 1)))
  (dot-product VEC2 VEC4))

(let ((VEC3 '(2 1 3))
      (VEC4 '(6 2 1)))
  (dot-product VEC3 VEC4))

;;; 4.8 Write the function MY-/ that divides nonnegative integers
;;;   Examples:
;;;     (MY-/ N M) is: 1
;;;     when N is: 7
;;;     and M is: 5
;;;     (MY-/ N M) is: 4
;;;     when N is: 8
;;;     and M is: 2
;;;     (MY-/ N M) is: 0
;;;     when N is: 2
;;;     and M is: 3
;;;  Hint: A number is now defined as a rest (between 0 and M-1)
;;;        and a multiple addition of M
;;;        The number of additions is the result
(define my-/
  (lambda (n m)
    (cond
     ((> m n) 0)
     (#t (add1 (my-/ (- n m) m))))))

(let ((N 7) (M 5)) (my-/ N M))
(let ((N 8) (M 2)) (my-/ N M))
(let ((N 2) (M 3)) (my-/ N M))

;;; 4.9 Here is the function REMAINDER
(define remainder
  (lambda (n m)
    (cond
     (#t (- n (* m (my-/ n m)))))))
;;; Make up examples for this application (REMAINDER N M)
;;; and work through them

(remainder 7 5)
(remainder 225 136)
(remainder 0 12)
(remainder 29 26)
(remainder 26 29)

;;; 4.10 Write the function MY-<= which tests if two numbers
;;;   are equal or if the first is less than the second
;;;   Examples:
;;;     (MY-<= ZERO ONE) is: true
;;;     (MY-<= ONE ONE) is: true
;;;     (MY-<= THREE ONE) is: false
(define my-<=
  (lambda (n m)
    (cond
     ((zero? n) #t)
     ((zero? m) #f)
     (#t (my-<= (sub1 n) (sub1 m))))))

(let ((ZERO 0) (ONE 1)) (my-<= ZERO ONE))
(let ((ONE 1)) (my-<= ONE ONE))
(let ((ONE 1) (THREE 3)) (my-<= THREE ONE))

;;; *******************************************
;;; *        The Multichapter Chapter         *
;;; *******************************************

;;; Write the function MEMBER?
(define member?
  (lambda (a lat)
    (cond
     ((null? lat) #f)
     (#t (or
	  (eq? (car lat) a)
	  (member? a (cdr lat)))))))

;;; Write the function REMBER
(define rember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) a) (cdr lat))
     (#t (cons (car lat)
	       (rember a (cdr lat)))))))

;;; Write the function MULTIREMBER which gives as its
;;; final value the LAT with *all* occurrences of A
;;; removed
(define multirember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     (#t (cond ((eq? (car lat) a)
		(multirember a (cdr lat)))
	       (#t (cons (car lat)
			 (multirember a (cdr lat)))))))))

(multirember 'cup '(coffee cup tea cup and hick cup))

;;; Write the function MULTIINSERTR
(define multiinsertR
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     (#t (cond
	  ((eq? (car lat) old)
	   (cons old
		 (cons new
		       (multiinsertR new old (cdr lat))))
	   (#t (cons (car lat) (multiinsertR new old (cdr lat))))))))))

;;; Try out this function
(define multiinsertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     (#t (cond
	  ((eq? (car lat) old)
	   (cons new
		 (cons old
		       (multiinsertL new old lat))))
	  (#t (cons (car lat) (multiinsertL new old (cdr lat)))))))))

(multiinsertL 'fried 'fish '(chips and fish or fish and fried))

;;; Now try to write the function multiinsertL
(define multiinsertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     (#t (cond
	  ((eq? (car lat) old)
	   (cons new
		 (cons old
		       (multiinsertL new old (cdr lat)))))
	  (#t (cons (car lat) (multiinsertL new old (cdr lat)))))))))

;;; **********************************************
;;; * The Sixth Commandment                      *
;;; *                                            *
;;; * Always change at least one argument while  *
;;; * recurring. The changing argument(s) should *
;;; * be tested in the termination condition(s)  *
;;; * and it should be changed to be closer to   *
;;; * termination.                               *
;;; *                                            *
;;; * For example:                               *
;;; *   When using CDR,                          *
;;; *   test termination with NULL               *
;;; *                                            *
;;; *   When using 1-,                           *
;;; *   test termination with ZEROP              *
;;; **********************************************

;;; Now write the function MULTISUBST
(define multisubst
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     (#t (cond ((eq? (car lat) old)
	    (cons new (multisubst new old (cdr lat))))
	   (#t (cons (car lat) (multisubst new old (cdr lat)))))))))

;;; Now write the function OCCUR which counts the
;;; number of times an atom A appears in a LAT.
(define occur
  (lambda (a lat)
    (cond
     ((null? lat) 0)
     (#t (cond ((eq? (car lat) a) (1+ (occur a (cdr lat))))
	       (#t (occur a (cdr lat))))))))

;;; Write the function ONEP where
;;; (ONE? N) is T if N is 1, and NIL otherwise
(define one? (lambda (n) (zero? (sub1 n))))

(one? 1)
(one? 10)
(one? 0)

;;; from book
(define one?
  (lambda (n)
    (cond
     ((zero? n) #f)
     (#t (zero? (sub1 n))))))

;;; or
(define one?
  (lambda (n)
    (cond
     (#t (= n 1)))))

;;; simply, without cond
(define one? (lambda (n) (= n 1)))

;;; Now rewrite the function REMPICK that
;;; removes the Nth atom from the LAT.
;;; For example, where
;;;   N is: 3
;;;  and LAT is: (lemon meringue salty pie)
;;; the application (REMPICK N LAT) has the value:
;;;   (lemon meringue pie)
;;; Use the function ONEP in your answer.
(define rempick
  (lambda (n lat)
    (cond
     ((one? n) (cdr lat))
     ((null? lat) '())
     (#t (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

(let ((N 3)
      (LAT '(lemon meringue salty pie)))
  (rempick N LAT))

;;; === EXERCISES ===
;;; For these exercises,
;;;   X is: comma
;;;   Y is: dot
;;;   A is: kiwis
;;;   B is: plums
;;;   LAT1 is: (bananas kiwis)
;;;   LAT2 is: (peaches apples bananas)
;;;   LAT3 is: (kiwis pears plums bananas cherries)
;;;   LAT4 is: (kiwis mangoes kiwis guavas kiwis)
;;;   L1 is: ((curry) () (chicken) ())
;;;   L2 is: ((peaches) (and cream))
;;;   L3 is: ((plums) and (ice) and cream)
;;;   L4 is: ()

;;; 5.1 For exercise 3.4 you wrote the function SUBST-CAKE.
;;;   Write the function MULTISUBST-KIWIS.
;;;   Examples:
;;;     (multisubst-kiwis B LAT1) is: (bananas plums)
;;;     (multisubst-kiwis Y LAT2) is: (peaches apples bananas)
;;;     (multisubst-kiwis Y LAT4) is: (dot mangoes dot guavas dot)
;;;     (multisubst-kiwis Y L4) is: ()
(define multisubst-kiwis
  (lambda (a lat)
    (cond ((null? lat) '())
	  (#t (cond ((eq? (car lat) 'kiwis)
		     (cons a (multisubst-kiwis a (cdr lat))))
		    (#t (cons (car lat)
			      (multisubst-kiwis a (cdr lat)))))))))

(let ((B 'plums)
      (LAT1 '(bananas kiwis)))
  (multisubst-kiwis B LAT1))

(let ((Y 'dot)
      (LAT2 '(peaches apples bananas)))
  (multisubst-kiwis Y LAT2))

(let ((Y 'dot)
      (LAT4 '(kiwis mangoes kiwis guavas kiwis)))
  (multisubst-kiwis Y LAT4))

(let ((Y 'dot)
      (L4 '()))
  (multisubst-kiwis Y L4))

;;; 5.2 Write the function MULTISUBST2. You can find SUBST2
;;;   at the end of Chapter 3.
;;;   Examples:
;;;     (multisubst2 X A B LAT1) is: (bananas comma)
;;;     (multisubst2 Y A B LAT3) is: (dot pears dot bananas cherries)
;;;     (multisubst2 A X Y LAT1) is: (bananas kiwis)
(define multisubst2
  (lambda (new o1 o2 lat)
    (cond
     ((null? lat) '())
     (#t (cond
	  ((or (eq? (car lat) o1)
	       (eq? (car lat) o2))
	   (cons new (multisubst2 new o1 o2 (cdr lat))))
	  (#t (cons (car lat) (multisubst2 new o1 o2 (cdr lat)))))))))

(let ((X 'comma)
      (A 'kiwis)
      (B 'plums)
      (LAT1 '(bananas kiwis)))
  (multisubst2 X A B LAT1))

(let ((A 'kiwis)
      (B 'plums)
      (Y 'dot)
      (LAT3 '(kiwis pears plums bananas cherries)))
  (multisubst2 Y A B LAT3))

(let ((A 'kiwis)
      (X 'comma)
      (Y 'dot)
      (LAT1 '(bananas kiwis)))
  (multisubst2 A X Y LAT1))

;;; 5.3 Write the function MULTIDOWN of LAT which
;;;   replaces every atom in LAT by a list containing the atom.
;;;   Examples:
;;;     (multidown LAT1) is: ((bananas) (kiwis))
;;;     (multidown LAT2) is: ((peaches) (apples) (bananas))
;;;     (multidown L4) is: ()
(define multidown
  (lambda (lat)
    (cond
     ((null? lat) '())
     (#t (cons (cons (car lat) '()) (multidown (cdr lat)))))))

(let ((LAT1 '(bananas kiwis)))
  (multidown LAT1))

(let ((LAT2 '(peaches apples bananas)))
  (multidown LAT2))

(let ((L4 '()))
  (multidown L4))

;;; 5.4 Write the function OCCURN of ALAT and LAT
;;;   which counts how many times an atom in ALAT
;;;   also occurs in LAT
;;;   Examples:
;;;     (occurn LAT1 L4) is: 0
;;;     (occurn LAT1 LAT2) is: 1
;;;     (occurn LAT1 LAT3) is: 2
(define occurn
  (lambda (alat lat)
    (cond
     ((null? lat) 0)
     (#t (cond ((member? (car lat) alat)
		(add1 (occurn alat (cdr lat))))
	       (#t (occurn alat (cdr lat))))))))

(let ((LAT1 '(bananas kiwis)) (L4 '()))
  (occurn LAT1 L4))

(let ((LAT1 '(bananas kiwis))
      (LAT2 '(peaches apples bananas)))
  (occurn LAT1 LAT2))

(let ((LAT1 '(bananas kiwis))
      (LAT3 '(kiwis pears plums bananas cherries)))
  (occurn LAT1 LAT3))


;;; 5.5 The function I of LAT1 and LAT2 returns the
;;;   first atom in that is in both LAT1 and LAT2.
;;;   Write the functions I and MULTII.
;;;   MULTII returns a list of atoms common to LAT1 and LAT2.
;;;   Examples:
;;;     (I LAT1 L4) is: ()
;;;     (I LAT1 LAT2) is: bananas
;;;     (I LAT1 LAT3) is: kiwis
;;;     (MULTII LAT1 L4: ()
;;;     (MULTII LAT1 LAT2) is: (bananas)
;;;     (MULTII LAT1 LAT3) is: (kiwis bananas)
(define I
  (lambda (lat1 lat2)
    (cond
     ((null? lat2) '())
     (#t (cond ((member? (car lat2) lat1) (car lat2))
	       (#t (I lat1 (cdr lat2))))))))

(define multiI
  (lambda (lat1 lat2)
    (cond
     ((null? lat2) '())
     (#t (cond ((member (car lat2) lat1)
		(cons (car lat2) (multiI lat1 (cdr lat2))))
	       (#t (multiI lat1 (cdr lat2))))))))

(let ((LAT1 '(bananas kiwis))
      (L4 '()))
  (I LAT1 L4))

(let ((LAT1 '(bananas kiwis))
      (LAT2 '(peaches apples bananas)))
  (I LAT1 LAT2))

(let ((LAT1 '(bananas kiwis))
      (LAT3 '(kiwis pears plums bananas cherries)))
  (I LAT1 LAT3))

(let ((LAT1 '(bananas kiwis))
      (L4 '()))
  (multiI LAT1 L4))

(let ((LAT1 '(bananas kiwis))
      (LAT2 '(peaches apples bananas)))
  (multiI LAT1 LAT2))

(let ((LAT1 '(bananas kiwis))
      (LAT3 '(kiwis pears plums bananas cherries)))
  (multiI LAT1 LAT3))

;;; 5.8 The function COUNT0 of VEC counts the number
;;;   of zero elements in VEC. What is wrong with the
;;;   following definition? Can you fix it?
(define count0
  (lambda (vec)
    (cond
     ((null? vec) 1)
     (#t (cond
	  ((zero? (car vec))
	   (cons 0 (count0 (cdr vec))))
	  (#t (count0 (cdr vec))))))))

(define count0
  (lambda (vec)
    (cond
     ((null? vec) 0)
     (#t (cond
	  ((zero? (car vec))
	   (add1 (count0 (cdr vec))))
	  (#t (count0 (cdr vec))))))))
  
(let ((VEC '(1 0 1 2 0 3 0 0 4 1 0 0 5)))
  (count0 VEC))

;;; 5.9 Write the function MULTIUP of L which replaces
;;;   every LAT of length 1 in L by the atom in that list,
;;;   and which also removes every empty list
;;;   Examples:
;;;     (multiup L4) is: ()
;;;     (multiup L1) is: (curry chicken)
;;;     (multiup L2) is: (peaches (and cream))
(define multiup
  (lambda (l)
    (cond ((null? l) '())
	  ((null? (car l)) (multiup (cdr l)))
	  ((cons? (car l))
	   (cond ((one? (length (car l)))
		  (cons (car (car l)) (multiup (cdr l))))
		 (#t (cons (car l) (multiup (cdr l))))))
	  (#t (cons (car l) (multiup (cdr l)))))))

(let ((L4 '()))
  (multiup L4))

(let ((L1 '((curry) () (chicken) ())))
  (multiup L1))

(let ((L2 '((peaches) (and cream))))
  (multiup L2))

;;; *******************************************
;;; *             *Oh My Gawd*                *
;;; *          It's Full of Stars             *
;;; *******************************************

;;; True or false, (not (atom S)), where
;;;   S is: (hungarian goulash)
(let ((s '(hungarian goulash)))
  (not (atom? s)))

;;; (not (atom S)) where
;;;   S is: atom
(let ((s 'atom))
  (not (atom? s)))

;;; (not (atom S)) where
;;;   S is: (turkish ((coffee) and) baklava)
(let ((s '(turkish ((coffee) and) baklava)))
  (not (atom? s)))

(define leftmost
  (lambda (l)
    (cond
     ((null? l) '())
     (#t (cond
	  ((atom? (car l)) (car l))
	  (#t (leftmost (car l))))))))

;;; What is (leftmost L), where
;;;   L is: ((hot) (tuna (and)) cheese)
(let ((L '((hot) (tuna (and)) cheese)))
  (leftmost L))

;;; What is (leftmost L), where
;;;  L is: (((hamburger) french) (fries (and a) coke))
(let ((L '(((hamburger) french) (fries (and a) coke))))
  (leftmost L))

;;; What is (leftmost L), where
;;;  L is: ((((4) four)) 17 (seventeen))
(let ((L '((((4) four)) 17 (seventeen))))
  (leftmost L))

;;; Write OCCUR*
(define non-atom? (lambda (a-or-l) (not (atom? a-or-l))))

(define occur*
  (lambda (a l)
    (cond
     ((null? l) 0)
     ((non-atom? (car l))
      (+ (occur* a (car l))
	 (occur* a (cdr l))))
     (#t (cond
	  ((eq? (car l) a)
	   (add1 (occur* a (cdr l))))
	  (#t (occur* a (cdr l))))))))

;;; SUBST*
(define subst*
  (lambda (new old l)
    (cond
     ((null? l) '())
     ((non-atom? (car l))
      (cons (subst* new old (car l)) (subst* new old (cdr l))))
     (#t (cond
	  ((eq? (car l) old)
	   (cons new (subst* new old (cdr l))))
	  (#t (cons (car l) (subst* new old (cdr l)))))))))

(let ((NEW 'orange)
      (OLD 'banana)
      (L '((banana)
	   (split ((((banana ice)))
		   (cream (banana))
		   sherbert))
	   (banana)
	   (bread)
	   (banana brandy))))
  (subst* NEW OLD L))

;;; What is (insertL* NEW OLD L), where
;;;   NEW is: pecker
;;;   OLD is: chuck
;;;   and L is: ((how much (wood))
;;;             could
;;;             ((a (wood) chuck))
;;;             (((chuck)))
;;;             (if (a) ((wood chuck)))
;;;             could chuck wood)
(define insertL*
  (lambda (new old l)
    (cond
     ((null? l) '())
     ((non-atom? (car l))
      (cons (insertL* new old (car l)) (insertL* new old (cdr l))))
     (#t (cond
	  ((eq? (car l) old)
	   (cons new (cons old (insertL* new old (cdr l)))))
	  (#t (cons (car l) (insertL* new old (cdr l)))))))))

(let ((NEW 'pecker)
      (OLD 'chuck)
      (L '((how much (wood))
           could
           ((a (wood) chuck))
           (((chuck)))
           (if (a) ((wood chuck)))
           could chuck wood)))
  (insertL* NEW OLD L))

;;; (member*? A L), where
;;;   A is: chips
;;;   and L is: ((potato) (chips ((with) fish) (chips)))
(define member*?
  (lambda (a l)
    (cond
     ((null? l) #f)
     ((non-atom? (car l))
      (or (member*? a (car l)) (member*? a (cdr l))))
     (#t (or
	  (eq? (car l) a)
	  (member*? a (cdr l)))))))

(let ((A 'chips)
      (L '((potato) (chips ((with) fish) (chips)))))
  (member*? A L))

;;; Try to write member*? without using non-atom?
(define member*?
  (lambda (a l)
    (cond
     ((null? l) #f)
     ((atom? l) (eq? l a))
     (#t (or
	  (member*? a (car l))  
	  (member*? a (cdr l)))))))

;;; book version
(define member*?
  (lambda (a l)
    (cond
     ((null? l) #f)
     ((atom? (car l))
      (or (eq? (car l) a)
	  (member*? a (cdr l))))
     (#t (or (member*? a (car l))
	     (member*? a (cdr l)))))))

;;; What is (and (atom? (car l)) (eq? (car l) x))
;;;   where
;;;   X is: pizza
;;;   and L is: (mozzarella pizza)
(let ((X 'pizza)
      (L '(mozzarella pizza)))
  (and (atom? (car L)) (eq? (car L) X)))

;;; Give an example for X and L where the expression is true
(let ((X 'pineapple)
      (L '(pineapple pizza)))
  (and (atom? (car L)) (eq? (car L) X)))

(define eqlist?
  (lambda (l1 l2)
    (cond
     ((and (null? l1) (null? l2)) #t)
     ((or (null? l1) (null? l2)) #f)
     ((and (atom? (car l1)) (atom? (car l2)))
      (and (eq? (car l1) (car l2))
	   (eqlist? (cdr l1) (cdr l2))))
     (#t
      (and (eqlist? (car l1) (car l2))
	   (eqlist? (cdr l1) (cdr l2)))))))

;;; (eqlist? L1 L2), where
;;;   L1 is: (strawberry ice cream)
;;;   and L2 is: (strawberry ice cream)
(let ((L1 '(strawberry ice cream))
      (L2 '(strawberry ice cream)))
  (eqlist? L1 L2))

;;; (eqlist? L1 L2), where
;;;   L1 is: (strawberry ice cream)
;;;   and L2 is: (strawberry cream ice)
(let ((L1 '(strawberry ice cream))
      (L2 '(strawberry cream ice)))
  (eqlist? L1 L2))

;;; (eqlist? L1 L2), where
;;;   L1 is: (beef ((sausage)) (and (soda)))
;;;   and L2 is: (beef ((salami)) (and (soda)))
(let ((L1 '(beef ((sausage)) (and (soda))))
      (L2 '(beef ((salami)) (and (soda)))))
  (eqlist? L1 L2))

;;; (eqlist? L1 L2), where
;;;   L1 is: (beef ((sausage)) (and (soda)))
;;;   and L2 is: (beef ((sausage)) (and (soda)))
(let ((L1 '(beef ((sausage)) (and (soda))))
      (L2 '(beef ((sausage)) (and (soda)))))
  (eqlist? L1 L2))

;;; write EQLIST? using EQAN?
(define eqlist?
  (lambda (l1 l2)
    (cond
     ((and (null? l1) (null? l2)) #t)
     ((or (null? l1) (null? l2)) #f)
     ((and (atom? (car l1)) (atom? (car l2)))
      (and (eqan? (car l1) (car l2))
	   (eqlist? (cdr l1) (cdr l2))))
     (#t
      (and (eqlist? (car l1) (car l2))
	   (eqlist? (cdr l1) (cdr l2)))))))

;;; book version
(define eqlist?
  (lambda (l1 l2)
    (cond
     ((and (null? l1) (null? l2)) #t)
     ((or (null? l1) (null? l2)) #f)
     ((and (non-atom? (car l1)) (non-atom? (car l2)))
      (and (eqlist? (car l1) (car l2))
	   (eqlist? (cdr l1) (cdr l2))))
     ((or (non-atom? (car l1)) (non-atom? (car l2))) #f)
     (#t (and
	  (eqan? (car l1) (car l2))
	  (eqlist? (cdr l1) (cdr l2)))))))

;;; Write the function EQUAL? which determines if
;;; two S-expressions are structurally the same
(define equal?
  (lambda (s1 s2)
    (cond
     ((and (null? s1) (null? s2)) #t)
     ((or (null? s1) (null? s2)) #f)
     ((and (atom? s1) (atom? s2)) (eqan? s1 s2))
     ((or (atom? s1) (atom? s2)) #f)
     (#t (and (equal? (car s1) (car s2))
	      (equal? (cdr s1) (cdr s2)))))))

;;; book version
(define equal?
     (lambda (s1 s2)
       (cond
	((and (atom? s1) (atom? s2))
	 (eqan? s1 s2))
	((and (non-atom? s1) (non-atom? s2))
	 (eqlist? s1 s2))
	(#t #f))))

;;; Now rewrite EQLIST? using EQUAL?
(define eqlist?
  (lambda (l1 l2)
    (cond
     ((and (null? l1) (null? l2)) #t)
     ((or (null? l1) (null? l2)) #f)
     (#t (and
       (equal? (car l1) (car l2))
       (eqlist? (cdr l1) (cdr l2)))))))

;;; How would REMBER change if we replaced LAT
;;; by a general list L and if we replaced A
;;; by an arbitrary S-expression S?
(define rember
  (lambda (s l)
    (cond
     ((null? l) '())
     ((non-atom? (car l))
      (cond
       ((equal? (car l) s) (cdr l))
       (#t (cons (car l) (rember s (cdr l))))))
     (#t (cond
	  ((equal? (car l) s) (cdr l))
	  (#t (cons (car l)
		(rember s (cdr l)))))))))

;;; Can you simplify REMBER?
(define rember
  (lambda (s l)
    (cond
     ((null? l) '())
     (#t (cond
	  ((equal? (car l) s) (cdr l))
	  (#t (cons (car l)
		    (rember s (cdr l)))))))))

;;; Can you simplify REMBER even more?
(define rember
  (lambda (s l)
    (cond
     ((null? l) '())
     ((equal? (car l) s) (cdr l))
     (#t (cons (car l)
	       (rember s (cdr l)))))))

;;; Simplify insertL*
(define insertL*
  (lambda (new old l)
    (cond
     ((null? l) '())
     ((non-atom? (car l))
      (cons (insertL* new old (car l)) (insertL* new old (cdr l))))
     ((eq? (car l) old)
      (cons new (cons old (insertL* new old (cdr l)))))
     (#t (cons (car l) (insertL* new old (cdr l)))))))

;;; ************************************************
;;; * The Seventh Commandment                      *
;;; *                                              *
;;; * Simplify only after the function is correct. *
;;; ************************************************

;;; === EXERCISES ===
;;; For these exercises,
;;;   L1 is: ((fried potatoes) (baked (fried)) tomatoes)
;;;   L2 is: (((chili) chili (chili)))
;;;   L3 is: ()
;;;   LAT1 is: (chili and hot)
;;;   LAT2 is: (baked fried)
;;;   A is: fried

;;; 6.1 Write the function DOWN* of L which puts every atom
;;;   in L in a list by itself.
;;;   Examples:
;;;     (down* L2) is: ((((chili)) (chili) ((chili))))
;;;     (down* L3) is: ()
;;;     (down* LAT1) is: ((chili) (and) (hot))
(define down*
  (lambda (l)
    (cond
     ((null? l) '())
     (#t (cond
	  ((atom? (car l)) (cons (list (car l)) (down* (cdr l))))
	  (#t (cons (down* (car l)) (down* (cdr l)))))))))

(let ((L1 '((fried potatoes) (baked (fried)) tomatoes)))
  (down* L1))

(let ((L2 '(((chili) chili (chili)))))
  (down* L2))

(let ((L3 '()))
  (down* L3))

;;; 6.2 Write the function OCCURN* of LAT and L which counts
;;;   all the atoms that are common to LAT and L.
;;;   Examples:
;;;     (occurN* LAT1 L2) is: 3
;;;     (occurN* LAT2 L1) is: 3
;;;     (occurN* LAT1 L3) is: 0
(define occurN*
  (lambda (lat l)
    (cond
     ((null? l) 0)
     ((atom? (car l))
      (cond ((member? (car l) lat)
	     (add1 (occurN* lat (cdr l))))
	    (#t (occurN* lat (cdr l)))))
     (#t (+ (occurN* lat (car l))
	    (occurN* lat (cdr l)))))))

(let ((LAT1 '(chili and hot))
      (L2 '(((chili) chili (chili)))))
  (occurN* LAT1 L2))

(let ((LAT2 '(baked fried))
      (L1 '((fried potatoes) (baked (fried)) tomatoes)))
  (occurN* LAT2 L1))

(let ((LAT1 '(chili and hot))
      (L3 '()))
  (occurN* LAT1 L3))

;;; 6.3 Write the function DOUBLE* of A and L which doubles
;;;   each occurrence of A in L.
;;;   Examples:
;;;     (double* A L1) is: ((fried fried potatoes)
;;;                         (baked (fried fried)) tomatoes)
;;;     (double* A L2) is: (((chili) chili (chili)))
;;;     (double* A LAT2) is: (baked fried fried)
(define double*
  (lambda (a l)
    (cond
     ((null? l) '())
     ((atom? (car l))
      (cond ((eqan? (car l) a)
	     (cons a (cons a (double* a (cdr l)))))
	    (#t (cons (car l) (double* a (cdr l))))))
     (#t (cons (double* a (car l))
	       (double* a (cdr l)))))))

(let ((A 'fried)
      (L1 '((fried potatoes) (baked (fried)) tomatoes)))
  (double* A L1))

(let ((A 'fried)
      (L2 '(((chili) chili (chili)))))
  (double* A L2))

(let ((A 'fried)
      (LAT2 '(baked fried)))
  (double* A LAT2))

;;; 6.5 Make sure that (MEMBER* A L), where
;;;   A is: chips
;;;   and L is: ((potato) (chips ((with) fish) (chips)))
;;;   really discovers the first chips.
;;;   Can you change MEMBER* so that it finds the last chips first?
(define member*
  (lambda (a l)
    (cond
     ((null? l) #f)
     ((non-atom? (car l))
      (or (member* a (cdr l)) (member* a (car l))))
     (#t (or
	  (eq? (car l) a)
	  (member* a (cdr l)))))))

(let ((A 'chips)
      (L '((potato) (chips ((with) fish) (chips)))))
  (member* A L))

;;; 6.6 Write the function LIST+ which adds up all the
;;;   numbers in a general list of numbers
;;;   Examples:
;;;     When
;;;     L1 is: ((1 (6 6 ())))
;;;     and L2 is: ((1 2 (3 6)) 1)
;;;     then
;;;     (list+ L1) is: 13
;;;     (list+ L2) is: 13
;;;     (list+ L3) is: 0
(define list+
  (lambda (l)
    (cond
     ((null? l) 0)
     ((atom? (car l))
      (cond
       ((number? (car l)) (+ (car l) (list+ (cdr l))))
       (#t (list+ (cdr l)))))
     (#t (+ (list+ (car l)) (list+ (cdr l)))))))

(let ((L1 '((1 (6 6 ())))))
  (list+ L1))

(let ((L2 '((1 2 (3 6)) 1)))
  (list+ L2))

(let ((L3 '()))
  (list+ L3))

;;; 6.7 Consider the following function G* of LVEC and ACC
(define g*
  (lambda (lvec acc)
    (cond
     ((null? lvec) acc)
     ((atom? (car lvec))
      (g* (cdr lvec) (+ (car lvec) acc)))
     (#t (g* (car lvec) (g* (cdr lvec) acc))))))
;;;   The function is always applied to a (general) list
;;;   of numbers and 0. Make up examples and find out
;;;   what the function does.
(g* '((1 (6 6))) 0)
(g* '(10 20 30) 0)
(g* '(1 2 3 4 5 6 7 8 9) 0)

;;; 6.8 Consider the following function F* of L and ACC
(define f*
  (lambda (l acc)
    (cond
     ((null? l) acc)
     ((atom? (car l))
      (cond
       ((member? (car l) acc) (f* (cdr l) acc))
       (#t (f* (cdr l) (cons (car l) acc)))))
     (#t (f* (car l) (f* (cdr l) acc))))))
;;;   The function is always applied to a list and the
;;;   empty list. Make up examples for L and step through
;;;   the applications. Generalize in one sentence what
;;;   F* does.
(f* '(chili fried baked chili) '())
(f* '(german chocolate chocolate cake) '())
(f* '(the boom boom room) '())
(f* '(the (boom boom) room) '())
(f* '(the boom boom room room) '())
(f* '(1 2 3 0 0 9 0 0 4 3 8 2 7 1) '())
(f* '(1 (2 3) ((0 0) 9) (((0) 0) 4 3) ((8 2)) (((7))) (1)) '())


;;;  The functions in Exercises 6.7 and 6.8 employ the accumulator
;;;  technique. This means that they pass along an argument that
;;;  represents the result that has been computed so far.
;;;  When these functions reach the bottom (NULL, ZEROP), they
;;;  just return the result contained in the accumulator.
;;;  The original argument for the accumulator is the element
;;;  that used to be the answer for the NULL-case.

;;; 6.9 Write the function OCCUR (see Chapter 5) of A and LAT
;;;   using the accumulator technique. What is the original
;;;   value for ACC?
(define occur
  (lambda (a lat acc)
    (cond
     ((null? lat) acc)
     (#t (cond
	  ((eq? (car lat) a)
	   (occur a (cdr lat) (add1 acc)))
	 (#t (occur a (cdr lat) acc)))))))

(let ((A 'kiwis)
      (LAT '(kiwis mangoes kiwis guavas kiwis)))
  (occur A LAT 0))

;;; 6.10 Step through an application of the original OCCUR* and
;;;   the original SUBST* and compare the arguments in the recursive
;;;   applications. Can you implement these using the accumulator
;;;   technique?

(define occur*
  (lambda (a l acc)
    (cond
     ((null? l) acc)
     ((non-atom? (car l))
      (occur* a (cdr l) (occur* a (car l) acc)))
     (#t (cond
       ((eq? (car l) a)
	(occur* a (cdr l) (add1 acc)))
       (#t (occur* a (cdr l) acc)))))))

(let ((A 'fried)
      (L '((fried potatoes) (baked (fried)) tomatoes)))
  (occur* A L 0))

(let ((A 'chili)
      (L '(((chili) chili (chili)))))
  (occur* A L 0))

(defun subst* (new old l)
  (cond
   ((null l) '())
   ((non-atom (car l))
    (cons (subst* new old (car l)) (subst* new old (cdr l))))
   (t (cond
       ((eq (car l) old)
	(cons new (subst* new old (cdr l))))
       (t (cons (car l) (subst* new old (cdr l))))))))

;;;; hmm... maybe not?
(defun subst* (new old l) )

(let ((NEW 'orange)
      (OLD 'banana)
      (L '((banana)
	   (split ((((banana ice)))
		   (cream (banana))
		   sherbert))
	   (banana)
	   (bread)
	   (banana brandy))))
  (subst* NEW OLD L '()))

;;; *******************************************
;;; *                 Shadows                 *
;;; *******************************************

;;; Write NUMBERED?
(define numbered?
  (lambda (aexp)
    (cond
     ((atom? aexp) (number? aexp))
     ((eq? (car (cdr aexp)) '+)
      (and (numbered? (car aexp))
	   (numbered? (car (cdr (cdr aexp))))))
     ((eq? (car (cdr aexp)) '*)
      (and (numbered? (car aexp))
	   (numbered? (car (cdr (cdr aexp))))))
     ((eq? (car (cdr aexp)) '^)
      (and (numbered? (car aexp))
	   (numbered? (car (cdr (cdr aexp)))))))))

;;; True or false, (NUMBEREDP X)
;;;   where X is: 1
(let ((x 1))
  (numbered? x))

;;; True or false, (NUMBEREDP Y)
;;;   where Y is: (3 + (4 ^ 5))
(let ((y '(3 + (4 ^ 5))))
  (numbered? y))

;;; True or false, (NUMBEREDP Z)
;;;   where Z is: (2 * sausage)
(let ((z '(2 * sausage)))
  (numbered? z))

;;; Since AEXP is known to be an arithmetic expression,
;;; can NUMBEREDP be written in a simpler way?
(define numbered?
  (lambda (aexp)
    (cond
     ((atom? aexp) (number? aexp))
     (#t (and
	  (numbered? (car aexp))
	  (numbered? (car (cdr (cdr aexp)))))))))

;;; ************************************************
;;; * The Eighth Commandment                       *
;;; *                                              *
;;; * Recur on all the subparts that are of the    *
;;; * same nature:                                 *
;;; * -- On all the sublists of a list.            *
;;; * -- On all the subexpressions of a            *
;;; *    representation of an arithmetic           *
;;; *    expression.                               *
;;; ************************************************


;;; Write VALUE
(define value
  (lambda(aexp)
    (cond
     ((number? aexp) aexp)
     ((eq? (car (cdr aexp)) '+)
      (+ (value (car aexp))
	 (value (car (cdr (cdr aexp))))))
     ((eq? (car (cdr aexp)) '*)
      (* (value (car aexp))
	 (value (car (cdr (cdr aexp))))))
     (#t (expt (value (car aexp))
	       (value (car (cdr (cdr aexp)))))))))

;;; Write the function VALUE for a new kind of
;;; arithmetic expression that is either
;;;   -- a number
;;;   -- a list of the atom PLUS followed by
;;;      two arithmetic expressions
;;;   -- a list of the atom TIMES followed by
;;;      two arithmetic expressions
;;;   -- a list of the atom EXPT followed by
;;;      two arithmetic expressions
(define value
  (lambda (aexp)
    (cond
     ((number? aexp) aexp)
     ((eq? (car aexp) 'plus)
      (+ (value (cdr aexp))
	 (value (cdr (cdr aexp)))))
     ((eq? (car aexp) 'times)
      (* (value (cdr aexp))
	 (value (cdr (cdr aexp)))))
     (#t (expt (value (cdr aexp))
	       (value (cdr (cdr aexp))))))))

;;; Fail
(value '(plus 1 3))

;;; Write a function 1ST-SUB-EXP
;;; for arithmetic expressions
(define 1st-sub-exp
  (lambda (aexp)
    (cond
     (#t (car (cdr aexp))))))

;;; Write it as a one-liner
(define 1st-sub-exp (lambda (aexp) (car (cdr aexp))))

;;; Write 2ND-SUB-EXP for arithmetic expressions
(define 2nd-sub-exp (lambda (aexp) (car (cdr (cdr aexp)))))

;;; Write (OPERATOR AEXP) to replace (CAR AEXP)
(define operator (lambda (aexp) (car aexp)))

;;; Write VALUE with helps
(define value
  (lambda (aexp)
    (cond
     ((number? aexp) aexp)
     ((eq? (operator aexp) 'plus)
      (+ (value (1st-sub-exp aexp))
	 (value (2nd-sub-exp aexp))))
     ((eq? (operator aexp) 'times)
      (* (value (1st-sub-exp aexp))
	 (value (2nd-sub-exp aexp))))
     (#t (expt (value (1st-sub-exp aexp))
	       (value (2nd-sub-exp aexp)))))))

;;; Change VALUE to support earlier style of
;;; arithmetic expression (infix)
(define 1st-sub-exp (lambda (aexp) (car aexp)))

(define operator (lambda (aexp) (car (cdr aexp))))

;;; ************************************************
;;; * The Ninth Commandment                        *
;;; *                                              *
;;; * Use help functions to abstract from          *
;;; * representations.                             *
;;; ************************************************

;;; An alternative representation uses sequences of '() to
;;; represent numbers rather than arabic digit representation.
;;; In this scheme:
;;; () is zero
;;; (()) is one
;;; (() ()) is two
;;; (() () ()) is three

;;; Write a function to test for the null list
(define null-p
  (lambda (s)
    (and (atom? s)
	 (eq? s '()))))

;;; Write a function to test for zero
(define zero-p
  (lambda (n)
    (null-p n)))

;;; Write ADD1
(define add1-p
  (lambda (n)
    (cons '() n)))

;;; Write SUB1
(define sub1-p
  (lambda (n)
    (cdr n)))

;;; Rewrite + using this representation
(define my-+
  (lambda (n m)
    (cond
     ((zero-p m) n)
     (#t (add-p (my-+ n (sub1-p m)))))))

;;; Write the function NUMBER-P
(define number-p
  (lambda (n)
    (cond
     ((null-p n) #t)
     (#t (and
	  (null-p (car n)
	  (number-p (cdr n))))))))

;;; === EXERCISES ===
;;; For these exercises,
;;;   AEXP1 is: (1 + (3 * 4))
;;;   AEXP2 is: ((3 ^ 4) + 5)
;;;   AEXP3 is: (3 * (4 * (5 * 6)))
;;;   AEXP4 is: 5
;;;   L1 is: ()
;;;   L2 is: (3 + (66 6))
;;;   LEXP1 is: (AND (OR x y) y)
;;;   LEXP2 is: (AND (NOT y) (OR u v))
;;;   LEXP3 is: (OR x y)
;;;   LEXP4 is: z

;;; 7.1 So far we have neglected functions that build representations
;;; for arithmetic expressions. For example MK+EXP
(define mk+exp
  (lambda (aexp1 aexp2)
    (cons aexp1 (cons '+ (cons aexp2 '())))))
;;; makes an arithmetic expression of the form (AEXP1 + AEXP2),
;;; where AEXP1, AEXP2 are already known arithmetic expressions.
;;; Write the corresponding functions MK*EXP and MK^EXP
(define mk*exp
  (lambda (aexp1 aexp2)
    (cons aexp1 (cons '* (cons aexp2 '())))))

(define mk^exp
  (lambda (aexp1 aexp2)
    (cons aexp1 (cons '^ (cons aexp2 '())))))

;;; The arithmetic expression (1 + 3) can now be built by
;;; (MK+EXP X Y), where
;;;   X is: 1
;;;   Y is: 3
(let ((X 1)
      (Y 3))
  (mk+exp X Y))

;;; Show how to build AEXP1, AEXP2, and AEXP3
(let ((X 1)
      (Y 3)
      (Z 4))
  (mk+exp 1 (mk*exp Y Z)))

(let ((X 3)
      (Y 4)
      (Z 5))
  (mk+exp (mk^exp X Y) Z))

(let ((W 3)
      (X 4)
      (Y 5)
      (Z 6))
  (mk*exp W (mk*exp X (mk*exp Y Z))))

;;; 7.2 A useful function is AEXP? that checks whether an
;;; S-expression is the representation of an arithmetic
;;; expression. Write the function AEXP? and test it with
;;; some of the arithmetic expressions from the chapter.
;;; Alsom test it with S-expressions that are not arithmetic
;;; expressions.
;;;   Examples:
;;;     (AEXP? AEXP1) is: true
;;;     (AEXP? AEXP2) is: true
;;;     (AEXP? L1) is: FALSE
;;;     (AEXP? L2) is: FALSE
(define is-+?
  (lambda (s) (and (atom? s) (eq? s '+))))
(define is-*?
  (lambda (s) (and (atom? s) (eq? s '*))))
(define is-^?
  (lambda (s) (and (atom? s) (eq? s '^))))
(define is-operator?
  (lambda (s) (or (is-+? s) (is-*? s) (is-^? s))))

(define aexp?
  (lambda (s)
    (cond
     ((null? s) #f)
     ((atom? s) (number? s))
     ((eq? (length s) 3)
      (cond
       ((is-operator? (operator s))
	(and (aexp? (1st-sub-exp s))
	     (aexp? (2nd-sub-exp s))))
       (#t #f)))
     (#t #f))))

(aexp? 1)
(aexp? 3)
(aexp? 'cookie)

(let ((S '(3 + (4 ^ 5))))
  (aexp? S))

(let ((S '(2 * sausage)))
  (aexp? S))

(let ((AEXP1 '(1 + (3 * 4))))
  (aexp? AEXP1))

(let ((AEXP2 '((3 ^ 4) + 5)))
  (aexp? AEXP2))

(let ((L1 '()))
  (aexp? L1))

(let ((L2 '(3 + (66 6))))
  (aexp? L2))

;;; 7.3 Write the function COUNT-OP that counts the operators in
;;;   an arithmetic expression.
;;;   Examples:
;;;     (COUNT-OP AEXP1) is: 2
;;;     (COUNT-OP AEXP3) is: 3
;;;     (COUNT-OP AEXP4) is: 0
(define atom-or-nil? (lambda (a) (or (null? a) (atom? a))))
(define count-op
  (lambda (aexp)
    (cond
     ((atom-or-nil? aexp) 0)
     ((is-operator? (operator aexp))
      (add1 (+ (count-op (1st-sub-exp aexp))
	       (count-op (2nd-sub-exp aexp))))))))

(let ((AEXP1 '(1 + (3 * 4))))
  (count-op AEXP1))

(let ((AEXP3 '(3 * (4 * (5 * 6)))))
  (count-op AEXP3))

(let ((AEXP4 5))
  (count-op AEXP4))

;;; Also write the functions COUNT-+, COUNT-*, and COUNT-^
;;; that count the respective operators.
;;;   Examples:
;;;     (COUNT-+ AEXP1) is: 1
;;;     (COUNT-* AEXP1) is: 1
;;;     (COUNT-^ AEXP1) is: 0
(define count-+
  (lambda (aexp)
    (cond
     ((atom-or-nil? aexp) 0)
     (#t (+ (cond ((is-+? (operator aexp)) 1)
		  (#t 0))
	 (count-+ (1st-sub-exp aexp))
	 (count-+ (2nd-sub-exp aexp)))))))

(let ((AEXP1 '(1 + (3 * 4))))
  (count-+ AEXP1))

(define count-*
  (lambda (aexp)
    (cond
     ((atom-or-nil? aexp) 0)
     (#t (+ (cond ((is-*? (operator aexp)) 1)
		  (#t 0))
	    (count-* (1st-sub-exp aexp))
	    (count-* (2nd-sub-exp aexp)))))))

(let ((AEXP1 '(1 + (3 * 4))))
  (count-* AEXP1))

(define count-^
  (lambda (aexp)
    (cond
     ((atom-or-nil? aexp) 0)
     (#t (+ (cond ((is-^? (operator aexp)) 1)
		  (#t 0))
	    (count-^ (1st-sub-exp aexp))
	    (count-^ (2nd-sub-exp aexp)))))))

(let ((AEXP1 '(1 + (3 * 4))))
  (count-^ AEXP1))

;;; 7.4 Write the function COUNT-NUMBERS that counts the numbers
;;;   in an arithmetic expression.
;;;   Examples:
;;;     (COUNT-NUMBERS AEXP1) is: 3
;;;     (COUNT-NUMBERS AEXP3) is: 4
;;;     (COUNT-NUMBERS AEXP4) is: 1
(define count-numbers
  (lambda (aexp)
    (cond
     ((null? aexp) 0)
     ((atom? aexp) (cond ((number? aexp) 1)
			 (#t 0)))
     (#t (+ (count-numbers (1st-sub-exp aexp))
	    (count-numbers (2nd-sub-exp aexp)))))))

(let ((AEXP1 '(1 + (3 * 4))))
  (count-numbers AEXP1))

(let ((AEXP3 '(3 * (4 * (5 * 6)))))
  (count-numbers AEXP3))

(let ((AEXP4 5))
  (count-numbers AEXP4))

;;; 7.5 Since it is inconvenient to write (3 * (4 * (5 * 6))) for
;;;  multiplying 4 numbers, we now introduce prefix notation and
;;;  allow + and * expressions to contain 2, 3 or 4 subexpressions.
;;;  For example, (+ 3 2 (* 7 8)), (* 3 4 5 6), etc. are now legal
;;;  representations. ^-expressions are also in prefix form but
;;;  still binary.
;;;  Rewrite the functions NUMBERED? and VALUE for the new
;;;  definition of AEXP.
;;;  Hint: You will need the functions for extracting the third
;;;  and fourth subexpreson of an arithmetic expression. You will
;;;  also need a function CNT-AEXP that counts the number of
;;;  arithmetic subexpressions in the list following an operator.
;;;   Examples:
;;;     When
;;;       AEXP1 is: (+ 3 2 (* 7 8))
;;;       AEXP2 is: (* 3 4 5 6)
;;;       AEXP3 is: (^ AEXP1 AEXP2)
;;;     then
;;;       (cnt-aexp AEXP1) is: 3
;;;       (cnt-aexp AEXP2) is: 4
;;;       (cnt-aexp AEXP3) is: 2
(define operator (lambda (aexp) (car aexp)))
(let ((AEXP2 '(* 3 4 5 6)))
  (operator AEXP2))

(define 1st-sub-exp (lambda (aexp) (car (cdr aexp))))
(let ((AEXP2 '(* 3 4 5 6)))
  (1st-sub-exp AEXP2))

(define 2nd-sub-exp (lambda (aexp) (car (cdr (cdr aexp)))))
(let ((AEXP2 '(* 3 4 5 6)))
  (2nd-sub-exp AEXP2))

(define 3rd-sub-exp (lambda (aexp) (car (cdr (cdr (cdr aexp))))))
(let ((AEXP2 '(* 3 4 5 6)))
  (3rd-sub-exp AEXP2))

(define 4th-sub-exp (lambda (aexp) (car (cdr (cdr (cdr (cdr aexp)))))))
(let ((AEXP2 '(* 3 4 5 6)))
  (4th-sub-exp AEXP2))

(define cnt-aexp
  (lambda (aexp)
    (cond
     ((null? aexp) 0)
     ((atom? aexp) 1)
     ((is-operator? (operator aexp)) (cnt-aexp (cdr aexp)))
     (#t (add1 (cnt-aexp (cdr aexp)))))))

(let ((AEXP1 '(+ 3 2 (* 7 8))))
  (cnt-aexp AEXP1))
(let ((AEXP2 '(* 3 4 5 6)))
  (cnt-aexp AEXP2))
(let ((AEXP3 '(^ (+ 3 2 (* 7 8)) (* 3 4 5 6))))
  (cnt-aexp AEXP3))

(define numbered?
  (lambda (aexp)
    (cond
     ((null? aexp) #f)
     ((atom? aexp) (number? aexp))
     (#t (cond
	  ((eq? (cnt-aexp aexp) 4)
	   (and (numbered? (1st-sub-exp aexp))
		(numbered? (2nd-sub-exp aexp))
		(numbered? (3rd-sub-exp aexp))
		(numbered? (4th-sub-exp aexp))))
	  ((eq? (cnt-aexp aexp) 3)
	   (and (numbered? (1st-sub-exp aexp))
		(numbered? (2nd-sub-exp aexp))
		(numbered? (3rd-sub-exp aexp))))
	  (#t (eq? (cnt-aexp aexp) 2)
	      (and (numbered? (1st-sub-exp aexp))
		   (numbered? (2nd-sub-exp aexp)))))))))

(let ((AEXP1 '(+ 3 2 (* 7 8))))
  (numbered? AEXP1))
(let ((AEXP2 '(* 3 4 5 6)))
  (numbered? AEXP2))
(let ((AEXP3 '(^ (+ 3 2 (* 7 8)) (* 3 4 5 6))))
  (numbered? AEXP3))

(define value
  (lambda (aexp)
    (cond
     ((number? aexp) aexp)
     ((eq? (operator aexp) '+)
      (cond ((eq? (cnt-aexp aexp) 4)
	     (+ (value (1st-sub-exp aexp))
		(value (2nd-sub-exp aexp))
		(value (3rd-sub-exp aexp))
		(value (4th-sub-exp aexp))))
	    ((eq? (cnt-aexp aexp) 3)
	     (+ (value (1st-sub-exp aexp))
		(value (2nd-sub-exp aexp))
		(value (3rd-sub-exp aexp))))
	    (#t (+ (value (1st-sub-exp aexp))
		   (value (2nd-sub-exp aexp))))))
     ((eq? (operator aexp) '*)
      (cond ((eq? (cnt-aexp aexp) 4)
	     (* (value (1st-sub-exp aexp))
		(value (2nd-sub-exp aexp))
		(value (3rd-sub-exp aexp))
		(value (4th-sub-exp aexp))))
	    ((eq? (cnt-aexp aexp) 3)
	     (* (value (1st-sub-exp aexp))
		(value (2nd-sub-exp aexp))
		(value (3rd-sub-exp aexp))))
	    (#t (* (value (1st-sub-exp aexp))
		   (value (2nd-sub-exp aexp))))))
     (#t (expt (value (1st-sub-exp aexp))
	       (value (2nd-sub-exp aexp)))))))

(let ((AEXP1 '(+ 3 2 (* 7 8))))
  (value AEXP1))
(let ((AEXP2 '(* 3 4 5 6)))
  (value AEXP2))
(let ((AEXP3 '(^ (+ 3 2 (* 7 8)) (* 3 4 5 6))))
  (value AEXP3))

;;; 7.7 Write the function COVERED? of LEXP and LAT that tests
;;;   whether all the variables in LEXP are in LAT.
;;;   Examples:
;;;     When
;;;       L1 is: (x y z u)
;;;     then
;;;       (COVERED? LEXP1 L1) is: true
;;;       (COVERED? LEXP2 L1) is: false
;;;       (COVERED? LEXP3 L1) is: true
(define covered?
  (lambda (lexp lat)
    (cond
     ((atom? lexp) (member? lexp lat))
     (#t (cond
	  ((or (eq? (operator lexp) 'AND)
	       (eq? (operator lexp) 'OR))
	   (and (covered? (1st-sub-exp lexp) lat)
		(covered? (2nd-sub-exp lexp) lat)))
	  (#t (covered? (1st-sub-exp lexp) lat)))))))

(let ((LEXP1 '(AND (OR x y) y))
      (L1 '(x y z u)))
  (covered? LEXP1 L1))
(let ((LEXP2 '(AND (NOT y) (OR u v)))
      (L1 '(x y z u)))
  (covered? LEXP2 L1))
(let ((LEXP3 '(OR x y))
      (L1 '(x y z u)))
  (covered? LEXP3 L1))
(let ((LEXP4 'z)
      (L1 '(x y z u)))
  (covered? LEXP4 L1))
(let ((LEXP4 'z)
      (L1 '(a b c)))
  (covered? LEXP4 L1))

;;; 7.8 For the evaluation of L-expressions we will need an ALIST.
;;;   An ALIST for L-expressions is a list of pairs. The first
;;;   component of a pair is always an atom, the second pair is
;;;   either the number 0 (signifying false) or 1 (signifying true).
;;;   The second component is referred to as the value of the
;;;   variable. Write the function LOOKUP of VAR and ALIST that
;;;   returns the value of the first pair in ALIST whose CAR is
;;;   EQ? to VAR.
;;;   Examples:
;;;     When
;;;       L1 is: ((x 1) (y 0))
;;;       L2 is: ((u 1) (v 1))
;;;       L3 is: ()
;;;        A is: y
;;;        B is: u
;;;     then
;;;       (LOOKUP A L1) is: 0
;;;       (LOOKUP B L2) is: 1
;;;       (LOOKUP A L3) has no answer
(define pair-var (lambda (pair) (car pair)))
(define pair-value (lambda (pair) (car (cdr pair))))
(define lookup
  (lambda (var alist)
    (cond
   ((null? alist) '())
   ((eq? var (pair-var (car alist)))
    (pair-value (car alist)))
   (#t (lookup var (cdr alist))))))

(let ((A 'y)
      (L1 '((x 1) (y 0))))
  (lookup A L1))
(let ((B 'u)
      (L2 '((u 1) (v 1))))
  (lookup B L2))
(let ((A 'y)
      (L3 '()))
  (lookup A L3))

 ;;; 7.9 If the list of atoms in an alist for L-expressions contains
;;;   all the variables of an L-expression LEXP, then LEXP can be
;;;   evaluated with respect to this alist. (Use the function
;;;   COVERED? from exercise 7.7 for the appropriate test).
;;;   Write the function MLEXP of LEXP and ALIST.
;;;   (MLEXP LEXP ALIST) is true
;;;   -- if LEXP is a variable and its value is true, or
;;;   -- if LEXP is an AND-expression and both subexpressions yield true, or
;;;   -- if LEXP is an OR-expression and one of the subexpressions yields true, or
;;;   -- if LEXP is a NOT-expression and the subexpression yields false
;;;   Otherwise MLEXP yields false.
;;;   MLEXP has no answer if the expression is not covered by
;;;   (FIRSTS ALIST)
;;;
;;;   Examples:
;;;     When
;;;       L1 is: ((x 1) (y 0) (z 0))
;;;       L2 is: ((y 0) (u 0) (v 1))
;;;     then
;;;       (MLEXP LEXP1 L1) is: false
;;;       (MLEXP LEXP2 L2) is: true
;;;       (MLEXP LEXP4 L1) is: false
;;;  Hint: You will need the function LOOKUP from exercise 7.8
(define firsts
  (lambda (alist)
    (cond
     ((null? alist) '())
     (#t (cons (pair-var (car alist))
	       (firsts (cdr alist)))))))
(firsts '((x 1) (y 0) (z 0)))

(define Mlexp
  (lambda (lexp alist)
    (when (covered? lexp (firsts alist)) 
	(cond
	 ((atom? lexp) (lookup lexp alist))
	 (#t (cond
	      ((and (eq? (operator lexp) 'AND)
		    (eq? 1 (Mlexp (1st-sub-exp lexp) alist))
		    (eq? 1 (Mlexp (2nd-sub-exp lexp) alist)))
	       1)
	      ((and (eq? (operator lexp) 'OR)
		    (or (eq? 1 (Mlexp (1st-sub-exp lexp) alist))
			(eq? 1 (Mlexp (2nd-sub-exp lexp) alist))))
	       1)
	      ((and (eq? (operator lexp) 'NOT)
		    (eq? 0 (Mlexp (1st-sub-exp lexp) alist)))
	       1)
	      (#t 0)))))))

(let ((LEXP1 '(AND (OR x y) y))
      (L1 '((x 1) (y 0) (z 0))))
    (Mlexp LEXP1 L1))

(let ((LEXP2 '(AND (NOT y) (OR u v)))
      (L2 '((y 0) (u 0) (v 1))))
  (Mlexp LEXP2 L2))

(let ((LEXP4 'z)
      (L1 '((x 1) (y 0) (z 0))))
  (Mlexp LEXP4 L1))

(let ((LEXP2 '(AND (NOT y) (OR u v)))
      (L3 '((x 1) (y 0))))
  (Mlexp LEXP2 L3))

;;; 7.10 Extend the representation of L-expressions to AND and OR
;;;   several subexpressions, i.e.,
;;;     (AND x (OR u v w) y)
;;;   Rewrite the function MLEXP from exercise 7.9 for this representation.
;;;   Hint: Exercise 7.5 is a similar extension of arithmetic expressions.
(define is-and? (lambda (op) (eq? op 'AND)))
(define is-or? (lambda (op) (eq? op 'OR)))
(define is-not? (lambda (op) (eq? op 'NOT)))
(define is-lop?
  (lambda (op)
    (or (is-and? op)
	(is-or? op)
	(is-not? op))))

(define cnt-lexp
  (lambda (lexp)
    (cond
     ((null? lexp) 0)
     ((atom? lexp) 1)
     ((is-lop? (operator lexp)) (cnt-lexp (cdr lexp)))
     (#t (add1 (cnt-lexp (cdr lexp)))))))

(define Mlexp
  (lambda (lexp alist)
    (when (covered? lexp (firsts alist)) 
      (cond
       ((atom? lexp) (lookup lexp alist))
       (#t (cond
	    ((and (is-and? (operator lexp))
		  (eq? (cnt-lexp lexp) 4)
		  (eq? 1 (Mlexp (4th-sub-exp lexp) alist))
		  (eq? 1 (Mlexp (3rd-sub-exp lexp) alist))
		  (eq? 1 (Mlexp (2nd-sub-exp lexp) alist))
		  (eq? 1 (Mlexp (1st-sub-exp lexp) alist)))
	     1)
	   ((and (is-and? (operator lexp))
		 (eq? (cnt-lexp lexp) 3)
		 (eq? 1 (Mlexp (3rd-sub-exp lexp) alist))
		 (eq? 1 (Mlexp (2nd-sub-exp lexp) alist))
		 (eq? 1 (Mlexp (1st-sub-exp lexp) alist)))
	    1)
	   ((and (is-and? (operator lexp))
		 (eq? (cnt-lexp lexp) 2)
		 (eq? 1 (Mlexp (2nd-sub-exp lexp) alist))
		 (eq? 1 (Mlexp (1st-sub-exp lexp) alist)))
	    1)
	   ((and (is-or? (operator lexp))
		 (eq? (cnt-lexp lexp) 4)
		 (or (eq? 1 (Mlexp (4th-sub-exp lexp) alist))
		     (eq? 1 (Mlexp (3rd-sub-exp lexp) alist))
		     (eq? 1 (Mlexp (2nd-sub-exp lexp) alist))
		     (eq? 1 (Mlexp (1st-sub-exp lexp) alist))))
	    1)
	   ((and (is-or? (operator lexp))
		 (eq? (cnt-lexp lexp) 3)
		 (or (eq? 1 (Mlexp (3rd-sub-exp lexp) alist))
		     (eq? 1 (Mlexp (2nd-sub-exp lexp) alist))
		     (eq? 1 (Mlexp (1st-sub-exp lexp) alist))))
	    1)
	   ((and (is-or? (operator lexp))
		(eq? (cnt-lexp lexp) 2)
		(or (eq? 1 (Mlexp (2nd-sub-exp lexp) alist))
		    (eq? 1 (Mlexp (1st-sub-exp lexp) alist))))
	    1)
	   ((and (is-not? (operator lexp))
		(eq? 0 (Mlexp (1st-sub-exp lexp) alist)))
	    1)
	   (#t 0)))))))

(let ((LEXP1 '(AND (OR x y) y))
      (L1 '((x 1) (y 0) (z 0))))
    (Mlexp LEXP1 L1))

(let ((LEXP2 '(AND (NOT y) (OR u v)))
      (L2 '((y 0) (u 0) (v 1))))
  (Mlexp LEXP2 L2))

(let ((LEXP4 'z)
      (L1 '((x 1) (y 0) (z 0))))
  (Mlexp LEXP4 L1))

(let ((LEXP2 '(AND x (OR u v w) y))
      (L3 '((w 1) (x 1) (y 0) (u 1) (v 0))))
  (Mlexp LEXP2 L3))

;;; *******************************************
;;; *          Friends and Relations          *
;;; *******************************************

;;; Write SETP
(define set?
  (lambda (lat)
    (cond
     ((null? lat) #t)
     (#t (cond
	  ((member? (car lat) (cdr lat))
	   #f)
	  (#t (set? (cdr lat))))))))

(let ((LAT '(apples peaches pears plums)))
  (set? LAT))

(set? '())

;;; Simplify SET?
(define set?
  (lambda (lat)
    (cond
     ((null? lat) #t)
     ((member? (car lat) (cdr lat)) #f)
     (#t (set? (cdr lat))))))

(let ((LAT '(apple 3 pear 4 9 apple 3 4)))
  (set? LAT))

;;; Write MAKESET using MEMBER
(define makeset
  (lambda (lat)
    (cond
     ((null? lat) '())
     ((member? (car lat) (cdr lat)) (makeset (cdr lat)))
     (#t (cons (car lat) (makeset (cdr lat)))))))

(let ((LAT '(apple 3 pear 4 9 apple 3 4)))
  (makeset LAT))

(let ((LAT '(apple 3 pear 4 9 apple 3 4)))
  (set? (makeset LAT)))

;;; What is the result of (MAKESET LAT), where
;;;   LAT is: (apple peach pear peach plum apple lemon peach)
(let ((LAT '(apple peach pear peach plum apple lemon peach)))
  (makeset LAT))

;;; Write MAKESET, using MULTIREMBER
(define makeset
  (lambda (lat)
    (cond
     ((null? lat) '())
     (#t (cons (car lat)
	       (makeset
		(multirember
		 (car lat) (cdr lat))))))))

;;; What is (SUBSET? SET1 SET2), where
;;;   SET1 is: (5 chicken wings)
;;;   and SET2 is: (5 hamburgers 2 pieces fried chicken
;;;             and light duckling wings)
(let ((SET1 '(5 chicken wings))
      (SET2 '(5 hamburgers 2 pieces fried chicken
		and light duckling wings)))
  (subset? SET1 SET2))

;;; What is (SUBSET? SET1 SET2), where
;;;   SET1 is: (4 pounds of horseradish)
;;;   and SET2 is: (four pounds chicken and 5 ounces horseradish)
(let ((SET1 '(4 pounds of horseradish))
      (SET2 '(four pounds chicken and 5 ounces horseradish)))
  (subset? SET1 SET2))

;;; Write SUBSET?
(define subset?
  (lambda (set1 set2)
    (cond
     ((null? set1) #t)
     ((member? (car set1) set2)
      (subset? (cdr set1) set2))
     (#t #f))))

;;; Write SUBSET? with AND
(define subset?
  (lambda (set1 set2)
    (cond
     ((null? set1) #t)
     (#t (and (member? (car set1) set2)
	      (subset? (cdr set1) set2))))))

;;; What is (EQSETP SET1 SET2), where
;;;   SET1 is: (6 large chickens with wings)
;;;   and SET2 is: (6 chickens with large wings)
(let ((SET1 '(6 large chickens with wings))
      (SET2 '(6 chickens with large wings)))
  (eqset? SET1 SET2))

;;; Write EQSET?
(define eqset?
  (lambda (set1 set2)
    (and (subset? set1 set2)
	 (subset? set2 set1))))
 
;;; (INTERSECT? SET1 SET2), where
;;;   SET1 is: (tomatoes and macaroni)
;;;   and SET2 is: (macaroni and cheese)
(let ((SET1 '(tomatoes and macaroni))
      (SET2 '(macaroni and cheese)))
  (intersect? SET1 SET2))

;;; Write INTERSECT?
;;; my solution
(define intersect?
  (lambda (set1 set2)
    (cond ((null? set1) #f)
	  (#t (or (subset? set1 set2)
		  (intersect? (cdr set1) set2))))))

;;; book solution
(define intersect?
  (lambda (set1 set2)
    (cond
     ((null? set1) #f)
     (#t (cond
	  ((member? (car set1) set2) #t)
	  (#t (intersect?
	      (cdr set1) set2)))))))

;;; shorter version
(define intersect?
  (lambda (set1 set2)
    (cond
     ((null? set1) #f)
     ((member? (car set1) set2) #t)
     (#t (intersect? (cdr set1) set2)))))

;;; Write INTERSECTP with OR
(define intersect?
  (lambda (set1 set2)
    (cond
     ((null? set1) #f)
     (#t (or (member? (car set1) set2)
	     (intersect? (cdr set1) set2))))))

;;; What is (INTERSECT SET1 SET2), where
;;;   SET1 is: (tomatoes and macaroni)
;;;   and SET2 is: (macaroni and cheese)
(let ((SET1 '(tomatoes and macaroni))
      (SET2 '(macaroni and cheese)))
  (intersect SET1 SET2))

;;; Write INTERSECT
(define intersect
  (lambda (set1 set2)
    (cond
     ((null? set1) '())
     ((member? (car set1) set2)
      (cons (car set1) (intersect (cdr set1) set2)))
     (#t (intersect (cdr set1) set2)))))

;;; Rewrite INTERSECT with
;;;   (member (car set1) set2)
;;; replaced with
;;;   (not (member (car set1) set2))
(define intersect
  (lambda (set1 set2)
    (cond
     ((null? set1) '())
     ((not (member? (car set1) set2))
      (intersect (cdr set1) set2))
     (#t (cons (car set1)
	       (intersect (cdr set1) set2))))))

;;; What is (UNION SET1 SET2), where
;;;   SET1 is: (tomatoes and macaroni casserole)
;;;   and SET2 is: (macaroni and cheese)
(let ((SET1 '(tomatoes and macaroni casserole))
      (SET2 '(macaroni and cheese)))
  (union SET1 SET2))

;;; my version
(define union
  (lambda (set1 set2)
    (cond
     ((null? set1) set2)
     ((null? set2) set1)
     (#t (makeset (cons (car set1)
			(cons (car set2)
			      (union (cdr set1) (cdr set2)))))))))

;;; book version
(define union
  (lambda (set1 set2)
    (cond
     ((null? set1) set2)
     ((member? (car set1) set2)
      (union (cdr set1) set2))
     (#t (cons (car set1)
	       (union (cdr set1) set2))))))

;;; COMPLEMENT is the function which returns all the atoms
;;; in SET1 that are not in SET2
(define complement
  (lambda (set1 set2)
    (cond
     ((null? set1) '())
     ((member? (car set1) set2)
      (complement (cdr set1) set2))
     (#t (cons (car set1)
	       (complement (cdr set1) set2))))))

(let ((SET1 '(tomatoes and macaroni casserole))
      (SET2 '(macaroni and cheese)))
  (complement SET1 SET2))

;;; What is (INTERSECTALL L-SET), where
;;;   L-SET is: ((a b c) (c a d e) (e f g h a b))
(let ((L-SET '((a b c) (c a d e) (e f g h a b))))
  (intersectall L-SET))

;;; What is (INTERSECTALL L-SET), where
;;;   L-SET is: ((6 pears and)
;;;              (3 peaches and 6 peppers)
;;;              (8 pears and 6 plums)
;;;              (and 6 prunes with lots of apples))
(let ((L-SET '((6 pears and)
              (3 peaches and 6 peppers)
              (8 pears and 6 plums)
              (and 6 prunes with lots of apples))))
  (intersectall L-SET))

;;; Now using whatever help functions you need,
;;; write INTERSECTALL assuming that the list of
;;; sets is non-empty
(define intersectall
  (lambda (l-set)
    (cond
     ((null? (cdr l-set)) (car l-set))
     (#t (intersect (car l-set)
		    (intersectall (cdr l-set)))))))

;;; Is this a PAIRP
(pear pear)

;;; Is this a pair?
(3 7)

;;; Is this a pair?
(2 pair)

;;; Is this a pair?
(full house)

;;; How can you refer to the first atom of a pair?
(car a-pair)

;;; How can you refer to the second atom of a pair?
(car (cdr a-pair))

;;; How can you make a pair with two atoms?
(cons a1 (cons a2 '()))

(define first (lambda (p) (car p)))
(define second (lambda (p) (car (cdr p))))
(define makepair (lambda (a1 a2) (cons a1 (cons a2 '()))))

;;; Write THIRD as a one-liner
(define third
  (lambda (l)
    (cond
     ((null? (cdr (cdr l))) '())
     (#t (car (cdr (cdr l)))))))

(define pair?
  (lambda (lat)
    (and (atom? (first lat))
	 (atom? (second lat))
	 (null? (third lat)))))

(pair? '(pumpkin pie))

(define rel?
  (lambda (l)
    (cond
     ((null? (cdr l)) (pair? (car l)))
     (#t (and (pair? (car l)) (rel? (cdr l)))))))

;;; Is L a rel, where
;;;   L is: ((apples peaches) (pumpkin pie))
(let ((L '((apples peaches) (pumpkin pie))))
  (rel? L))

;;; Is L a rel, where
;;;   L is: ((4 3) (4 2) (7 6) (6 2) (3 4))
(let ((L '((4 3) (4 2) (7 6) (6 2) (3 4))))
  (rel? L))

;;; Is L a fun, where
;;;   L is: ((4 3) (4 2) (7 6) (6 2) (3 4))
(let ((L '((4 3) (4 2) (7 6) (6 2) (3 4))))
  (fun? L))

;;; What is (FUNP REL), where
;;;   REL is: ((8 3) (4 2) (7 6) (6 2) (3 4))
(let ((L '((8 3) (4 2) (7 6) (6 2) (3 4))))
  (fun? L))

;;; Write FUNP
(define fun?
  (lambda (rel)
    (set? (firsts rel))))

;;; book version
(define fun?
  (lambda (rel)
    (cond
     ((null? rel) #t)
     ((member*? (first (car rel)) (cdr rel)) #f)
     (#t (fun? (cdr rel))))))

;;; When will this definition of FUNP work?
;;; A: When
;;;      (not (intersectp (firsts rel) (seconds rel)))
c
;;; try again book version
(define fun?
  (lambda (rel)
    (cond
     ((null? rel) #t)
     ((member? (first (car rel))
	       (firsts (cdr rel))) #f)
   (#t (fun? (cdr rel))))))

;;; Rewrite FUNP with SETP
(define fun?
  (lambda (rel)
    (set? (firsts rel))))

;;; What is (REVREL REL), where
;;;   REL is: ((8 a) (pumpkin pie) (got sick))
(let ((REL '((8 a) (pumpkin pie) (got sick))))
  (revrel REL))

(define revrel
  (lambda (l)
    (cond
     ((null? l) '())
     ((null? (cdr l)) (cons (makepair (second (car l))
				      (first (car l)))
			    '()))  
     (#t (cons (makepair (second (car l))
			 (first (car l)))
	       (revrel (cdr l)))))))

;;; book version
(define revrel
  (lambda (rel)
    (cond
     ((null? rel) '())
     (#t (cons (makepair
		(second (car rel))
		(first (car rel)))
	       (revrel (cdr rel)))))))

;;; Also correct, sacrificing readability
(define revrel
  (lambda (rel)
    (cond
     ((null? rel) '())
     (#t (cons
	  (cons
	   (car (cdr (car rel)))
	   (cons
	    (car (car rel))
	    '()))
	  (revrel (cdr rel)))))))

;;; Guess why FUN is not a FULLFUN, where
;;;   FUN is ((8 3) (4 2) (7 6) (6 2) (3 4))
;;; A: FUN is not a FULLFUN, since the 2 appears
;;;    more than once as a second atom of a pair
(let ((FUN '((8 3) (4 2) (7 6) (6 2) (3 4))))
  (fullfun? FUN))

;;; Why is T the value of (FULLFUN? FUN), where
;;;   FUN is: ((8 3) (4 8) (7 6) (6 2) (3 4))
;;; A: Because the list:
;;;      (3 8 6 2 4)
;;;    is a set
(let ((FUN '((8 3) (4 8) (7 6) (6 2) (3 4))))
  (fullfun? FUN))

;;; What is (FULLFUN? FUN), where
;;;   FUN is: ((grape raisin)
;;;            (plum prune)
;;;            (stewed prune))
(let ((FUN '((grape raisin)
	     (plum prune)
	     (stewed prune))))
  (fullfun? FUN))

;;; What is (FULLFUN? FUN), where
;;;   FUN is: ((grape raisin)
;;;            (plum prune)
;;;            (stewed grape))
(let ((FUN '((grape raisin)
	     (plum prune)
	     (stewed grape))))
  (fullfun? FUN))

(define fullfun?
  (lambda (fun)
    (and (fun? fun)
	 (set? (seconds fun)))))

;;; What is another function name for FULLFUN? ?
;;; A: ONE-TO-ONE?

;;; Can you think of a second way to write ONE-TO-ONE?
(define one-to-one?
  (lambda (fun)
    (fun? (revrel fun))))

;;; === EXERCISES ===
;;; For these exercises,
;;;   R1 is: ((a b) (a a) (b b))
;;;   R2 is: ((c c))
;;;   R3 is: ((a c) (b c))
;;;   R4 is: ((a b) (b a))
;;;   F1 is: ((a 1) (b 2) (c 2) (d 1))
;;;   F2 is: ()
;;;   F3 is: ((a 2) (b 1))
;;;   F4 is: ((1 $) (3 *))
;;;   D1 is: (a b)
;;;   D2 is: (c d)
;;;    X is: a

;;; 8.1 Write the function DOMSET of REL which makes a set of all the
;;;   atoms in REL. This set is referred to as domain of discourse of
;;;   the relation REL.
;;;   Examples:
;;;     (domset R1) is: (a b)
;;;     (domset R2) is: (c)
;;;     (domset R3) is: (a b c)
;;;
;;;   Also write the function IDREL of S which makes a relation of
;;;   all pairs of the form (D D) where D is an atom of the set S.
;;;   (IDREL S) is called the identity relation on S.
;;;   Examples:
;;;     (idrel D1) is: ((a a) (b b))
;;;     (idrel D2) is: ((c c) (d d))
;;;     (idrel F2) is: ()

(define domset
  (lambda (rel)
    (makeset (union (firsts rel) (seconds rel)))))

(let ((R1 '((a b) (a a) (b b))))
  (domset R1))

(let ((R2 '((c c))))
  (domset R2))

(let ((R3 '((a c) (b c))))
  (domset R3))

(define idrel
  (lambda (s)
    (cond
     ((null? s) '())
     (#t (cons
	  (cons (car s)
		(cons (car s) '()))
	  (idrel (cdr s)))))))

(let ((D1 '(a b))) (idrel D1))
(let ((D2 '(c d))) (idrel D2))
(let ((F2 '())) (idrel F2))

;;; 8.2 Write the function REFLEXIVE? which tests whether a relation
;;;   is reflexive if it contains all pairs of the form (D D) where
;;;   D is an element of its domain of discourse (see Exercise 8.1).
;;;   Examples:
;;;     (reflexive? R1) is: true
;;;     (reflexive? R2) is: true
;;;     (reflexive? R3) is: false
(define reflexive?
  (lambda (rel)
    (and (null? (complement (domset rel) (makeset (firsts rel))))
	 (null? (complement (domset rel) (makeset (seconds rel)))))))

(let ((R1 '((a b) (a a) (b b))))
  (reflexive? R1))
(let ((R2 '((c c))))
  (reflexive? R2))
(let ((R3 '((a c) (b c))))
  (reflexive? R3))

;;; 8.3 Write the function SYMMETRIC? which tests whether a relation
;;;   is symmetric. A relation is symmetric if it is EQSET? to its
;;;   REVREL.
;;;   Examples:
;;;     (symmetric? R1) is: false
;;;     (symmetric? R2) is: true
;;;     (symmetric? F2) is: true
(define member-non-atom?
  (lambda (s l)
    (cond
     ((null? l) #f)
     (#t (or (equal? s (car l))
	     (member-non-atom? s (cdr l)))))))

(define member-atom?
  (lambda (a l)
    (cond
     ((null? l) #f)
     (#t (or
	  (eq? (car l) a)
	  (member-atom? a (cdr l)))))))

(define member?
  (lambda (s l)
    (or (member-atom? s l)
	(member-non-atom? s l))))

(member? 'x '(w x y z))
(member? 'a '(w x y z))

(member? '(x y) '((a b) (x y)))
(member? '(x y) '((a b) (c d)))

(intersect '((x y)) '((a b) (c d)))
(intersect '((x y)) '((a b) (x y)))

(define symmetric?
  (lambda (rel)
    (eqset? rel (revrel rel))))

(let ((R1 '((a b) (a a) (b b))))
   (symmetric? R1))

(let ((R2 '((c c))))
    (symmetric? R2))

(let ((F2 '()))
  (symmetric? F2))

;;;   Also write the function ANTISYMMETRIC? which tests whether
;;;   a relation is antisymmetric. A relation is antisymmetric if
;;;   the intersection of the relation with its REVREL is a subset
;;;   of the identity relation on its domain of discourse (See
;;;   Exercise 8.1).
;;;   Examples:
;;;     (antisymmetric? R1) is: true
;;;     (antisymmetric? R2) is: true
;;;     (antisymmetric? R4) is: false

(define antisymmetric?
  (lambda (rel)
    (subset? (intersect rel (revrel rel))
	     (idrel (domset rel)))))

(let ((R1 '((a b) (a a) (b b))))
    (antisymmetric? R1))

(let ((R2 '((c c))))
  (antisymmetric? R2))

(let ((R4 '((a b) (b a))))
  (antisymmetric? R4))

;;;   And finally, this is the function ASYMMETRIC? which tests
;;;   whether a relation is asymmetric:
(define asymmetric?
  (lambda (rel)
    (null? (intersect rel (revrel rel)))))

;;;   Find out which of the sample relations is asymmetric.
;;;   Characterize asymmetry in one sentence.
(let ((R1 '((a b) (a a) (b b))))
  (asymmetric? R1))
(let ((R2 '((c c))))
  (asymmetric? R2))
(let ((R3 '((a c) (b c))))
  (asymmetric? R3))
(let ((R4 '((a b) (b a))))
  (asymmetric? R4))

;;; A: A relation is asymmetric if the intersection of the relation
;;; with its REVREL is empty.

;;; 8.4 Write the function FAPPLY of F and X which returns the value
;;;   of F at place X. That is, it returns the SECOND of the pair whose
;;;   FIRST is EQ to X.
;;;   Examples:
;;;     (Fapply F1 X) is: 1
;;;     (Fapply F2 X) has no answer
;;;     (Fapply F3 X) is: 2
(define Fapply
  (lambda (f x)
    (cond
     ((null? f) '())
     ((eq? (first (car f)) x) (second (car f)))
     (#t (Fapply (cdr f) x)))))

(let ((F1 '((a 1) (b 2) (c 2) (d 1)))
      (X 'a))
  (Fapply F1 X))

(let ((F2 '()) (X 'a)) (Fapply F2 X))

(let ((F3 '((a 2) (b 1))) (X 'a))
  (Fapply F3 X))

;;; 8.5 Write the function FCOMP of F and G which composes two
;;;   functions. If G contains an element (X Y) and F contains an
;;;   element (Y Z), then the composed function (FCOMP F G) will contain
;;;   (X Z).
;;;   Examples:
;;;     (Fcomp F1 F4) is: ()
;;;     (Fcomp R1 F3) is: ()
;;;     (Fcomp F4 F1) is: ((a $) (d $))
;;;     (Fcomp F4 F3) is: ((b $))
;;;
;;; Hint: The function FAPPLY from Exercise 8.4 may be useful

(define Fcomp
  (lambda (f g)
    (cond
     ((null? g) '())
     ((member? (second (car g)) (firsts f))
      (cons (makepair (first (car g))
		      (Fapply f (second (car g))))
	    (Fcomp f (cdr g))))
     (#t (Fcomp f (cdr g))))))

(let ((F1 '((a 1) (b 2) (c 2) (d 1)))
      (F4 '((1 $) (3 *))))
  (Fcomp F1 F4))

(let ((F3 '((a 2) (b 1)))
      (R1 '((a b) (a a) (b b))))
  (Fcomp R1 F3))

(let ((F1 '((a 1) (b 2) (c 2) (d 1)))
      (F4 '((1 $) (3 *))))
  (Fcomp F4 F1))

(let ((F3 '((a 2) (b 1)))
      (F4 '((1 $) (3 *))))
  (Fcomp F4 F3))

;;; 8.6 Write the function RAPPLY of REL and X which returns the value
;;; set of REL at place X. The value set is the set of second
;;; components of all the pairs whose first component is EQ to X.
;;;   Examples:
;;;     (Rapply F1 X) is: (1)
;;;     (Rapply R1 X) is: (b a)
;;;     (Rapply F2 X) is: ()
(define Rapply
  (lambda (rel x)
    (cond
     ((null? rel) '())
     ((eq? (first (car rel)) x) (cons (second (car rel)) (Rapply (cdr rel) x)))
     (#t (Rapply (cdr rel) x)))))

(let ((F1 '((a 1) (b 2) (c 2) (d 1)))
      (X 'a))
  (Rapply F1 X))

(let ((R1 '((a b) (a a) (b b)))
      (X 'a))
  (Rapply R1 X))

(let ((F2 '()) (X 'a))
  (Rapply F2 X))

;;; 8.7 Write the function RIN of X and SET which produces a relation
;;; of pairs (X D) where D is element of SET.
;;;   Examples:
;;;     (Rin X D1) is: ((a a) (a b))
;;;     (Rin X D2) is: ((a c) (a d))
;;;     (Rin X F2) is: ()
(define Rin
  (lambda (x set)
    (cond
     ((null? set) '())
     (#t (cons
	  (makepair x (car set))
	  (Rin x (cdr set)))))))

(let ((D1 '(a b))
      (X 'a))
  (Rin X D1))

(let ((D2 '(c d))
      (X 'a))
  (Rin X D2))

(let ((F2 '())
      (X 'a))
  (Rin X F2))

(let ((F4 '((1 $) (3 *)))
      (X 'a))
  (Rin X F4))

;;; 8.8 Relations can be composed with the following function
(define Rcomp
  (lambda (rel1 rel2)
    (cond
     ((null? rel1) '())
     (#t (union
	  (Rin
	   (first (car rel1))
	   (Rapply rel2 (second (car rel1))))
	  (Rcomp (cdr rel1) rel2))))))

;;; See Exercises 8.6 and 8.7
;;; Find the values of (RCOMP R1 R3), (RCOMP R1 F1), and (RCOMP R1 R1)

(let ((R1 '((a b) (a a) (b b)))
      (R3 '((a c) (b c))))
  (Rcomp R1 R3))
;;; ((a c) (b c))

(let ((F1 '((a 1) (b 2) (c 2) (d 1)))
      (R1 '((a b) (a a) (b b))))
  (Rcomp R1 F1))
;;; ((a 2) (a 1) (b 2))

(let ((R1 '((a b) (a a) (b b))))
  (Rcomp R1 R1))
;;; ((a b) (a a) (b b))

;;; 8.9 Write the function TRANSITIVE? which tests whether a relation
;;;   is transitive. A relation REL is transitive if the composition of
;;;   REL with REL is a subset of REL (see Exercise 8.3).
;;;   Examples:
;;;     (transitive? R1) is: true
;;;     (transitive? R3) is: true
;;;     (transitive? F1) is: true
(define transitive?
  (lambda (rel)
    (subset? (Rcomp rel rel) rel)))

(let ((R1 '((a b) (a a) (b b))))
  (transitive? R1))
(let ((R3 '((a c) (b c))))
  (transitive? R3))
(let ((F1 '((a 1) (b 2) (c 2) (d 1))))
  (transitive? F1))

;;; Find a relation for which TRANSITIVEP yields false.
(let ((R5 '((a b) (c d) (d a))))
  (transitive? R5))

;;; 8.10 Write the functions QUASI-ORDER?, PARTIAL-ORDER?, and
;;;   EQUIVALENCE? which test whether a relation is quasi-order, a
;;;   partial-order, or an equivalence relation, respectively.
;;;   A relation is:
;;;   --quasi-order if it is reflexive and transitive,
;;;   --partial-order if it is quasi-order and antisymmetric,
;;;   --equivalence relation if it is quasi-order and symmetric,
;;; See Exercises 8.2, 8.3 and 8.9
(define quasi-order?
  (lambda (rel)
    (and (reflexive? rel) (transitive? rel))))

(define partial-order?
  (lambda (rel)
    (and (quasi-order? rel) (antisymmetric? rel))))

(define equivalence?
  (lambda (rel)
    (and (quasi-order? rel) (symmetric? rel))))

;;; *******************************************
;;; *           Lambda the Ultimate           *
;;; *******************************************

;;; What is (REMBER-F TEST? A L), where
;;;   TEST? is: =
;;;   A is: 5
;;;   and L is: (6 2 5 3)

(let ((TEST? =) (A 5) (L '(6 2 5 3)))
  (rember-f TEST? A L))

;;; What is (REMBER-F TEST? A L), where
;;;   TEST? is: eq
;;;   A is: jelly
;;;   L is: (jelly beans are good)
(let ((TEST? eq?) (A 'jelly) (L '(jelly beans are good)))
  (rember-f TEST? A L))

;;; What is (REMBER-F TESTP A L), where
;;;   TESTP is: equalp
;;;   A is: (pop corn)
;;;   L is: (lemonade (pop corn) and (cake))
(let ((TEST? equal?)
      (A '(pop corn))
      (L '(lemonade (pop corn) and (cake))))
  (rember-f TEST? A L))

;;; Write REMBER-F
(define rember-f
  (lambda (test? a l)
    (cond
     ((null? l) '())
     (#t (cond
	  ((test? (car l) a) (cdr l))
	  (#t (cons (car l)
		    (rember-f
		     test? a (cdr l)))))))))

;;; Try a shorter version
(define rember-f
  (lambda (test? a l)
    (cond
     ((null? l) '())
     ((test? (car l) a) (cdr l))
     (#t (cons (car l)
	       (rember-f test? a (cdr l)))))))

(define eq?-c
  (lambda (a)
    (lambda (x)
      (eq? x a))))

(define eq?-salad
  (let ((K 'salad))
    (eq?-c K)))

(let ((Y 'tuna))
   (eq?-salad Y))
(let ((Y 'salad))
  (eq?-salad Y))

;;; Write a function REMBER-F that, when passed a function as an
;;; argument, returns a function that acts like REMBER-F where TESTP
;;; is just that argument

(define rember-f
  (lambda (test?)
    (lambda (a l)
      (cond
       ((null? l) '())
       ((test? (car l) a) (cdr l))
       (#t (cons (car l) ((rember-f test?) a (cdr l))))))))

(define rember-eq? (rember-f eq?))

(let ((A 'tuna)
      (L '(tuna salad is good)))
  (rember-eq? A L))

((rember-f eq?)
 'tuna
 '(tuna salad is good))

;;; Now transform INSERTL to INSERTL-F the same way we have
;;; transformed REMBER into REMBER-F
(define insertL-f
  (lambda (test?)
    (lambda (new old lat)
      (cond
       ((null? lat) '())
       ((test? (car lat) old) (cons new lat))
       (#t (cons (car lat) ((insertL-f test?) new old (cdr lat))))))))

(let ((NEW 'jalapeño)
      (OLD 'and)
      (LAT '(tacos tamales and salsa))
      (INSERTL-EQ (insertL-f eq?)))
  (INSERTL-EQ NEW OLD LAT))

;;; Also do same tranformation to INSERTR
(define insertR-f
  (lambda (test?)
    (lambda (new old lat)
      (cond
       ((null? lat) '())
       ((test? (car lat) old) (cons old (cons new (cdr lat))))
       (#t (cons (car lat) ((insertR-f test?) new old (cdr lat))))))))

(let ((NEW 'topping)
      (OLD 'fudge)
      (LAT '(ice cream with fudge for dessert))
      (INSERTR-EQ (insertR-f eq?)))
  (INSERTR-EQ NEW OLD LAT))

;;; Write function INSERT-G which would insert either at the left or
;;; at the right

;;; Define a function SEQL which
;;; (1) takes three arguments, and
;;; (2) CONSes the first argument onto the result of CONSing the
;;; second argument onto the third argument
(define seqL
  (lambda (new old l)
    (cons new (cons old l))))

;;; Define a function SEQR which
;;; (1) takes three arguments, and
;;; (2) CONSes the second argument onto the result of CONSing the
;;; first argument onto the third argument
(define seqR
  (lambda (new old l)
    (cons old (cons new l))))

;;; These functions express what the two differing lines in INSERTL
;;; and INSERTR express

;;; Now try to write the function INSERT-G of one argument SEQ
;;; which is INSERTL, when SEQ is SEQL, and which is INSERTR
;;; which is INSERTR, when SEQ is SEQR
(define insert-g
  (lambda (seq)
    (lambda (new old l)
      (cond
       ((null? l) '())
       ((eq? (car l) old)
	(seq new old (cdr l)))
       (#t (cons (car l)
		 ((insert-g seq)
		  new old (cdr l))))))))

;;; Now define INSERTL with insert-g
(define insertL (insert-g seqL))

(let ((NEW 'jalapeño)
      (OLD 'and)
      (LAT '(tacos tamales and salsa))
      (INSERTL (insert-g seqL)))
  (INSERTL NEW OLD LAT))

;;; And INSERTR
(define insertR (insert-g seqR))

(let ((NEW 'topping)
      (OLD 'fudge)
      (LAT '(ice cream with fudge for dessert))
      (INSERTR (insert-g seqR)))
  (INSERTR NEW OLD LAT))

;;; Define a function like SEQL or SEQR for SUBST
(define seqS
  (lambda (new old l)
    (cons new l)))

;;; Now define SUBST using INSERT-G
(define subst (insert-g seqS))

(let ((NEW 'jalapeño)
      (OLD 'and)
      (LAT '(tacos tamales and salsa))
      (SUBST (insert-g seqS)))
  (SUBST NEW OLD LAT))

;;; Try to make REMBER
(define seqREM
  (lambda (new old l) l))
(define rember
  (lambda (a l)
  ((insert-g seqREM) '() a l)))

(let ((A 'bacon)
      (LAT '(bacon lettuce and tomato)))
  (rember A LAT))

(let ((A 'sausage)
      (LAT '(pizza with sausage and bacon)))
  (rember A LAT))

;;; This is the power of abstraction

;;; *********************************************
;;; * The Tenth Commandment                     *
;;; *                                           *
;;; * Abstract functions with common structures *
;;; * into a single function.                   *
;;; *********************************************

;;; Write a function ATOM-TO-FUNCTION that
;;; (1) Takes one argument, x, and
;;; (2) Returns the function +
;;;       if (EQ x '+)
;;;     Returns the function *
;;;       if (EQ x '*)
;;;     Returns the function ^
;;;       if (EQ x '^)
(define atom-to-function
  (lambda (x)
    (cond
     ((eq? x '+) my-+)
     ((eq? x '*) my-*)
     ((eq? x '^) my-^))))

;;; Use ATOM-TO-FUNCTION to rewrite VALUE with only two lines inside
;;; the COND
(define value
  (lambda (aexp)
    (cond
     ((number? aexp) aexp)
     (#t ((atom-to-function (operator aexp))
	  (value (1st-sub-exp aexp))
	  (value (2nd-sub-exp aexp)))))))

(value '(+ 2 2))
(value '(* 7 8))
(value '(^ 2 7))

;;; Write the functions SUBSET? and INTERSECT? next to each other
(define subset?
  (lambda (set1 set2)
    (cond
     ((null? set1) #t)
     (#t (and
	  (member? (car set1) set2)
	  (subset? (cdr set1) set2))))))

(define intersect?
  (lambda (set1 set2)
    (cond
     ((null? set1) #f)
     (#t (or
	  (member? (car set1) set2)
	  (intersect?
	   (cdr set1) set2))))))

;;; Let's abstract them into a function
;;;   (SET-F? LOGICAL? CONST)
;;; which can generate SUBSET? and INTERSECT?
(define set-f?
  (lambda (logical? const)
    (lambda (set1 set2)
      (cond
       ((null? set1) const)
       (#t (logical?
	    (member (car set1) set2)
	    ((set-fp logical? const) (cdr set1) set2)))))))

(define subset? (set-f? and #t))
(define intersect? (set-f? or #f))

;;; But AND and OR are not really functions. They cannot be passed as arguments.
;;; So write functions that act like (AND ...)and (OR ...)

(define and-prime (lambda (x y) (and x y)))
(define or-prime (lambda (x y) (or x y)))

(let
    ((x '(red wine tastes good))
     (y '(it goes well with brie cheese)))
  (and #f (subset? x y)))

(let
    ((x '(red wine tastes good))
     (y '(it goes well with brie cheese)))
  (or-prime #t (intersect? x y)))

(define or-prime
  (lambda (x set1 set2)
    (or x (intersect? (cdr set1) set2))))
(define and-prime
  (lambda (x set1 set2)
    (and x (subset? (cdr set1) set2))))

(define set-f?
  (lambda (logical? const)
    (lambda (set1 set2)
      (cond
       ((null? set1) const)
       (#t (logical?
	    (member? (car set1) set2)
	    set1
	    set2))))))

(define intersect? (set-f? or-prime #f))
(define subset? (set-f? and-prime #t))

(let ((SET1 '(tomatoes and macaroni))
      (SET2 '(macaroni and cheese)))
  (intersect? SET1 SET2))

(let ((SET1 '(5 chicken wings))
      (SET2 '(5 hamburgers 2 pieces fried chicken
		and light duckling wings)))
  (subset? SET1 SET2))

(let ((SET1 '(4 pounds of horseradish))
      (SET2 '(four pounds chicken and 5 ounces horseradish)))
  (subset? SET1 SET2))

;;; Simplify MULTIREMBER by removing the inner (COND ...)
(define multirember
  (lambda (a l)
    (cond
     ((null? l) '())
     ((eq? (car l) a)
      (multirember a (cdr l)))
     (#t (cons (car l)
	       (multirember a (cdr l)))))))

;;; What is (MULTIREMBER 'CURRY L), where
;;;   L is: (a b c curry e curry g curry)
(let ((L '(a b c curry e curry g curry)))
  (multirember 'curry L))

;;; If we wrap this function by
;;;   (LAMBDA (L) ...)
;;; what do we create?
(let ((L '(a b c curry e curry g curry)))
  ((lambda (l) (multirember 'curry l)) L))

;;; Define the new function and give it a name
(define Mrember-curry
  (lambda (l)
    (multirember 'curry l)))

(Mrember-curry '(a b c curry e curry g curry))

;;; Rewrite MREMBER-CURRY using three questions
(define Mrember-curry
  (lambda (l)
    (cond
     ((null? l) '())
     ((eq? (car l) 'curry)
      (Mrember-curry (cdr l)))
     (#t (cons (car l)
	       (Mrember-curry (cdr l)))))))

;;; Compare CURRY-MAKER to INSERT-G
(define curry-maker
  (lambda (future)
    (lambda (l)
      (cond
       ((null? l) '())
       ((eq? (car l) 'curry)
	((curry-maker future) (cdr l)))
       (#t (cons (car l)
		 ((curry-maker future)
		  (cdr l))))))))

;;; Make CURRY-MAKER make MREMBER-CURRY
(define Mrember-curry (curry-maker 0))

;;; Write FUNCTION-MAKER
(define function-maker
  (lambda (future)
    (lambda (l)
      (cond
       ((null? l) '())
       ((eq? (car l) 'curry)
	((future future)
	 (cdr l)))
       (#t (cons (car l)
		 ((future future)
		  (cdr l))))))))

;;; Write MREMBER-CURRY using just FUNCTION-MAKER
(define Mrember-curry (function-maker function-maker))

(Mrember-curry '(a b c curry e curry g curry))

;;; Is the definition below the same as the FUNCTION-MAKER
;;; we defined earlier?
(define function-maker
  (lambda (future)
    (lambda (l)
      (cond
       ((null? l) '())
       ((eq? (car l) 'curry)
	((lambda (arg)
	   ((future future) arg))
	 (cdr l)))
       (#t (cons (car l)
		 ((lambda (arg)
		    ((future future) arg))
		  (cdr l))))))))

(add1 9)

((lambda (x) (add1 x)) 9)

((lambda (y) ((lambda (x) (add1 x)) y)) 9)

;;; Is the definition below the same as the FUNCTION-MAKER
;;; we just defined?
(define function-maker
  (lambda (future)
    ((lambda (recfun)
       (lambda (l)
	 (cond
	  ((null? l) '())
	  ((eq? (car l) 'curry)
	   (recfun (cdr l)))
	  (#t (cons (car l)
		    (recfun (cdr l)))))))
     (lambda (arg)
       ((future future) arg)))))

;;; Can you make the definition of FUNCTION-MAKER simpler by
;;; breaking it up into two functions?
;;; Hint: look at the innermost function
(define M
  (lambda (recfun)
       (lambda (l)
	 (cond
	  ((null? l) '())
	  ((eq? (car l) 'curry)
	   (recfun (cdr l)))
	  (#t (cons (car l)
		    (recfun (cdr l))))))))

(define function-maker
  (lambda (future)
    (M (lambda (arg)
	 ((future future) arg)))))

;;; Write Mrember-curry without using FUNCTION-MAKER
(define Mrember-curry
  ((lambda (future)
    (M (lambda (arg)
	 ((future future) arg))))
   (lambda (future)
     (M (lambda (arg)
	 ((future future) arg))))))

;;; Abstract the definition of Mrember-curry by abstracting away
;;; the association with M.
;;; Hint. wrap a (lambda (M) ...) around the definition

(define Y
  (lambda (M)
    ((lambda (future)
       (M (lambda (arg)
	    ((future future) arg))))
     (lambda (future)
       (M (lambda (arg)
	    ((future future) arg)))))))

;;; Write Mrember-curry using Y and M

(define Mrember-curry (Y M))

;;; You have just worked through the derivation of a function
;;; called "the applicative-order Y-combinator." The interesting
;;; aspect of Y is that it produces recursive definitions without
;;; the bother of requiring that the functions be named with
;;; (define ...)

;;; Define L so that LENGTH is
;;;   (define length (Y L))
(define L
  (lambda (recfun)
    (lambda (l)
      (cond
       ((null? l) 0)
       (#t (add1 (recfun (cdr l))))))))

;;; Write LENGTH using Y, but not L, by substituting the
;;; definition for L.
(define length
  (Y
   (lambda (recfun)
     (lambda (l)
       (cond
	((null? l) 0)
	(#t (add1
	     (recfun (cdr l)))))))))

;;; Rewrite LENGTH without using either Y or L
(define length
  ((lambda (M)
     ((lambda (future)
	(M (lambda (arg)
	     ((future future) arg))))
      (lambda (future)
	(M (lambda (arg)
	     ((future future) arg))))))
   (lambda (recfun)
     (lambda (l)
       (cond
	((null? l) 0)
	(#t (add1 (recfun (cdr l)))))))))

;;; We observe that length does not need to be named with
;;;   (define ...).
;;; Write an application that corresponds to
;;;   (length (quote (a b c)))
(((lambda (M)
    ((lambda (future)
       (M (lambda (arg)
	    ((future future) arg))))
     (lambda (future)
       (M (lambda (arg)
	    ((future future) arg))))))
  (lambda (recfun)
    (lambda (l)
      (cond
       ((null? l) 0)
       (#t (add1 (recfun (cdr l))))))))
 '(a b c))

;;; === EXERCISES ===

;;; 9.1 Look up the functions FIRSTS and SECONDS in Chapter 3.
;;;   They can be generalized to a function MAP of F and L that
;;;   applies F to every element in L and builds a new list with
;;;   the resulting values.
;;;
;;;   Write the function MAP. Then write the function FIRSTS and
;;;   SECONDS using MAP.

(define my-map
  (lambda (f l)
    (cond
     ((null? l) '())
     (#t (cons (f (car l)) (map f (cdr l)))))))

(define first-f 
  (lambda (l)
    (car l)))

(let ((L '((apple peach pumpkin)
          (plum pear cherry)
          (grape raisin pea)
          (bean carrot eggplant))))
  (my-map first-f L))

(define firsts (lambda (l) (my-map car l)))

(let ((L '((apple peach pumpkin)
          (plum pear cherry)
          (grape raisin pea)
          (bean carrot eggplant))))
  (firsts L))

(define seconds
  ((lambda (f)
     (lambda (l)
       (my-map f l)))
   (lambda (l) (car (cdr l)))))

;;; 9.2 Write the function ASSQ-SF of A, L, SK, and FK. This function
;;;   searches through L which is a list of pairs until it finds a
;;;   pair whose first component is EQ? to A. Then the function invokes
;;;   the function SK with this pair. If the search fails, (FK A)
;;;   is invoked.
;;;
;;;   Example:
;;;     When
;;;       A is apple,
;;;       B1 is (),
;;;       B2 is ((apple 1) (plum 2)),
;;;       B3 is ((peach 3)),
;;;       SK is (lambda (p)
;;;               (build (first p) (add1 (second p)))),
;;;       FK is (lambda (name)
;;;               (cons
;;;                 name
;;;                 '(not-in-list))),
;;;     then
;;;       (assq-sf a b1 sk fk) is (apple not-in-list)
;;;       (assq-sf a b2 sk fk) is (apple 2)
;;;       (assq-sf a b3 sk fk) is (apple not-in-list)

(define assq-sf
  (lambda (a l sk fk)
    (cond
     ((null? l) (fk a))
     ((eq? (car (car l)) a) (sk (car l)))
     (#t (assq-sf a (cdr l) sk fk)))))

(define SK
  ((lambda (build)
     (lambda (p)
       (build (first p) (add1 (second p)))))
   (lambda (a b) (cons a (cons b '())))))

(define FK
   (lambda (name)
     (cons
      name
      '(not-in-list))))

(let ((A 'apple)
      (B1 '()))
  (assq-sf A B1 SK FK))

(let ((A 'apple)
      (B2 '((apple 1) (plum 2))))
  (assq-sf A B2 SK FK))

(let ((A 'apple)
      (B3 '((peach 3))))
  (assq-sf A B3 SK FK))

;;; 9.3 In the chapter we have derived a Y-combinator that allows
;;;   us to write recursive functions of one argument without using
;;;   DEFINE. Here is the Y-combinator for functions of two
;;;   arguments:
(define Y2
  (lambda (M)
    ((lambda (future)
       (M (lambda (arg1 arg2)
	    ((future future) arg1 arg2))))
     (lambda (future)
       (M (lambda (arg1 arg2)
	    ((future future) arg1 arg2)))))))

;;; Write the functions =, REMPICK, and PICK from Chapter 4 using Y2
;;; Note: There is a version of (LAMBDA ...) for defining a function
;;;   of an arbitrary number of arguments, and an APPLY function for
;;;   applying such a function to a list of arguments. With this you
;;;   can write a single Y-combinator for all functions.

(define M1
  (lambda (recfun)
    (lambda (n m)
      (cond
       ((zero? m) (zero? n))
       ((zero? n) #f)
       (#t (recfun (sub1 n) (sub1 m)))))))

(define my-= (Y2 M1))

(define M2
  (lambda (recfun)
    (lambda (n lat)
      (cond
       ((zero? (sub1 n)) (cdr lat))
       ((null? lat) '())
       (#t (cons (car lat) (recfun (sub1 n) (cdr lat))))))))

(define rempick (Y2 M2))

(define M3
  (lambda (recfun)
    (lambda (n lat)
      (cond
       ((zero? (sub1 n)) (car lat))
       ((null? lat) '())
       (#t (recfun (sub1 n) (cdr lat)))))))

(define pick (Y2 M3))

(define YN
  (lambda (M)
    ((lambda (future)
       (M (lambda args
	    ((future future) args))))
     (lambda (future)
       (M (lambda args
	    ((future future) args)))))))


;;; 9.4 With the Y-combinator we can reduce the number of arguments
;;;   on which a function has to recur. For example MEMBER can be
;;;   rewritten as
(define member-Y
  (lambda (a l)
    ((Y (lambda (recfun)
	  (lambda (l)
	    (cond
	     ((null? l) #f)
	     (#t (or
		  (eq? (car l) a)
		  (recfun (cdr l))))))))
     l)))

;;;   Step through the application (MEMBER-Y A L) where A is X and
;;;   L is (Y X). Rewrite the functions REMBER, INSERTR, and SUBST2
;;;   from Chapter 3 in a similar manner.

;;; 9.5 In Exercises 6.7 through 6.10 we saw how to use the
;;;   accumulator technique. Instead of accumulators, continuation
;;;   functions are sometimes used. These functions abstract what
;;;   needs to be done to complete an application. For example,
;;;   MULTISUBST can be defined as
(define multisubst-k
  (lambda (new old lat k)
    (cond
     ((null? lat) (k '()))
     ((eq? (car lat) old)
      (multisubst-k new old (cdr lat)
		    (lambda (d)
		      (k (cons new d)))))
     (#t (multisubst-k new old (cdr lat)
		       (lambda (d)
			 (k (cons (car lat) d))))))))

;;;   The initial continuation function K is always the function
(lambda (x) x)

;;;   Step through the application of
;;;     (MULTISUBST-K NEW OLD LAT K),
;;;   where
;;;     NEW is y
;;;     OLD is x
;;;     and LAT is (u v x x y z x)

;;;   Compare the steps to the application of MULTISUBST to the same
;;;   arguments. Write down the things you have to do when you return
;;;   from a recursive application, and, next to it, write down the
;;;   corresponding continuation function.

;;; 9.6 In Chapter 4 and Exercise 4.2 you wrote ADDVEC and MULTIVEC.
;;;   Abstract the two functions into a single function ACCUM.
;;;   Write the functions LENGTH and OCCUR using ACCUM.

;;; 9.7 In Exercise 7.3 you wrote the four functions COUNT-OP,
;;;   COUNT-+, COUNT-*, and COUNT-^. Abstract them into a single
;;;   function count-op-f which generates the corresponding
;;;   functions if passed an appropriate help function.

;;; 9.8 Functions of no arguments are called thunks. If F is a thunk,
;;;   it can be evaluated with (F). Consider the following version
;;;   of OR as a function
(define or-func
  (lambda (or1 or2)
    (or (or1) (or2))))

;;;   Assuming that OR1 and OR2 are always thunks, convince yourself
;;;   that (OR ...) and OR-FUNC are equivalent. Consider as an
;;;   example
(or (null? l) (atom? (car l)))

;;; and the corresponding application
(or-func
 (lambda () (null? l))
 (lambda () (atom? (car l))))

;;;   where
;;;     L is ()
;;;   Write SET-F? to take OR-FUNC and AND-FUNC.

;;; Write the functions INTERSECT? and SUBSET? with the SET-F?
;;; function.

;;; 9.9 When you build a pair with an S-expression and a thunk
;;;   (see Exercise 9.8) you get a stream. There are two functions
;;;   defined on streams: FIRST$ and SECOND$
;;;
;;;   Note: In practice, you can actually CONS an S-expression 
;;;   directly onto a function. We prefer to stay with the less
;;;   general CONS function.
(define first$ first)

(define second$
  (lambda (str)
    ((second str))))

;;;   An example of a stream is
(build 1 (lambda () 2))

;;;   Let's call this stream S.
(first$ S)
;;;     is then 1, and
(second$ S)
;;;     is 2

;;;   Streams are interesting because they can be used to represent
;;;   unbounded collections such as the integers. Consider the
;;;   following definitions.
;;;
;;;   STR-MAKER is a function that takes a number N and a function
;;;   NEXT and produces a stream.
(define str-maker
  (lambda (next n)
    (build n (lambda () (str-maker next (next n))))))

;;;   With STR-MAKER we can now define the stream of all integers
;;;   like this:
(define int (str-maker add1 0))

;;;   Or we can define the stream of all even numbers.
(define even (str-maker (lambda (n) (+ 2 n)) 0))

;;;   With the function FRONTIER we can obtain a finite piece of a
;;;   stream in a list
(define frontier
  (lambda (str n)
    (cond
     ((zero? n) '())
     (#t (cons (first$ str) (frontier (second$ str) (sub1 n)))))))

;;;   What is (frontier int 10)?
;;;   (frontier int 100)?
;;;   (frontier even 23)?
;;;   Define the stream of odd numbers.
(define odd (str-maker (lambda (n) (+ 2 n)) 1))

;;; 9.10 This exercise builds on the results of Exercise 9.9
;;;   Consider the following fun
(define Q
  (lambda (str n)
    (cond
     ((zero? (remainder (first$ str) n))
      (Q (second$ str) n))
     (#t (build (first$ str)
		(lambda ()
		  (Q (second$ str) n)))))))

(define P
  (lambda (str)
    (build (first$ str)
	   (lambda () (P (Q str (first$ str)))))))

;;;   They can be used to construct streams. What is the result of
(frontier (P (second$ (second$ int))) 10)

;;;   What is this stream of numbers?
;;;   (See Exercise 4.9 for the definition of REMAINDER.)
