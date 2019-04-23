module CallByName where

import Data.Maybe (fromJust)
import Prelude hiding (LT, GT, EQ)

data BinaryOp = Add | Sub | Mult | Div
              | And | Or  | GT   | LT  | LE
              | GE  | EQ
              deriving Eq

data UnaryOp = Neg
             | Not
             deriving Eq

data Value = IntV Int
           | BoolV Bool
           | ClosureV (String, Type) Exp Env -- added
           deriving Eq

data Type = TInt
          | TBool
          | TFun Type Type                   -- added
          deriving Eq

data Exp = Lit Value
         | Unary UnaryOp Exp
         | Bin BinaryOp Exp Exp
         | If Exp Exp Exp
         | Var String
         | Decl String Exp Exp
         | Call Exp Exp                      -- changed
         | Fun (String, Type) Exp            -- added
         deriving Eq

-- For call-by-name
data ClosureExp = CExp Exp Env deriving (Eq, Show)
type Env = [(String, ClosureExp)]


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
evaluate (Var x) env =
  let (CExp e env') = fromJust (lookup x env)
  in evaluate e env'
evaluate (Decl x e body) env =
  evaluate body newEnv
  where
    newEnv = (x, CExp e env) : env
evaluate (Call fun arg) env =
  let  ClosureV (name, _) body env' = evaluate fun env
  in evaluate body ((name, CExp arg env) : env')
evaluate (Fun (x, t) body) env = ClosureV (x, t) body env
evaluate (Lit v) _ = v
evaluate (Unary op a) env = unary op (evaluate a env)
evaluate (Bin op a b) env = binary op (evaluate a env) (evaluate b env)
evaluate (If a b c) env =
  let BoolV test = evaluate a env
  in if test
     then evaluate b env
     else evaluate c env


execute :: Exp -> Value
execute e = evaluate e []

-- Pretty printer

instance Show Type where
  show TInt = "Int"
  show TBool = "Bool"
  show (TFun t1 t2) = paren $ show t1 ++ " -> " ++ show t2

instance Show Value where
  show (IntV n) = show n
  show (BoolV True) = "true"
  show (BoolV False) = "false"
  show (ClosureV{}) = "Closure"

instance Show Exp where
  show = showExp 0

showSep :: String -> [String] -> String
showSep _ [] = ""
showSep _ [e] = e
showSep sep (e:es) = e ++ sep ++ showSep sep es

showExp :: Int -> Exp -> String
showExp _ (Fun (n, t) e) = "function(" ++ n ++ " : " ++ show t ++ ") {\n " ++ show e ++ "\n}"
showExp _ (Call f arg) = show f ++ "(" ++ show arg ++ ")"
showExp _ (Lit i) = show i
showExp _ (Var x) = x
showExp level (Decl x a b) =
  if level > 0
    then paren result
    else result
  where
    result = "var " ++ x ++ " = " ++ showExp 0 a ++ "; " ++ showExp 0 b
showExp level (If a b c) =
  if level > 0
    then paren result
    else result
  where
    result = "if (" ++ showExp 0 a ++ ") " ++ showExp 0 b ++ "; else " ++ showExp 0 c
showExp _ (Unary Neg a) =
  "-" ++
  showExp 99 a
showExp _ (Unary Not a) =
  "!" ++
  showExp 99 a
showExp level (Bin op a b) =
  showBin level (fromJust (lookup op levels)) a (fromJust (lookup op names)) b
  where
    levels =
      [ (Or, 1)
      , (And, 2)
      , (GT, 3)
      , (LT, 3)
      , (LE, 3)
      , (GE, 3)
      , (EQ, 3)
      , (Add, 4)
      , (Sub, 4)
      , (Mult, 5)
      , (Div, 5)
      ]
    names =
      [ (Or, "||")
      , (And, "&&")
      , (GT, ">")
      , (LT, "<")
      , (LE, "<=")
      , (GE, ">=")
      , (EQ, "==")
      , (Add, "+")
      , (Sub, "-")
      , (Mult, "*")
      , (Div, "/")
      ]

showBin :: Int -> Int -> Exp -> String -> Exp -> String
showBin outer inner a op b =
  if inner < outer
    then paren result
    else result
  where
    result = showExp inner a ++ " " ++ op ++ " " ++ showExp inner b

paren :: String -> String
paren x = "(" ++ x ++ ")"
