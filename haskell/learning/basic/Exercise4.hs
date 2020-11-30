{- What are the types of the following functions?
   For any functions involving numbers, you can
   just pretend the numbers are Ints.
-}
{- 1. The `negate` function which takes an Int and
      and returns that Int with its sign swapped.
      For example, `negate 4 = -4`, and
      `negate (-2) = 2`
-}
:t negate
-- negate :: Num a => a -> a

{- 2. The `(||)` function, pronounced 'or', that takes
      two Bools and returns a third Bool which is True
      if either of the arguments were, and False otherwise.
-}
:t (||)
-- (||) :: Bool -> Bool -> Bool

{- 3. A monthLength function which takes a Bool which is
      True if we are considering a leap year and False
      otherwise, and an Int which is the number of a month;
      and returns another Int which is the number of days
      in that month.
-}
-- monthLength :: Bool -> Int -> Int

{- f x y = not x && y -}
-- f :: Bool -> Bool -> Bool

{- g x = (2*x - 1)^2 -}
-- g :: Num => a -> a
