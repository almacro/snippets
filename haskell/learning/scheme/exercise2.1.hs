-- Exercise 2.1
--
-- Change the program (listing2.hs) so it reads two
-- arguments from the command line, and prints out
-- a message using both of them
--
module Main where
import System.Environment

main :: IO ()
main = do
  args <- getArgs
  putStrLn("Hello, " ++ args !! 0 ++ " " ++ args !! 1)
