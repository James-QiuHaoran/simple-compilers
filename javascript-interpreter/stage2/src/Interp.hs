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
evaluate (Fun (x, t) body) env = ClosureV (x, t) body env
evaluate (Call fun arg) env =
  let v = evaluate arg env
      ClosureV (name, _) body env' = evaluate fun env
  in evaluate body $ (name, v) : env'
evaluate (Lit v) _ = v
evaluate (Unary op a) env = unary op (evaluate a env)
evaluate (Bin op a b) env = binary op (evaluate a env) (evaluate b env)
evaluate (If a b c) env =
  let BoolV test = evaluate a env
  in if test
     then evaluate b env
     else evaluate c env
evaluate (Var x) env = fromJust (lookup x env)
evaluate (Decl x e body) env =
  let v = evaluate e env
  in evaluate body ((x, v) : env)


execute :: Exp -> Value
execute e = evaluate e []


-- Stack machine

data Frame = FIf Exp Exp
           | FUnary UnaryOp
           | FBin BinaryOp [Value] [Exp]
           | FCall1 Exp                 -- Give a proper type for both kinds
           | FCall2 Value               -- of call frames
           | FDecl String Exp           -- Give a proper type for decl frames
           | FEnv Env

type Stack = [Frame]

data State = Eval Stack Exp
           | Return Stack Value

getEnv :: Stack -> Env
getEnv [] = []
getEnv (FEnv env : k) = env
getEnv (_ : k) = getEnv k


start :: Exp -> State
start e = Eval [] e

step :: State -> State
step (Eval k (Lit n)) = Return k n
step (Eval k (Bin op e1 e2)) = Eval (FBin op [] [e2] : k) e1
step (Return (FBin op [] [e2] : k) v1) = Eval (FBin op [v1] [] : k) e2
step (Return (FBin op [v1] [] : k) v2) = Return k (binary op v1 v2)
step (Eval k (If e1 e2 e3)) = Eval (FIf e2 e3 : k) e1
step (Return (FIf e2 e3 : k) (BoolV True)) = Eval k e2
step (Return (FIf e2 e3 : k) (BoolV False)) = Eval k e3
step (Eval k (Var n)) = Return k (fromJust (lookup n (getEnv k)))
step (Return (FEnv _ : k) v) = Return k v
step (Eval k (Unary op e)) = Eval (FUnary op : k) e
step (Return (FUnary op : k) v) = Return k (unary op v)
step (Eval k (Fun (n, t) body)) = Return k (ClosureV (n, t) body (getEnv k))
step (Eval k (Call e1 e2)) = Eval (FCall1 e2 : k) e1
step (Return (FCall1 e2 : k) v1) = Eval (FCall2 v1 : k) e2
step (Return (FCall2 (ClosureV (n, t) body env) : k) v2) = Eval (FEnv ((n, v2) : env) : k) body
step (Eval k (Decl n e1 e2)) = Eval (FDecl n e2 : k) e1
step (Return (FDecl n e2 : k) v1) = Eval (FEnv ((n, v1) : getEnv k) : k) e2

multiStep :: State -> State
multiStep s@(Eval _ _) = multiStep (step s)
multiStep s@(Return (_ : _) _) = multiStep (step s)
multiStep s@(Return [] _) = s

execute' :: Exp -> Value
execute' e = case multiStep (start e) of
               Return [] v -> v
