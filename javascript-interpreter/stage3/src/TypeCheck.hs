module TypeCheck where

import Declare
import Prelude hiding (LT, GT, EQ)

type TEnv = [(String,Type)]

tunary :: UnaryOp -> Type -> Either String Type
tunary Neg TInt = Right TInt
tunary Not TBool = Right TBool
tunary _ _ = Left "Type error in unary expression"

tbinary :: BinaryOp -> Type -> Type -> Either String Type
tbinary Add TInt TInt = Right TInt
tbinary Sub TInt TInt = Right TInt
tbinary Mult TInt TInt = Right TInt
tbinary Div TInt TInt = Right TInt
tbinary And TBool TBool = Right TBool
tbinary Or TBool TBool = Right TBool
tbinary LT TInt TInt = Right TBool
tbinary LE TInt TInt = Right TBool
tbinary GE TInt TInt = Right TBool
tbinary GT TInt TInt = Right TBool
tbinary EQ t1 t2
  | t1 == t2 = Right TBool
tbinary _ _ _ = Left "Type error in binary expression"

tcheck :: Exp -> TEnv -> Either String Type
tcheck (Decl x (TFun t1 t2) e body) env = case tcheck e ((x, TFun t1 t2):env) of
  Right (TFun t1 t2) -> tcheck body ((x, TFun t1 t2):env)
  Left msg           -> Left msg
  _                  -> Left "Type error in declaration"
tcheck (Decl x t e body) env = do
  t' <- tcheck e env
  tcheck body ((x, t') : env)
tcheck (Fun (x, t1) e) env = do
  t2 <- tcheck e ((x, t1) : env)
  Right $ (TFun t1 t2)
tcheck (Call e1 e2) env = case (tcheck e1 env, tcheck e2 env) of
  (Right (TFun t1 t2), Right t3)
    | t1 == t3 -> Right t2
  _ -> Left "Application mismatch"
tcheck (Lit (IntV _)) _ = Right TInt
tcheck (Lit (BoolV _)) _ = Right TBool
tcheck (Unary op e) env = do
  t <- tcheck e env
  tunary op t
tcheck (Bin op e1 e2) env = do
  t1 <- tcheck e1 env
  t2 <- tcheck e2 env
  tbinary op t1 t2
tcheck (If e1 e2 e3) env =
  case (tcheck e1 env, tcheck e2 env, tcheck e3 env) of
    (Right TBool, Right t1, Right t2)
      | t1 == t2 -> Right t1
    _ -> Left "Type error in if expression"
tcheck (Var x) env =
  case lookup x env of
    Just t -> Right t
    Nothing -> Left "Type error in var"