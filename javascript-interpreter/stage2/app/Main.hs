module Main where

import Parser
import Declare
import Interp
import TypeCheck

import System.Exit
import System.Environment (getArgs)
import Control.Monad.State.Strict
import Data.List (isPrefixOf)

import System.Console.Repline


-- Types

type Repl a = HaskelineT IO a

hoistErr :: Show e => Either e a -> Repl a
hoistErr (Left str) = do
  liftIO $ putStrLn (show str)
  abort
hoistErr (Right val) = return val


-- Execution
exec :: String -> Repl ()
exec source = do

  abt <- hoistErr $ parseExpr source

  ty <- hoistErr $ tcheck abt []

  let val = execute abt

  liftIO .  putStrLn $ show val ++ " : " ++ show ty


-- Commands

-- :load command
load :: [String] -> Repl ()
load args = do
  contents <- liftIO $ readFile (unwords args)
  exec contents


-- :quit command
quit :: a -> Repl ()
quit _ = liftIO $ exitSuccess


-- Prefix tab completer
defaultMatcher :: MonadIO m => [(String, CompletionFunc m)]
defaultMatcher = [(":load"  , fileCompleter)]

-- Default tab completer
comp :: Monad m => WordCompleter m
comp n = do
  let cmds = [":load", ":quit"]
  return $ filter (isPrefixOf n) cmds


options :: [(String, [String] -> Repl ())]
options = [("load", load) , ("quit", quit)]


-- Entry point

completer :: CompleterStyle IO
completer = Prefix (wordCompleter comp) defaultMatcher

shell :: Repl a -> IO ()
shell pre =  evalRepl "SINH> " exec options completer pre


-- Top level

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> shell (return ())
    [fname] -> shell (load [fname])
    _ -> putStrLn "invalid arguments"
