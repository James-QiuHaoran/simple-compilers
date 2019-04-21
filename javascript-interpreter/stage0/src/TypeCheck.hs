module TypeCheck where

import Declare
import Interp
import Parser
import Prelude hiding (LT, GT, EQ)

data Type
  = TInt
  | TBool
  deriving (Eq,Show)

type TEnv = [(String,Type)]


-- | Question 3
--
-- >>> tunary Neg TInt
-- Just TInt
--
-- >>> tbinary Add TInt TBool
-- Nothing
tunary :: UnaryOp -> Type -> Maybe Type
tunary Not TInt  = Nothing
tunary Not TBool = Just TBool
tunary Neg TInt  = Nothing
tunary Neg TBool = Just TBool

tbinary :: BinaryOp -> Type -> Type -> Maybe Type
tbinary Add TInt TInt   = Just TInt
tbinary Sub TInt TInt   = Just TInt
tbinary Mult TInt TInt  = Just TInt
tbinary Div TInt TInt   = Just TInt
tbinary And TBool TBool = Just TBool
tbinary Or TBool TBool  = Just TBool
tbinary GT TInt TInt    = Just TInt
tbinary LT TInt TInt    = Just TInt
tbinary LE TInt TInt    = Just TInt
tbinary GE TInt TInt    = Just TInt
tbinary EQ TBool TBool  = Just TBool
tbinary EQ TInt TInt    = Just TInt
tbinary _ _ _           = Nothing

-- | Question 4
--
-- >>> testq4 "1"
-- Just TInt
--
-- >>> testq4 "false"
-- Just TBool
--
-- >>> testq4 "1*false"
-- Nothing
--
-- >>> testq4 "var x = 5; if (x > 0) x; else x * x"
-- Just TInt
--
-- >>> testq4 "var x = y; var y = 3; x + y"
-- Nothing
tcheck :: Exp -> TEnv -> Maybe Type
tcheck (Literal (BoolV v)) env   = Just TBool
tcheck (Literal (IntV v)) env    = Just TInt
tcheck (Unary op exp) env        = case tcheck exp env of
                                    Just t  -> tunary op t
                                    Nothing -> Nothing
tcheck (Binary op exp1 exp2) env = case tcheck exp1 env of
                                    Just t1 -> case tcheck exp2 env of
                                                   Just t2 -> tbinary op t1 t2
                                                   Nothing -> Nothing
                                    Nothing -> Nothing
tcheck (If exp1 exp2 exp3) env   = case tcheck exp1 env of
                                    Just t  -> if t1 == t2 then t1 else Nothing
                                        where t1 = tcheck exp2 env
                                              t2 = tcheck exp3 env
                                    Nothing -> Nothing
tcheck (Var var) env             = case lookup var env of
                                    Nothing -> Nothing
                                    Just t  -> Just t
tcheck (Decl var exp1 exp2) env  = case tcheck exp1 env of
                                    Just t1  -> case tcheck exp2 ((var, t1):env) of
                                                    Just t2 -> Just t2
                                                    Nothing -> Nothing
                                    Nothing -> Nothing

-- | Question 5
--
-- >>> tcalc "3 == 3"
-- true
--
-- >>> tcalc "if (3 == 4) true; else false"
-- false
--
-- >>> tcalc "var x = 3; x + true"
-- *** Exception: You have a type-error in your program!
tcalc :: String -> Value
tcalc e = case tcheck (parseExpr e) [] of
              Nothing   -> error "You have a type-error in your program!"
              otherwise -> calc e


testq4 :: String -> Maybe Type
testq4 e = tcheck (parseExpr e) []