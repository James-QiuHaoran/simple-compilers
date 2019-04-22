module Main where

import Prelude hiding (LT, GT, EQ)
import Data.Maybe (fromJust)
import Declare
import Parser
import Interp
import TypeCheck
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  src <- readFile . head $ args
  let ast = parseExpr src
  if checkProgram ast
    then print . execute $ ast
    else error "You have type error in your program"