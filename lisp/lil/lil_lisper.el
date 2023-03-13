;;; Is it true that this is an atom?
;;;   atom
(atom 'atom)

;;; Is it true that this is an atom?
;;;   turkey
(atom 'turkey)

;;; Is it true that this is an atom?
;;;   1492
(atom '1492)

;;; Is it true that this is an atom?
;;;   3turkeys
(atom '3turkeys)

;;; Is it true that this is an atom?
;;;   u
(atom 'u)

;;; Is it true that this is an atom?
;;;   *abc$
(atom '*abc$)

;;; Is it true that this is a list?
;;;   (atom)
(atom '(atom))
(listp '(atom))

;;; Is it true that this is a list?
;;;   (atom turkey or)
(atom '(atom turkey or))
(listp '(atom turkey or))

;;; Is it true that this is a list?
;;;   (atom turkey) or
(atom '(atom turkey) or)
(listp atom '(atom turkey) or)

;;; Is it true that this is a list?
;;;   ((atom turkey) or)
(atom '((atom turkey) or))
(listp '((atom turkey) or))

;;; Is it true that this is an S-expression?
;;;   xyz
(or (atom 'xyz) (consp 'xyz))

;;; Is it true that this is an S-expression?
;;;   (x y z)
(or (atom '(x y z)) (consp '(x y z)))

;;; Is it true that this is an S-expression?
;;;   ((x y) z)
(or (atom '((x y) z)) (consp '((x y) z)))

;;; Is it true that this is a list?
;;;   (how are you doing so far)
(listp '(how are you doing so far))

;;; How many S-expressions are in the list
;;;   (how are you doing so far)
;;; and what are they?
(length
 (seq-filter (lambda (elt) (and elt t))
	     (mapcar (lambda (x) (or (atom x) (consp x)))
		     '(how are you doing so far))))

(seq-map-indexed (lambda (elt idx)
		   (if (or (atom elt) (consp elt))
		       (list idx elt)))
		 '(how are you doing so far))

;;; Is it true that this is a list?
;;;   (((how) are) ((you) (doing so)) far)
(listp '(((how) are) ((you) (doing so)) far))

;;; How many s-expressions are in the list
;;;   (((how) are) ((you) (doing so)) far)
;;; and what are they?
(length
 (seq-filter (lambda (elt) (and elt t))
	     (mapcar (lambda (x) (or (atom x) (consp x)))
		     '(((how) are) ((you) (doing so)) far))))

(seq-map-indexed (lambda (elt idx)
		   (if (or (atom elt) (consp elt))
		       (list idx elt)))
		 '(((how) are) ((you) (doing so)) far))

;;; Is it true that this is a list?
;;;   ()
(listp '())

;;; Is it true that this is an atom?
;;;   ()
(atom '())

;;; Is it true that this is a list?
;;;   (() () () ())
(listp '(() () () ()))

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
  (null L))

;;; Is (null L) true or false, where
;;;   L is: (a b c)
(let ((L '(a b c)))
  (null L))

;;; Is (null A) true or false, where
;;;   A is: spaghetti
(let ((A 'spaghetti))
  (null A))

;;; *******************************************
;;; * The Law of Null                         *
;;; *                                         *
;;; * Null is defined only for lists.         *
;;; *******************************************

;;; Is it true or false, that S is an atom, where
;;;   S is: Harry
(let ((S 'Harry))
  (atom S))

;;; Is (atom S) true or false, where
;;;   S is: Harry
(let ((S 'Harry))
  (atom S))

;;; Is (atom S) true or false, where
;;;   S is: (Harry had a heap of apples)
(let ((S '(Harry had a heap of apples)))
  (atom S))

;;; How many arguments does ATOM take,
;;; and what are they?
;;;
;;; It takes one argument
;;; The argument can be any S-expression

;;; Is (atom (car l)) true or false, where
;;;   L is: (Harry had a heap of apples)
(let ((L '(Harry had a heap of apples)))
  (atom (car L)))

;;; Is (atom (cdr l)) true or false, where
;;;   L is: (Harry had a heap of apples)
(let ((L '(Harry had a heap of apples)))
  (atom (cdr L)))

;;; Is (atom (cdr l)) true or false, where
;;;   L is: (Harry)
(let ((L '(Harry)))
  (atom (car L)))

;;; Is (atom (car (cdr l))) true or false, where
;;;   L is: (swing low sweet cherry)
(let ((L '(swing low sweet cherry)))
  (atom (car (cdr L))))

;;; Is (atom (car (cdr l))) true or false, where
;;;   L is: (swing (low sweet) cherry)
(let ((L '(swing (low sweet) cherry)))
  (atom (car (cdr L))))

;;; True or false: A1 and A2 are the same atom, where
;;;   A1 is: Harry
;;;   and A2 is: Harry
(let ((A1 'Harry)
      (A2 'Harry))
  (eq A1 A2))

;;; Is (eq A1 A2) true or false, where
;;;   A1 is: margarine
;;;   and A2 is: butter
(let ((A1 'margarine)
      (A2 'butter))
  (eq A1 A2))

;;; How many arguments does EQ take
;;; and what are they?
;;;
;;; It takes two arguments
;;; Both of them must be atoms
;;;
;;; (eq OBJ1 OBJ2)
;;; Return t if the two args are the same Lisp object.

;;; Is (eq L1 L2) true or false, where
;;;   L1 is: ()
;;;   and L2 is: (strawberry)
(let ((L1 '())
      (L2 '(strawberry)))
  (eq L1 L2))

;;; *******************************************
;;; * The Law of Eq                           *
;;; *                                         *
;;; * Eq takes two arguments. Each must be    *
;;; * an atom.                                *
;;; *******************************************

;;; Is (eq (car L) A) true or false, where
;;;   L is: (Mary had a little lamb chop)
;;;   and A is: Mary
(let ((L '(Mary had a little lamb chop))
      (A 'Mary))
  (eq (car L) A))

;;; Is (eq (cdr L) A) true or false, where
;;;   L is: (soured milk)
;;;   and A is: milk
(let ((L '(soured milk))
      (A 'milk))
  (eq (cdr L) A))

;;; Is (eq (car L) (car (cdr L))) true or false, where
;;;   L is: (beans beans we need jelly beans)
(let ((L '(beans beans we need jelly beans)))
  (eq (car L) (car (cdr L))))

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

;;; 1.5 Find an atom X that makes (eq X Y) true, where
;;;   Y is: lisp
(let ((X (car '(lisp is fun)))
      (Y 'lisp))
  (eq X Y))

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
(let ((S ())
      (L ()))
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
;;;   (atom (car L)), where
;;;   L is: ((meatballs) and spaghetti)
(let ((L '((meatballs) and spaghetti)))
  (atom (car L)))

;;;   (null (cdr L)), where
;;;    L is: ((meatballs))
(let ((L '((meatballs))))
  (null (cdr L)))

;;;   (eq (car L) (car (cdr L))), where
;;;   L is: (two meatballs)
(let ((L '(two meatballs)))
  (eq (car L) (car (cdr L))))

;;;   (atom (cons A L)), where
;;;   L is: (ball)
;;;   A is: meat
(let ((L '(ball))
      (A 'meat))
  (atom (cons A L)))

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

;;; True of false: (lat L)
;;; where L is: (Jack Sprat could eat no chicken fat)
;;;
;;; True,
;;; because each S-expression in L is an atom

;;; True of false: (lat L)
;;; where L is: ((Jack) Sprat could eat no chicken fat)
;;;
;;; False,
;;; since (car L) is a list

;;; True of false: (lat L)
;;; where L is: (Jack (Sprat could) eat no chicken fat)
;;;
;;; False,
;;; since one of the S-expressions in L is a list

;;; True of false: (lat L)
;;; where L is: ()
;;;
;;; True,
;;; because () contains no lists and because it does not
;;; contain any lists, it is a LAT

;;; True of false:
;;;   a lat is a list of atoms

;;; Write the function LAT using some, but not necessarily all,
;;; of the following functions:
;;;   car cdr cons null atom eq

(defun lat (l)
  (cond
   ((null l) t)
   ((atom (car l)) (lat (cdr l)))
   (t nil)))

;;; The application (lat L), where
;;;   L is: (lat '(bacon and eggs))
;;;
;;; has the value t--true--because L is a LAT
(lat '(bacon and eggs))

;;; How do you determine the answer t for the application?:
;;;   (lat L)

;;; What is the first question asked by (lat L)
;;;
;;; (null L)

;;; What is the meaning of the COND-LINE
;;;   ((null L) t)
;;;
;;; where L is: (bacon and eggs)

;;; What is the next question?
;;;
;;; (atom (car L))

;;; What is the meaning of the line
;;;   ((atom (car L)) (lat (cdr L)))
;;;
;;; where L is: (bacon and eggs)

;;; What is the meaning of
;;;   (lat (cdr L))

(defun member (a lat)
  (cond
   ((null lat) nil)
   (t (or
       (eq (car lat) a)
       (member a (cdr lat))))))

;;; What is the value of
;;;  (member A LAT)
;;; where A is: meat
;;; and LAT is: (mashed potatoes and meat gravy)
(let ((A 'meat)
      (LAT '(mashed potatoes and meat gravy)))
  (member A LAT))

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
;;;   (lat L1)
(let ((L1 '(german chocolate cake)))
  (lat L1))

;;;   (lat L2)
(let ((L2 '(poppy seed cake)))
  (lat L2))

;;;   (lat L3)
(let ((L3 '((linzer) (torte) ())))
  (lat L3))

;;; 2.2 For each case in Exercise 2.1 step through the application
;;;     as we did in this chapter

;;; 2.3 What is the value of
;;;   (member A1 L1)
(let ((A1 'coffee)
      (L1 '(german chocolate cake)))
  (member A1 L1))

;;;   (member A2 L2)
(let ((A2 'seed)
      (L2 '(poppy seed cake)))
  (member A2 L2))

;;; 2.4 Rewrite all the functions in the chapter using IF instead of COND

(defun lat (l)
  (if (null l)
      t
    (and (atom (car l))
	(lat (cdr l)))))

(defun member (a lat)
  (if (null lat)
      nil
     (or
       (eq (car lat) a)
       (member a (cdr lat)))))

;;; 2.5 Write the function NONLAT which determines whether a list is the
;;;     empty list or does not contain S-expressions

(defun nonlat (l)
  (if (null l)
      t
    (and (listp (car l))
	 (nonlat (cdr l)))))

;;;   (nonlat L1)
(let ((L1 '(german chocolate cake)))
  (nonlat L1))

;;;   (nonlat L2)
(let ((L2 '(poppy seed cake)))
  (nonlat L2))

;;;   (nonlat L3)
(let ((L3 '((linzer) (torte) ())))
  (nonlat L3))

;;;   (nonlat L4)
(let ((L4 '((bleu cheese) (and) (red) (wine))))
  (nonlat L4))

;;;   (nonlat L5)
(let ((L5 '(() ())))
  (nonlat L5))

;;; 2.6 Write a function MEMBER-CAKE which determines whether a LAT
;;;     contains the atom CAKE

(defun member-cake (l)
  (if (null l)
      nil
    (let ((m (car l)))
      (or (and (atom m) (eq m 'cake))
	  (member-cake (cdr l))))))

;;;   (member-cake L1)
(let ((L1 '(german chocolate cake)))
  (member-cake L1))

;;;   (member-cake L2)
(let ((L2 '(poppy seed cake)))
  (member-cake L2))

;;;   (member-cake L3)
(let ((L3 '((linzer) (torte) ())))
  (member-cake L3))

;;;   (member-cake L4)
(let ((L4 '((bleu cheese) (and) (red) (wine))))
  (member-cake L4))

;;;   (member-cake L5)
(let ((L5 '(() ())))
  (member-cake L5))

;;; 2.7 Consider the following definition of MEMBER
(defun member2 (a lat)
  (cond
   ((null lat) nil)
    (t (or
	(member2 a (cdr lat))
	(eq a (car lat))))))

;;; Do (member2 A L) and (member A L) give the same answer when we
;;;     use the same arguments?
;;; Consider the examples A1 and L1, A1 and L2, and A2 and L2

;;;   (member A1 L1)
(let ((A1 'coffee)
      (L1 '(german chocolate cake)))
  (member A1 L1))

;;;   (member2 A1 L1)
(let ((A1 'coffee)
      (L1 '(german chocolate cake)))
  (member2 A1 L1))

;;;   (member A1 L2)
(let ((A1 'coffee)
      (L2 '(poppy seed cake)))
  (member A1 L2))

;;;   (member2 A1 L2)
(let ((A1 'coffee)
      (L2 '(poppy seed cake)))
  (member2 A1 L2))

;;;   (member A2 L2)
(let ((A2 'seed)
      (L2 '(poppy seed cake)))
  (member A2 L2))

;;;   (member2 A2 L2)
(let ((A2 'seed)
      (L2 '(poppy seed cake)))
  (member2 A2 L2))

;;; 2.9 What happens when you step through (member A2 L3)?
;;;     Fix this problem by having MEMBER ignore lists

(defun member (a lat)
  (cond
   ((null lat) nil)
   (t (let ((e (car lat)))
	(or
	 (and (atom e) (eq e a))
	 (member a (cdr lat)))))))

;;;   (member A2 L3)
(let ((A2 'seed)
      (L3 '((linzer) (torte) ())))
  (member A2 L3))


;;; 2.10 The function MEMBER tells whether some atom appears at least
;;;      once in a LAT. Write a function MEMBER-TWICE which tells
;;;      whether some atom appears at least twice in a LAT. 

(defun member-twice (a lat)
  (let ((found (car lat))
	(lat (cdr lat)))
    (cond
     ((null lat) (and (listp found) (> (length found) 2)))
     ((atom found) (member-twice a (cons '(found) (cons found lat))))
     (t (let ((found
	       (if (eq (car lat) a)
		   (reverse (cons a (reverse found)))
		 found)))
	       (member-twice a (cons found (cdr lat))))))))


(let ((A3 'chocolate)
      (L1 '(german chocolate chocolate cake)))
  (member-twice A3 L1))

(let ((A3 'chocolate)
      (L1 '(german chocolate cake)))
  (member-twice A3 L1))

(let ((A3 'chocolate))
  (member-twice A3 nil))

(let ((A 'boom)
      (L '(the boom boom room)))
  (member-twice A L))

(let ((A 'room)
      (L '(the boom boom room)))
  (member-twice A L))

(let ((A 'room)
      (L '(the boom boom room room)))
  (member-twice A L))


;;; *******************************************
;;; *          Cons The Magnificent           *
;;; *******************************************

;;; first try
(defun rember (a lat)
  (cond
   ((null lat) '())
   (t (cond
       ((eq (car lat) a) (cdr lat))
       (t (rember a (cdr lat)))))))

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
(defun rember (a lat)
  (cond
   ((null lat) '())
   (t (cond
       ((eq (car lat) a) (cdr lat))
       (t (cons (car lat)
		(rember a (cdr lat))))))))

;;; What is the value of (rember A LAT) where
;;;   A is: 'and
;;;   LAT is: (bacon lettuce and tomato)
(let ((A 'and)
      (LAT '(bacon lettuce and tomato)))
  (rember A LAT))

;;; third try, simplify
(defun rember (a lat)
  (cond
   ((null lat) '())
   ((eq (car lat) a) (cdr lat))
   (t (cons (car lat)
	    (rember a (cdr lat))))))

;;; What is the value of (rember A LAT) where
;;;   A is: 'sauce
;;;   LAT is: (soy sauce and tomato sauce)
(let ((A 'sauce)
      (LAT '(soy sauce and tomato sauce)))
  (rember A LAT))

(defun firsts (l)
  (cond
   ((null l) '())
   (t (cons (car (car l))
	    (firsts (cdr l))))))

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
  
(defun seconds (l)
  (cond
   ((null l) '())
   (t (cons (car (cdr (car l)))
	    (seconds (cdr l))))))

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

(defun insertR (new old lat)
  (cond
   ((null lat) '())
   (t (if (eq (car lat) old)
	  (cons old (cons new (cdr lat)))
	(cons (car lat) (insertR new old (cdr lat)))))))

(defun insertR (new old lat)
  (cond
   ((null lat) '())
   (t (cond
       ((eq (car lat) old) (cons old (cons new (cdr lat))))
       (t (cons (car lat) (insertR new old (cdr lat))))))))

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

(defun insertL (new old lat)
  (cond
   ((null lat) '())
   (t (cond
       ((eq (car lat) old) (cons new (cons old (cdr lat))))
       (t (cons (car lat) (insertL new old (cdr lat))))))))

(defun insertL (new old lat)
  (cond
   ((null lat) '())
   (t (cond
       ((eq (car lat) old) (cons new lat))
       (t (cons (car lat) (insertL new old (cdr lat))))))))

;;; (insertL NEW OLD LAT), where
;;;   NEW is: jalapeño
;;;   OLD is: and
;;;   and LAT is: (tacos tamales and salsa)
(let ((NEW 'jalapeño)
      (OLD 'and)
      (LAT '(tacos tamales and salsa)))
  (insertL NEW OLD LAT))

(defun subst (new old lat)
  (cond
   ((null lat) '())
   (t (cond
       ((eq (car lat) old) (cons new (cdr lat)))
       (t (cons (car lat) (subst new old (cdr lat))))))))

;;; (subst NEW OLD LAT), where
;;;   NEW is: jalapeño
;;;   OLD is: and
;;;   and LAT is: (tacos tamales and salsa)
(let ((NEW 'jalapeño)
      (OLD 'and)
      (LAT '(tacos tamales and salsa)))
  (subst NEW OLD LAT))

(defun subst2 (new o1 o2 lat)
  (cond
   ((null lat) '())
   (t (cond
       ((or (eq (car lat) o1) (eq (car lat) o2)) (cons new (cdr lat)))
       (t (cons (car lat) (subst2 new o1 o2 (cdr lat))))))))

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
(let ((L1 '((paella spanish) (wine red) (and beans))))
  (seconds L1))

(let ((L2 '()))
  (seconds L2))

(let ((L7 '((and hot) (but dogs))))
  (seconds L7))

;;; 3.2 Write the function DUPLA of A and L which makes a new
;;;   lat containing as many A's as there are elements in L
(defun dupla (a l)
  (cond
   ((null l) '())
   (t (cons a (dupla a (cdr l))))))

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
(defun double (a l)
  (cond
   ((null l) '())
   (t (cond
       ((eq (car l) a) (cons a (cons a (cdr l))))
       (t (cons (car l)
		(double a (cdr l))))))))

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
(defun subst-sauce (a l)
  (cond
   ((null l) '())
   (t (cond
       ((eq (car l) 'sauce) (cons a (cdr l)))
       (t (cons (car l) (subst-sauce a (cdr l))))))))

(let ((A1 'chili)
      (L4 '(texas hot chili)))
  (subst-sauce A1 L4))

(let ((A1 'chili)
      (L5 '(soy sauce and tomato sauce)))
  (subst-sauce A1 L5))

(let ((A1 'sauce)
      (L2 '()))
  (subst-sauce A1 L2))

(defun subst3 (new o1 o2 o3 lat)
  (cond
   ((null lat) '())
   (t (cond
       ((member (car lat) '(o1 o2 o3)) (cons new (cdr lat)))
       (t (cons (car lat) (subst3 new o1 o2 o3 (cdr lat))))))))

(defun subst3 (new o1 o2 o3 lat)
  (cond
   ((null lat) '())
   (t (cond
       ((member (car lat) (list o1 o2 o3)) (cons new (cdr lat)))
       (t (cons (car lat) (subst3 new o1 o2 o3 (cdr lat))))))))

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
(defun substN (new slat lat)
  (cond
   ((null lat) '())
   (t (cond
       ((member (car lat) slat) (cons new (cdr lat)))
       (t (cons (car lat) (substN new slat (cdr lat))))))))

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
(defun rember2 (a l)
  (cond
   ((null l) '())
   (t (cond
    ((eq (car l) a) (cons a (rember a (cdr l))))
    (t (cons (car l) (rember2 a (cdr l))))))))

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

;;; Is (atom N) true or false, where
;;;   N is: 14
(let ((N 14))
  (atom N))

;;; What is (1+ N) where
;;;   N is:67
(let ((N 67))
  (1+ N))

;;; Is (zerop N) true or false, where
;;;   N is: 0
(let ((N 0))
  (zerop N))

;;; Try to write the function MY-+
;;;   Hint: it uses zerop, 1+ and 1-
(defun my-+ (n m)
  (cond
   ((zerop m) n)
   (t (my-+ (1+ n) (1- m)))))

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
(defun my-- (n m)
  (cond
   ((zerop m) n)
   (t (1- (my-- n (1- m))))))

(my-- 3 5)

(defun addvec (vec)
  (cond
   ((null vec) 0)
   (t (+ (car vec) (addvec (cdr vec))))))

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
;;; * questions, and use (1- N) for the       *
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

(defun my-* (n m)
  (cond
   ((zerop m) 0)
   (t (+ n (my-* n (1- m))))))

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
(defun vec+ (vec1 vec2)
  (cond
   ((or (null vec1) (null vec2)) '())
   (t (cons (+ (car vec1) (car vec2)) (vec+ (cdr vec1) (cdr vec2))))))

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
(defun vec+ (vec1 vec2)
  (cond
   ((null vec1) '())
   (t (cons (+ (car vec1) (car vec2))
	    (vec+
	     (cdr vec1) (cdr vec2))))))

;;; What is (vec+ VEC1 VEC2), where
;;;   VEC1 is: '(2 3)
;;;   and VEC2 is: '(4 6)
(let ((VEC1 '(3 7))
      (VEC2 '(4 6)))
  (vec+ VEC1 VEC2))

;;; second book solution
(defun vec+ (vec1 vec2)
  (cond
   ((null vec1) vec2)
   (t (cons (+ (car vec1) (car vec2))
	    (vec+
	     (cdr vec1) (cdr vec2))))))

;;; Handle when vecs are not the same length
(let ((VEC1 '(3 7))
      (VEC2 '(4 6 8 1)))
  (vec+ VEC1 VEC2))

;;; third book solution
(defun vec+ (vec1 vec2)
  (cond
   ((null vec1) vec2)
   ((null vec2) vec1)
   (t (cons (+ (car vec1) (car vec2))
	    (vec+
	     (cdr vec1) (cdr vec2))))))

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

(defun my-> (n m)
  (cond
   ((zerop m) t)
   ((zerop n) nil)
   (t (my-> (1- n) (1- m)))))

(let ((N 12) (M 13)) (my-> N M))
(let ((N 12) (M 11)) (my-> N M))

(let ((N 11) (M 11)) (my-> N M))

;; fix for equal args
(defun my-> (n m)
  (cond
   ((zerop n) nil)
   ((zerop m) t)
   (t (my-> (1- n) (1- m)))))

(defun my-< (n m)
  (cond
   ((zerop m) nil)
   ((zerop n) t)
   (t (my-< (1- n) (1- m)))))


(let ((N 12) (M 13)) (my-< N M))
(let ((N 12) (M 11)) (my-< N M))

(let ((N 11) (M 11)) (my-< N M))

;;; Here is the definition of MY-=
(defun my-= (n m)
  (cond
   ((zerop m) (zerop n))
   ((zerop n) nil)
   (t (my-= (1- n) (1- m)))))

;;; Rewrite MY-+ using MY-< and MY->
(defun my-= (n m)
  (cond
   ((my-< n m) nil)
   ((my-> n m) nil)
   (t t)))

(let ((N 12) (M 13)) (my-= N M))
(let ((N 12) (M 11)) (my-= N M))

(let ((N 11) (M 11)) (my-= N M))

;;; Write the function MY-^
;;; Hint: See The Fourth and Fifth Commandments
(defun my-^ (n m)
  (cond
   ((zerop m) 1)
   (t (my-* n (my-^ n (1- m ))))))

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
(defun my-length (lat)
  (cond
   ((null lat) 0)
   (t (my-+ 1 (my-length (cdr lat))))))

;;; What is the value of (MY-LENGTH LAT), where
;;;   LAT is: (hotdogs with mustard sauerkraut and pickles)
(let ((LAT '(hotdogs with mustard sauerkraut and pickles)))
  (my-length LAT))

;;; What is (MY-LENGTH LAT), where
;;;   LAT is: (ham and cheese on rye)
(let ((LAT '(ham and cheese on rye)))
  (my-length LAT))

;;; book version
(defun my-length (lat)
  (cond
   ((null lat) 0)
   (t (1+ (my-length (cdr lat))))))

;;; PICK
;;; my solution
(defun pick (n lat)
  (cond
   ((null lat) nil)
   ((my-= n 1) (car lat))
   (t (pick (1- n) (cdr lat)))))

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
(defun pick (n lat)
  (cond
   ((null lat) nil)
   ((zerop (1- n)) (car lat))
   (t (pick (1- n) (cdr lat)))))

;;; Does the order of the two terminal conditions matter?
;;; Think about it
;;; Try it out
(defun pick (n lat)
  (cond
   ((zerop (1- n)) (car lat))
   ((null lat) nil)
   (t (pick (1- n) (cdr lat)))))

(defun rempick (n lat)
  (cond
   ((zerop (1- n)) (cdr lat))
   ((null lat) '())
   (t (cons (car lat) (rempick (1- n) (cdr lat))))))

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

;;; Is (NUMBERP A) true or false, where
;;;   A is: tomato
(let ((A 'tomato))
  (numberp A))

;;; Is (NUMBERP A) true or false, where
;;;   A is: 76
(let ((A 76))
  (numberp A))

;;; Can you write NUMBERP, which is true if its
;;; argument is a numeric atom and false if its
;;; argument is a non-numeric atom?
;;; No.
;;; NUMBERP, like 1+, 1-, ZEROP, CAR, CDR, NULL, EQ and ATOM
;;; is a primitive function

;;; Now, using NUMBERP, write a function NO-NUMS,
;;; which gives as a final value a LAT obtained
;;; by removing all the numbers from the LAT.
;;; For example where
;;;   LAT is: (5 pears 6 prunes 9 dates)
;;;   (NO-NUMS LAT) is: (pears prunes dates)
(defun no-nums (lat)
  (cond
   ((null lat) '())
   (t (cond ((numberp (car lat)) (no-nums (cdr lat)))
	 (t (cons (car lat) (no-nums (cdr lat))))))))

(let ((LAT '(5 pears 6 prunes 9 dates)))
  (no-nums LAT))

;;; Now write ALL-NUMS which builds a VEC as a
;;; final value given a LAT
(defun all-nums (lat)
  (cond
   ((null lat) '())
   (t (cond ((numberp (car lat))
	     (cons (car lat)
		   (all-nums (cdr lat))))
	    (t (all-nums (cdr lat)))))))

(let ((LAT '(5 pears 6 prunes 9 dates)))
  (all-nums LAT))

;;; Write the function EQANP which is true if its
;;; two arguments, A1 and A2, are the same atom.
;;; Remember to use = for numbers and EQ for all
;;; others.
;;; my solution
(defun eqanp (a1 a2)
  (cond
   ((numberp a1)
    (cond
     ((numberp a2) (= a1 a2))
     (t nil)))
   (t (eq a1 a2))))

;;; book solution
(defun eqanp (a1 a2)
  (cond
   ((numberp a1)
    (cond
     ((numberp a2) (= a1 a2))
     (t nil)))
   ((numberp a2) nil)
   (t (eq a1 a2))))

(eqanp 1 'love)
(eqanp 3 3)
(eqanp nil nil)
(eqanp 'one 'one)

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
;;;   Examples
;;;     (duplicate THREE OBJ) is: ((x y) (x y) (x y))
;;;     (duplicate ZERO OBJ) is: ()
;;;     (duplicate ONE VEC1) is: ((1 2))
(defun duplicate(n obj)
    (cond
     ((zerop n) '())
     (t (cons obj (duplicate (1- n) obj)))))

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
;;;   Examples
;;;     (multivec VEC2) is: 24
;;;     (multivec VEC3) is: 6
;;;     (multivec L) is: 1
(defun multivec (vec)
  (cond
   ((null vec) 1)
   (t (* (car vec) (multivec (cdr vec))))))

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
(defun index (a lat)
  (cond
   ((eq (car lat) a) 1)
   (t (1+ (index a (cdr lat))))))

(let ((A 'car)
      (LAT1 '(cons cdr car null? eq?)))
  (index A LAT1))

(let ((A 'car)
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
(defun product (vec1 vec2)
  (cond
   ((null vec1) vec2)
   ((null vec2) vec1)
   (t (cons
       (* (car vec1) (car vec2))
       (product (cdr vec1) (cdr vec2))))))

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
;;;   Examples
;;;     (dot-product VEC2 VEC2) is: 29
;;;     (dot-product VEC2 VEC4) is: 26
;;;     (dot-product VEC3 VEC4) is: 17
(defun dot-product (vec1 vec2)
  (cond
   ((null vec1) 0)
   (t (+ (* (car vec1) (car vec2))
	 (dot-product (cdr vec1) (cdr vec2))))))

(let ((VEC2 '(3 2 4)))
  (dot-product VEC2 VEC2))

(let ((VEC2 '(3 2 4))
      (VEC4 '(6 2 1)))
  (dot-product VEC2 VEC4))

(let ((VEC3 '(2 1 3))
      (VEC4 '(6 2 1)))
  (dot-product VEC3 VEC4))

;;; 4.8 Write the function MY-/ that divides nonnegative integers
;;;   Examples
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
(defun my-/ (n m)
  (cond
   ((> m n) 0)
   (t (1+ (my-/ (- n m) m)))))

(let ((N 7) (M 5)) (my-/ N M))
(let ((N 8) (M 2)) (my-/ N M))
(let ((N 2) (M 3)) (my-/ N M))

;;; 4.9 Here is the function REMAINDER
(defun remainder (n m)
  (cond
   (t (- n (* m (/ n m))))))
;;; Make up examples for this application (REMAINDER N M)
;;; and work through them

(remainder 7 5)
(remainder 225 136)
(remainder 0 12)
(remainder 29 26)
(remainder 26 29)

;;; 4.10 Write the function MY-<= which tests if two numbers
;;;   are equal or if the first is less than the second
;;;   Examples
;;;     (MY-<= ZERO ONE) is: true
;;;     (MY-<= ONE ONE) is: true
;;;     (MY-<= THREE ONE) is: false
(defun my-<= (n m)
  (cond
   ((zerop n) t)
   ((zerop m) nil)
   (t (my-<= (1- n) (1- m)))))

(let ((ZERO 0) (ONE 1)) (my-<= ZERO ONE))
(let ((ONE 1)) (my-<= ONE ONE))
(let ((ONE 1) (THREE 3)) (my-<= THREE ONE))

;;; *******************************************
;;; *        The Multichapter Chapter         *
;;; *******************************************

;;; Write the function MEMBER
(defun member (a lat)
  (cond
   ((null lat) nil)
   (t (or
       (eq (car lat) a)
       (member a (cdr lat))))))

;;; Write the function REMBER
(defun rember (a lat)
  (cond
   ((null lat) '())
   ((eq (car lat) a) (cdr lat))
   (t (cons (car lat)
	    (rember a (cdr lat))))))

;;; Write the function MULTIREMBER which gives as its
;;; final value the LAT with *all* occurrences of A
;;; removed
(defun multirember (a lat)
  (cond
   ((null lat) '())
   (t (cond ((eq (car lat) a)
	     (multirember a (cdr lat)))
	    (t (cons (car lat)
		     (multirember a (cdr lat))))))))

(multirember 'cup '(coffee cup tea cup and hick cup))

;;; Write the function MULTIINSERTR
(defun multiinsertR (new old lat)
  (cond
   ((null lat) '())
   (t (cond
       ((eq (car lat) old)
	(cons old
	      (cons new
		    (multiinsertR new old (cdr lat))))
	(t (cons (car lat) (multiinsertR new old (cdr lat)))))))))

;;; Try out this function
(defun multiinsertL (new old lat)
  (cond
   ((null lat) '())
   (t (cond
       ((eq (car lat) old)
	(cons new
	      (cons old
		    (multiinsertL new old lat))))
       (t (cons (car lat) (multiinsertL new old (cdr lat))))))))

(multiinsertL 'fried 'fish '(chips and fish or fish and fried))

;;; Now try to write the function multiinsertl
(defun multiinsertL (new old lat)
  (cond
   ((null lat) '())
   (t (cond
       ((eq (car lat) old)
	(cons new
	      (cons old
		    (multiinsertL new old (cdr lat)))))
       (t (cons (car lat) (multiinsertL new old (cdr lat))))))))

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
(defun multisubst (new old lat)
  (cond
   ((null lat) '())
   (cond ((eq (car lat) old)
	  (cons new (multisubst new old (cdr lat))))
	 (t (cons (car lat) (multisubst new old (cdr lat)))))))

;;; Now write the function OCCUR which counts the
;;; number of times an atom A appears in a LAT.
(defun occur (a lat)
  (cond
   ((null lat) 0)
   (cond ((eq (car lat) a) (1+ (occur a (cdr lat))))
	 (t (occur a (cdr lat))))))

;;; Write the function ONEP where
;;; (ONEP N) is T if N is 1, and NIL otherwise
(defun onep (n) (zerop (1- n)))

(onep 1)
(onep 10)
(onep 0)

;;; from book
(defun onep (n)
  (cond
   ((zerop n) nil)
   (t (zerop (1- n)))))

;;; or
(defun onep (n)
  (cond
   (t (= n 1))))

;;; simply, without cond
(defun onep (n) (= n 1))

;;; Now rewrite the function REMPICK that
;;; removes the Nth atom from the LAT.
;;; For example, where
;;;   N is: 3
;;;  and LAT is: (lemon meringue salty pie)
;;; the application (REMPICK N LAT) has the value:
;;;   (lemon meringue pie)
;;; Use the function ONEP in your answer.
(defun rempick (n lat)
  (cond
   ((onep n) (cdr lat))
   ((null lat) '())
   (t (cons (car lat) (rempick (1- n) (cdr lat))))))

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
;;;   Examples
;;;     (multisubst-kiwis B LAT1) is: (bananas plums)
;;;     (multisubst-kiwis Y LAT2) is: (peaches apples bananas)
;;;     (multisubst-kiwis Y LAT4) is: (dot mangoes dot guavas dot)
;;;     (multisubst-kiwis Y L4) is: ()
(defun multisubst-kiwis (a lat)
  (cond ((null lat) '())
	(t (cond ((eq (car lat) 'kiwis) (cons a (multisubst-kiwis a (cdr lat))))
	      (t (cons (car lat) (multisubst-kiwis a (cdr lat))))))))

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
      (L4 ()))
  (multisubst-kiwis Y L4))

;;; 5.2 Write the function MULTISUBST2. You can find SUBST2
;;;   at the end of Chapter 3.
;;;   Examples
;;;     (multisubst2 X A B LAT1) is: (bananas comma)
;;;     (multisubst2 Y A B LAT3) is: (dot pears dot bananas cherries)
;;;     (multisubst2 A X Y LAT1) is: (bananas kiwis)
(defun multisubst2 (new o1 o2 lat)
  (cond
   ((null lat) '())
   (t (cond
       ((or (eq (car lat) o1)
	    (eq (car lat) o2))
	(cons new (multisubst2 new o1 o2 (cdr lat))))
       (t (cons (car lat) (multisubst2 new o1 o2 (cdr lat))))))))

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
;;;   Examples
;;;     (multidown LAT1) is: ((bananas) (kiwis))
;;;     (multidown LAT2) is: ((peaches) (apples) (bananas))
;;;     (multidown L4) is: ()
(defun multidown (lat)
  (cond
   ((null lat) '())
   (t (cons (cons (car lat) '()) (multidown (cdr lat))))))

(defun multidown (lat)
  (cond
   ((null lat) '())
   (t (cons (list (car lat)) (multidown (cdr lat))))))

(let ((LAT1 '(bananas kiwis)))
  (multidown LAT1))

(let ((LAT2 '(peaches apples bananas)))
  (multidown LAT2))

(let ((L4 ()))
  (multidown L4))

;;; 5.4 Write the function OCCURN of ALAT and LAT
;;;   which counts how many times an atom in ALAT
;;;   also occurs in LAT
;;;   Examples
;;;     (occurn LAT1 L4) is: 0
;;;     (occurn LAT1 LAT2) is: 1
;;;     (occurn LAT1 LAT3) is: 2
(defun occurn (alat lat)
  (cond
   ((null lat) 0)
   (t (cond ((member (car lat) alat)
	     (1+ (occurn alat (cdr lat))))
	    (t (occurn alat (cdr lat)))))))

(let ((LAT1 '(bananas kiwis)) (L4 ()))
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
;;;   Examples
;;;     (I LAT1 L4) is: ()
;;;     (I LAT1 LAT2) is: bananas
;;;     (I LAT1 LAT3) is: kiwis
;;;     (MULTII LAT1 L4: ()
;;;     (MULTII LAT1 LAT2) is: (bananas)
;;;     (MULTII LAT1 LAT3) is: (kiwis bananas)
(defun I (lat1 lat2)
  (cond
   ((null lat2) '())
   (t (cond ((member (car lat2) lat1) (car lat2))
	 (t (I lat1 (cdr lat2)))))))

(defun multiI (lat1 lat2)
  (cond
   ((null lat2) '())
   (t (cond ((member (car lat2) lat1)
	     (cons (car lat2) (multiI lat1 (cdr lat2))))
	    (t (multiI lat1 (cdr lat2)))))))

(let ((LAT1 '(bananas kiwis))
      (L4 ()))
  (I LAT1 L4))
   
(let ((LAT1 '(bananas kiwis))
      (LAT2 '(peaches apples bananas)))
  (I LAT1 LAT2))

(let ((LAT1 '(bananas kiwis))
      (LAT3 '(kiwis pears plums bananas cherries)))
  (I LAT1 LAT3))

(let ((LAT1 '(bananas kiwis))
      (L4 ()))
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
(defun count0 (vec)
  (cond
   ((null vec) 1)
   (t (cond
       ((zerop (car vec))
	(cons 0 (count0 (cdr vec))))
       (t (count0 (cdr vec)))))))

(defun count0 (vec)
  (cond
   ((null vec) 0)
   (t (cond
       ((zerop (car vec))
	(1+ (count0 (cdr vec))))
       (t (count0 (cdr vec)))))))
  
(let ((VEC '(1 0 1 2 0 3 0 0 4 1 0 0 5)))
  (count0 VEC))

;;; 5.9 Write the function MULTIUP of L which replaces
;;;   every LAT of length 1 in L by the atom in that list,
;;;   and which also removes every empty list
;;;   Examples
;;;     (multiup L4) is: ()
;;;     (multiup L1) is: (curry chicken)
;;;     (multiup L2) is: (peaches (and cream))
(defun multiup (l)
  (cond ((null l) '())
	((null (car l)) (multiup (cdr l)))
	((consp (car l))
	 (cond ((onep (length (car l)))
		(cons (car (car l)) (multiup (cdr l))))
	       (t (cons (car l) (multiup (cdr l))))))
	(t (cons (car l) (multiup (cdr l))))))

(let ((L4 ()))
  (multiup L4))

(let ((L1 '((curry) () (chicken) ())))
  (multiup L1))

(let ((L2 '((peaches) (and cream))))
  (multiup L2))

;;; *******************************************
;;; *             *Oh My Gawd*                *
;;; *          It's Full of Stars             *
;;; *******************************************
