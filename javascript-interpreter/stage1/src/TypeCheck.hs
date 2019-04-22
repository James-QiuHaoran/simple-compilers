module TypeCheck where

import Declare
import Prelude hiding (LT, GT, EQ)

type TEnv = [(String,Type)]

type TFunEnv = [(String, (TEnv, Type))]

tunary :: UnaryOp -> Type -> Maybe Type
tunary Neg TInt = Just TInt
tunary Not TBool = Just TBool
tunary _ _ = Nothing

tbinary :: BinaryOp -> Type -> Type -> Maybe Type
tbinary Add TInt TInt   = Just TInt
tbinary Sub TInt TInt   = Just TInt
tbinary Mult TInt TInt  = Just TInt
tbinary Div TInt TInt   = Just TInt
tbinary And TBool TBool = Just TBool
tbinary Or TBool TBool  = Just TBool
tbinary GT TInt TInt    = Just TBool
tbinary LT TInt TInt    = Just TBool
tbinary LE TInt TInt    = Just TBool
tbinary GE TInt TInt    = Just TBool
tbinary EQ TBool TBool  = Just TBool
tbinary EQ TInt TInt    = Just TBool
tbinary _ _ _           = Nothing

checkFunEnv :: FunEnv -> Maybe TFunEnv
checkFunEnv fds = checkFunEnv1 fds [] -- starts with an empty function type environment
  where
    checkFunEnv1 :: FunEnv -> TFunEnv -> Maybe TFunEnv
    checkFunEnv1 [] env = Just env
    checkFunEnv1 ((s, Function args exp):xs) env = case tcheck exp args env of
                                                       Nothing -> Nothing
                                                       Just t  -> checkFunEnv1 xs newEnv
                                                           where newEnv = (s, (args, t)):env

checkFunEnv1 :: FunEnv -> TFunEnv -> Maybe TFunEnv
checkFunEnv1 [] env = Just env
checkFunEnv1 ((s, Function args exp):xs) env = case tcheck exp args env of
                                                   Nothing -> Nothing
                                                   Just t  -> checkFunEnv1 xs newEnv
                                                       where newEnv = (s, (args, t)):env
{-checkFunEnv :: FunEnv -> Maybe TFunEnv
checkFunEnv fds = checkFunEnv1 fds [] -- starts with an empty function type environment
  where
    checkFunEnv1 :: FunEnv -> TFunEnv -> Maybe TFunEnv
    checkFunEnv1 [] fenv = Just fenv
    checkFunEnv1 ((name, Function paras body):fs) fenv =
      case tcheck body paras fenv of
        Nothing -> Nothing
        Just t  -> checkFunEnv1 fs ((name, (paras, t)) : fenv)
-}
-- type check an expression under the environment of parameters and the environment of functions
tcheck :: Exp -> TEnv -> TFunEnv -> Maybe Type
tcheck (Lit (BoolV v)) env fenv      = Just TBool
tcheck (Lit (IntV v)) env fenv       = Just TInt
tcheck (Unary op exp) env fenv       = case tcheck exp env fenv of
                                           Just t  -> tunary op t
                                           Nothing -> Nothing
tcheck (Bin op exp1 exp2) env fenv   = case tcheck exp1 env fenv of
                                           Just t1 -> case tcheck exp2 env fenv of
                                                          Just t2 -> tbinary op t1 t2
                                                          Nothing -> Nothing
                                           Nothing -> Nothing
tcheck (If exp1 exp2 exp3) env fenv  = case tcheck exp1 env fenv of
                                           Just TBool -> case tcheck exp2 env fenv of
                                                             Just t1 ->
                                                                 if Just t1 == tcheck exp3 env fenv
                                                                 then Just t1
                                                                 else Nothing
                                                             Nothing -> Nothing
                                           _    -> Nothing
tcheck (Var var) env fenv            = lookup var env
tcheck (Decl var exp1 exp2) env fenv = case tcheck exp1 env fenv of
                                           Just t1  -> tcheck exp2 ((var, t1):env) fenv
                                           Nothing -> Nothing
tcheck (Call func args) env fenv     = case lookup func fenv of
                                           Nothing -> Nothing
                                           Just (tenv, t) -> case checkArgs args tenv of
                                                                 False -> Nothing
                                                                 True  -> Just t

checkArgs :: [Exp] -> TEnv -> Bool
checkArgs [] tenv = True
checkArgs (x:xs) tenv = (True) && (checkArgs xs tenv) 

-- first type check function defintions
-- then type check the body of the program using the returned function environment
checkProgram :: Program -> Bool
checkProgram (Program fds main) =
    case checkFunEnv fds of
        Nothing -> False
        Just fenv ->
            case tcheck main [] fenv of
                Nothing -> False
                Just t  -> True

-- Question 9
{-
  No. The function environment does not contain the function that is been
  checked. To be specific, the type checker does not know (unable to infer) the
  return type of the function it is checking, so it gets stuck at the recursive
  call.

  One possible way to fix this issue is to ask user to explicitly supply the
  return type. The function definition would be more similar to C/C++/Java
  style: `int fact(x : int) { ... }`. During the type checking of any function
  definition, the type of the function could be added directly to the function
  environment (so recursive calls can be handled), and we need to double check
  at the end whether its return type is actually what the user specified.
-}