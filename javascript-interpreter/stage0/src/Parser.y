{
module Parser (parseExpr) where
import Data.Char (isDigit, isSpace, isAlpha)
import Prelude hiding (LT, GT, EQ)
import Declare
import Tokens
}


%name parser
%tokentype { Token }
%error { parseError }

%token
    var     { TokenVar }
    id      { TokenSym $$ }
    int     { TokenInt $$ }
    '+'     { TokenPlus }
    '-'     { TokenMinus }
    '*'     { TokenTimes }
    '/'     { TokenDiv }
    '('     { TokenLParen }
    ')'     { TokenRParen }
    ';'     { TokenSemiColon }
    '='     { TokenEq }
    if      { TokenIf }
    else    { TokenElse }
    true    { TokenTrue }
    false   { TokenFalse }
    '<'     { TokenLT }
    '<='    { TokenLE }
    '>'     { TokenGT }
    '>='    { TokenGE }
    '=='    { TokenComp }
    '&&'    { TokenAnd }
    '!'     { TokenNot }
    '||'    { TokenOr }

%%

Exp : var id '=' Exp ';' Exp           { Decl $2 $4 $6 }
    | if '(' Exp ')' Exp ';' else Exp  { If $3 $5 $8 }
    | Or                               { $1 }

Or   : Or '||' And        { Binary Or $1 $3 }
     | And                { $1 }

And  : And '&&' Comp      { Binary And $1 $3 }
     | Comp                { $1 }

Comp : AExpr '==' AExpr     { Binary EQ $1 $3 }
     | AExpr '<' AExpr      { Binary LT $1 $3 }
     | AExpr '>' AExpr      { Binary GT $1 $3 }
     | AExpr '<=' AExpr     { Binary LE $1 $3 }
     | AExpr '>=' AExpr     { Binary GE $1 $3 }
     | AExpr                { $1 }

AExpr : AExpr '+' Term        { Binary Add $1 $3 }
      | AExpr '-' Term        { Binary Sub $1 $3 }
      | Term                  { $1 }

Term : Term '*' Expon        { Binary Mult $1 $3 }
     | Term '/' Expon        { Binary Div $1 $3 }
     | Expon                 { $1 }

Expon : '-' Expon             { Unary Neg $2 }
      | '!' Expon             { Unary Not $2 }
      | Primary               { $1 }

Primary : int                 { Literal (IntV $1) }
        | true                { Literal (BoolV True) }
        | false               { Literal (BoolV False) }
        | id                  { Var $1 }
        | '(' Exp ')'         { $2 }

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

parseExpr = parser . scanTokens

}
