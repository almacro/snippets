-- Exercise 2.3
--
-- Change the program (listing2.hs) so it prompts
-- for a name, reads the name, and then prints it
--
module Main where
import System.Environment
import System.IO

main :: IO ()
main = do
  putStr("Enter your name: ")
  hFlush stdout
  name <- getLine
  putStrLn(name)
