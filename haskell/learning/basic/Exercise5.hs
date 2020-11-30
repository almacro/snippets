{- 1. Would the following piece of Haskell work?:
      3:[True,False]
      Why or why not?
-}
-- No. This code attempts to cons a number onto a
-- list of Bools which is a type violation. Only a
-- element of type Bool can be cons'ed onto such a
-- list.

{- 2. Write a function `cons8` that takes a list as
      an argument and conses 8 at the beginning on
      to it. Test it out on the following lists by
      doing:
      1. cons8 []
      2. cons8 [1,2,3,4]
      3. cons8 [True,False]
      4. let foo = cons8 [1,2,3]
         cons8 foo
-}
cons8 xs = 8:xs

{- 3. Adapt the above function in a way that `8` is
      at the end of the list.
      (Hint: recall the concatenation operator from
       the previous chapter.)
-}
append8 xs = xs ++ (cons8 [])

{- 4. Write a function that takes two arguments, a list
      and a thing, and conses the thing onto the list.
      You can start out with:
      let myCons list thing =
-}
let myCons list thing = thing:list
