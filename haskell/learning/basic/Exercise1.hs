-- Explain how GHCi evaluates
--   quadruple x
{-
   double x = 2 * x
   quadruple x = double (double x)

   quadruple x
   => double (double x)
   => double (2 * x)
   => 2 * (2 * x)
   => 4 * x
-}

-- Define a function that subtracts 12 from half its argument
half x = x / 2
foo x = half x - 12
