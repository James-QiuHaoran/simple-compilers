module Interp where

import Parser
import Declare
import Data.List (delete, union, sort)
import Prelude hiding (LT, GT, EQ)



-- | Question 1
--
-- >>> unary Not (BoolV True)
-- false
--
-- >>> unary Neg (IntV 3)
-- -3
--
-- >>> binary Add (IntV 2) (IntV 3)
-- 5
unary :: UnaryOp -> Value -> Value
unary Not (BoolV v) = BoolV (not v)
unary Neg (IntV v)  = IntV (-v)
unary _ _           = error "Type error"

binary :: BinaryOp -> Value -> Value -> Value
binary Add (IntV v1) (IntV v2)   = IntV (v1 + v2)
binary Sub (IntV v1) (IntV v2)   = IntV (v1 - v2)
binary Mult (IntV v1) (IntV v2)  = IntV (v1 * v2)
binary Div (IntV v1) (IntV v2)   = IntV (v1 `div` v2)
binary And (BoolV v1) (BoolV v2) = BoolV (v1 && v2)
binary Or (BoolV v1) (BoolV v2)  = BoolV (v1 || v2)
binary GT (IntV v1) (IntV v2)    = BoolV (v1 > v2)
binary LT (IntV v1) (IntV v2)    = BoolV (v1 < v2)
binary LE (IntV v1) (IntV v2)    = BoolV (v1 <= v2)
binary GE (IntV v1) (IntV v2)    = BoolV (v1 >= v2)
binary EQ v1 v2                  = BoolV (v1 == v2)
binary _ _ _                     = error "Type error"


type Binding = (String, Value)
type Env = [Binding]


-- | Question 2
--
-- >>> calc "1 + 2"
-- 3
--
-- >>> calc "if (true) 1; else 3"
-- 1
--
-- >>> calc "var x = 5; if (x > 0) x; else x * x"
-- 5

evaluate :: Exp -> Value
evaluate e = eval e [] -- starts with an empty environment
  where eval :: Exp -> Env -> Value
        eval (Literal (BoolV v)) env = BoolV v
        eval (Literal (IntV v)) env  = IntV v
        eval (Unary op exp) env = unary op (eval exp env)
        eval (Binary op exp1 exp2) env = binary op (eval exp1 env) (eval exp2 env)
        eval (If exp1 exp2 exp3) env = if (eval exp1 env) == (BoolV True) then (eval exp2 env) else (eval exp3 env)
        eval (Var var) env = 
            case lookup var env of
                Nothing -> error "Undefined variable"
                Just v  -> v
        eval (Decl var exp1 exp2) env = eval exp2 ((var, eval exp1 env):env)

calc :: String -> Value
calc = evaluate . parseExpr