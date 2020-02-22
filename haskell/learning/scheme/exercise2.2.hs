-- Exercise 2
--
-- Change the program (listing2.hs) so it performs a
-- simple arithmetic operation on the two arguents
-- and prints out the result
--
module Main where
import System.Environment

main :: IO ()
main = do
  args <- getArgs
  -- add
  --putStrLn(show(read(args !! 0) + read(args !! 1)))
  -- sub
  --putStrLn(show(read(args !! 0) - read(args !! 1)))
  -- mul
  --putStrLn(show(read(args !! 0) * read(args !! 1)))
  -- div
  --putStrLn(show(read(args !! 0) / read(args !! 1)))
  -- pow
  putStrLn(show(read(args !! 0) ^ read(args !! 1)))
