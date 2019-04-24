module Interp where

import Data.Maybe (fromJust)
import Prelude hiding (LT, GT, EQ)

import Declare


unary :: UnaryOp -> Value -> Value
unary Not (BoolV b) = BoolV (not b)
unary Neg (IntV i)  = IntV (-i)

binary :: BinaryOp -> Value -> Value -> Value
binary Add (IntV a) (IntV b) = IntV (a + b)
binary Sub (IntV a) (IntV b) = IntV (a - b)
binary Mult (IntV a) (IntV b) = IntV (a * b)
binary Div (IntV a) (IntV b) = IntV (a `div` b)
binary And (BoolV a) (BoolV b) = BoolV (a && b)
binary Or (BoolV a) (BoolV b) = BoolV (a || b)
binary LT (IntV a) (IntV b) = BoolV (a < b)
binary LE (IntV a) (IntV b) = BoolV (a <= b)
binary GE (IntV a) (IntV b) = BoolV (a >= b)
binary GT (IntV a) (IntV b) = BoolV (a > b)
binary EQ a b = BoolV (a == b)

evaluate :: Exp -> Env -> Value
evaluate (Lit v) _ = v
evaluate (Unary op a) env = unary op (evaluate a env)
evaluate (Bin op a b) env = binary op (evaluate a env) (evaluate b env)
evaluate (If a b c) env =
  let (BoolV test) = evaluate a env
  in if test
       then evaluate b env
       else evaluate c env
evaluate (Var x) env = fromJust (lookup x env)
evaluate (Decl x _ e body) env =
  evaluate body newEnv
  where
    -- when evaluating `e`, use `newEnv` instead of `env`
    newEnv = (x, evaluate e newEnv) : env
evaluate (Fun (x, t) body) env = ClosureV (x, t) body env
evaluate (Call fun arg) env =
  case evaluate fun env of
    ClosureV (name, _) body env' -> evaluate body ((name, evaluate arg env) : env')


execute :: Exp -> Value
execute e = evaluate e []