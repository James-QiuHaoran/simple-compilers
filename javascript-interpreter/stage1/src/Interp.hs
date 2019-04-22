module Interp where

import Declare
import Prelude hiding (LT, GT, EQ)
import Data.Maybe (fromJust)

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

type Binding = (String, Value)
type Env = [Binding]

execute :: Program -> Value
execute (Program funEnv main) = evaluate main [] funEnv

evaluate :: Exp -> Env -> FunEnv -> Value
evaluate e env fenv = eval e env
  where
    eval :: Exp -> Env -> Value
    eval (Call fun args) env = eval body newEnv
      where Function xs body = fromJust (lookup fun fenv)
            newEnv = zip (map fst xs) [eval a env | a <- args]
    eval (Lit n) _ = n
    eval (Unary op ex) env = unary op (eval ex env)
    eval (Bin op e1 e2) env = binary op (eval e1 env) (eval e2 env)
    eval (If e1 e2 e3) env =
      let BoolV test = eval e1 env
      in if test
         then eval e2 env
         else eval e3 env
    eval (Var v) env = fromJust (lookup v env)   -- does not deal with the failure case
    eval (Decl v a b) env =
      let a' = eval a env
          env' = (v, a') : env
      in eval b env'

evaluate' :: Exp -> Env -> Value
evaluate' (Lit n) env = n
evaluate' (Unary op e) env = unary op (evaluate' e env)
evaluate' (Bin op e1 e2) env = binary op (evaluate' e1 env) (evaluate' e2 env)
evaluate' (If e1 e2 e3) env =
  let BoolV test = evaluate' e1 env
  in if test
     then evaluate' e2 env
     else evaluate' e3 env
evaluate' (Var v) env = fromJust (lookup v env)
evaluate' (Decl v a b) env =
  let a' = evaluate' a env
      env' = (v, a') : env
  in evaluate' b env'
evaluate' _ _ = error "You are in trouble"



fsubst :: (String, Function) -> Exp -> Exp
fsubst (f, Function xs body) exp = subst exp
    where 
      subst (Lit val)            = Lit val
      subst (Unary op exp')      = Unary op (subst exp')
      subst (Bin op exp1 exp2)   = Bin op (subst exp1) (subst exp2)
      subst (If exp1 exp2 exp3)  = If (subst exp1) (subst exp2) (subst exp3)
      subst (Var str)            = Var str
      subst (Decl str exp1 exp2) = Decl str (subst exp1) (subst exp2)
      subst (Call fname fargs)   = if (f == fname)
                                   then transform2Decl (zip (map fst xs) (map subst fargs)) body
                                   else Call fname (map subst fargs)

transform2Decl :: [(String, Exp)] -> Exp -> Exp
transform2Decl [] body               = body
transform2Decl ((name, e) : xs) body = Decl name e (transform2Decl xs body)


execute' :: Program -> Value
execute' (Program funEnv main) = evaluate' (substAll funEnv main) []

substAll :: FunEnv -> Exp -> Exp
substAll [] exp = exp
substAll ((f, fdef):xs) exp = substAll xs (fsubst (f, fdef) exp)