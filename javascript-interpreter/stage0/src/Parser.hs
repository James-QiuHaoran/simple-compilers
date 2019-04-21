{-# OPTIONS_GHC -w #-}
module Parser (parseExpr) where
import Data.Char (isDigit, isSpace, isAlpha)
import Prelude hiding (LT, GT, EQ)
import Declare
import Tokens
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11

action_0 (12) = happyShift action_2
action_0 (13) = happyShift action_11
action_0 (14) = happyShift action_12
action_0 (16) = happyShift action_13
action_0 (19) = happyShift action_14
action_0 (23) = happyShift action_15
action_0 (25) = happyShift action_16
action_0 (26) = happyShift action_17
action_0 (33) = happyShift action_18
action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_4
action_0 (6) = happyGoto action_5
action_0 (7) = happyGoto action_6
action_0 (8) = happyGoto action_7
action_0 (9) = happyGoto action_8
action_0 (10) = happyGoto action_9
action_0 (11) = happyGoto action_10
action_0 _ = happyFail

action_1 (12) = happyShift action_2
action_1 _ = happyFail

action_2 (13) = happyShift action_34
action_2 _ = happyFail

action_3 (35) = happyAccept
action_3 _ = happyFail

action_4 (34) = happyShift action_33
action_4 _ = happyReduce_3

action_5 (32) = happyShift action_32
action_5 _ = happyReduce_5

action_6 _ = happyReduce_7

action_7 (15) = happyShift action_25
action_7 (16) = happyShift action_26
action_7 (27) = happyShift action_27
action_7 (28) = happyShift action_28
action_7 (29) = happyShift action_29
action_7 (30) = happyShift action_30
action_7 (31) = happyShift action_31
action_7 _ = happyReduce_13

action_8 (17) = happyShift action_23
action_8 (18) = happyShift action_24
action_8 _ = happyReduce_16

action_9 _ = happyReduce_19

action_10 _ = happyReduce_22

action_11 _ = happyReduce_26

action_12 _ = happyReduce_23

action_13 (13) = happyShift action_11
action_13 (14) = happyShift action_12
action_13 (16) = happyShift action_13
action_13 (19) = happyShift action_14
action_13 (25) = happyShift action_16
action_13 (26) = happyShift action_17
action_13 (33) = happyShift action_18
action_13 (10) = happyGoto action_22
action_13 (11) = happyGoto action_10
action_13 _ = happyFail

action_14 (12) = happyShift action_2
action_14 (13) = happyShift action_11
action_14 (14) = happyShift action_12
action_14 (16) = happyShift action_13
action_14 (19) = happyShift action_14
action_14 (23) = happyShift action_15
action_14 (25) = happyShift action_16
action_14 (26) = happyShift action_17
action_14 (33) = happyShift action_18
action_14 (4) = happyGoto action_21
action_14 (5) = happyGoto action_4
action_14 (6) = happyGoto action_5
action_14 (7) = happyGoto action_6
action_14 (8) = happyGoto action_7
action_14 (9) = happyGoto action_8
action_14 (10) = happyGoto action_9
action_14 (11) = happyGoto action_10
action_14 _ = happyFail

action_15 (19) = happyShift action_20
action_15 _ = happyFail

action_16 _ = happyReduce_24

action_17 _ = happyReduce_25

action_18 (13) = happyShift action_11
action_18 (14) = happyShift action_12
action_18 (16) = happyShift action_13
action_18 (19) = happyShift action_14
action_18 (25) = happyShift action_16
action_18 (26) = happyShift action_17
action_18 (33) = happyShift action_18
action_18 (10) = happyGoto action_19
action_18 (11) = happyGoto action_10
action_18 _ = happyFail

action_19 _ = happyReduce_21

action_20 (12) = happyShift action_2
action_20 (13) = happyShift action_11
action_20 (14) = happyShift action_12
action_20 (16) = happyShift action_13
action_20 (19) = happyShift action_14
action_20 (23) = happyShift action_15
action_20 (25) = happyShift action_16
action_20 (26) = happyShift action_17
action_20 (33) = happyShift action_18
action_20 (4) = happyGoto action_48
action_20 (5) = happyGoto action_4
action_20 (6) = happyGoto action_5
action_20 (7) = happyGoto action_6
action_20 (8) = happyGoto action_7
action_20 (9) = happyGoto action_8
action_20 (10) = happyGoto action_9
action_20 (11) = happyGoto action_10
action_20 _ = happyFail

action_21 (20) = happyShift action_47
action_21 _ = happyFail

action_22 _ = happyReduce_20

action_23 (13) = happyShift action_11
action_23 (14) = happyShift action_12
action_23 (16) = happyShift action_13
action_23 (19) = happyShift action_14
action_23 (25) = happyShift action_16
action_23 (26) = happyShift action_17
action_23 (33) = happyShift action_18
action_23 (10) = happyGoto action_46
action_23 (11) = happyGoto action_10
action_23 _ = happyFail

action_24 (13) = happyShift action_11
action_24 (14) = happyShift action_12
action_24 (16) = happyShift action_13
action_24 (19) = happyShift action_14
action_24 (25) = happyShift action_16
action_24 (26) = happyShift action_17
action_24 (33) = happyShift action_18
action_24 (10) = happyGoto action_45
action_24 (11) = happyGoto action_10
action_24 _ = happyFail

action_25 (13) = happyShift action_11
action_25 (14) = happyShift action_12
action_25 (16) = happyShift action_13
action_25 (19) = happyShift action_14
action_25 (25) = happyShift action_16
action_25 (26) = happyShift action_17
action_25 (33) = happyShift action_18
action_25 (9) = happyGoto action_44
action_25 (10) = happyGoto action_9
action_25 (11) = happyGoto action_10
action_25 _ = happyFail

action_26 (13) = happyShift action_11
action_26 (14) = happyShift action_12
action_26 (16) = happyShift action_13
action_26 (19) = happyShift action_14
action_26 (25) = happyShift action_16
action_26 (26) = happyShift action_17
action_26 (33) = happyShift action_18
action_26 (9) = happyGoto action_43
action_26 (10) = happyGoto action_9
action_26 (11) = happyGoto action_10
action_26 _ = happyFail

action_27 (13) = happyShift action_11
action_27 (14) = happyShift action_12
action_27 (16) = happyShift action_13
action_27 (19) = happyShift action_14
action_27 (25) = happyShift action_16
action_27 (26) = happyShift action_17
action_27 (33) = happyShift action_18
action_27 (8) = happyGoto action_42
action_27 (9) = happyGoto action_8
action_27 (10) = happyGoto action_9
action_27 (11) = happyGoto action_10
action_27 _ = happyFail

action_28 (13) = happyShift action_11
action_28 (14) = happyShift action_12
action_28 (16) = happyShift action_13
action_28 (19) = happyShift action_14
action_28 (25) = happyShift action_16
action_28 (26) = happyShift action_17
action_28 (33) = happyShift action_18
action_28 (8) = happyGoto action_41
action_28 (9) = happyGoto action_8
action_28 (10) = happyGoto action_9
action_28 (11) = happyGoto action_10
action_28 _ = happyFail

action_29 (13) = happyShift action_11
action_29 (14) = happyShift action_12
action_29 (16) = happyShift action_13
action_29 (19) = happyShift action_14
action_29 (25) = happyShift action_16
action_29 (26) = happyShift action_17
action_29 (33) = happyShift action_18
action_29 (8) = happyGoto action_40
action_29 (9) = happyGoto action_8
action_29 (10) = happyGoto action_9
action_29 (11) = happyGoto action_10
action_29 _ = happyFail

action_30 (13) = happyShift action_11
action_30 (14) = happyShift action_12
action_30 (16) = happyShift action_13
action_30 (19) = happyShift action_14
action_30 (25) = happyShift action_16
action_30 (26) = happyShift action_17
action_30 (33) = happyShift action_18
action_30 (8) = happyGoto action_39
action_30 (9) = happyGoto action_8
action_30 (10) = happyGoto action_9
action_30 (11) = happyGoto action_10
action_30 _ = happyFail

action_31 (13) = happyShift action_11
action_31 (14) = happyShift action_12
action_31 (16) = happyShift action_13
action_31 (19) = happyShift action_14
action_31 (25) = happyShift action_16
action_31 (26) = happyShift action_17
action_31 (33) = happyShift action_18
action_31 (8) = happyGoto action_38
action_31 (9) = happyGoto action_8
action_31 (10) = happyGoto action_9
action_31 (11) = happyGoto action_10
action_31 _ = happyFail

action_32 (13) = happyShift action_11
action_32 (14) = happyShift action_12
action_32 (16) = happyShift action_13
action_32 (19) = happyShift action_14
action_32 (25) = happyShift action_16
action_32 (26) = happyShift action_17
action_32 (33) = happyShift action_18
action_32 (7) = happyGoto action_37
action_32 (8) = happyGoto action_7
action_32 (9) = happyGoto action_8
action_32 (10) = happyGoto action_9
action_32 (11) = happyGoto action_10
action_32 _ = happyFail

action_33 (13) = happyShift action_11
action_33 (14) = happyShift action_12
action_33 (16) = happyShift action_13
action_33 (19) = happyShift action_14
action_33 (25) = happyShift action_16
action_33 (26) = happyShift action_17
action_33 (33) = happyShift action_18
action_33 (6) = happyGoto action_36
action_33 (7) = happyGoto action_6
action_33 (8) = happyGoto action_7
action_33 (9) = happyGoto action_8
action_33 (10) = happyGoto action_9
action_33 (11) = happyGoto action_10
action_33 _ = happyFail

action_34 (22) = happyShift action_35
action_34 _ = happyFail

action_35 (12) = happyShift action_2
action_35 (13) = happyShift action_11
action_35 (14) = happyShift action_12
action_35 (16) = happyShift action_13
action_35 (19) = happyShift action_14
action_35 (23) = happyShift action_15
action_35 (25) = happyShift action_16
action_35 (26) = happyShift action_17
action_35 (33) = happyShift action_18
action_35 (4) = happyGoto action_50
action_35 (5) = happyGoto action_4
action_35 (6) = happyGoto action_5
action_35 (7) = happyGoto action_6
action_35 (8) = happyGoto action_7
action_35 (9) = happyGoto action_8
action_35 (10) = happyGoto action_9
action_35 (11) = happyGoto action_10
action_35 _ = happyFail

action_36 (32) = happyShift action_32
action_36 _ = happyReduce_4

action_37 _ = happyReduce_6

action_38 (15) = happyShift action_25
action_38 (16) = happyShift action_26
action_38 _ = happyReduce_8

action_39 (15) = happyShift action_25
action_39 (16) = happyShift action_26
action_39 _ = happyReduce_12

action_40 (15) = happyShift action_25
action_40 (16) = happyShift action_26
action_40 _ = happyReduce_10

action_41 (15) = happyShift action_25
action_41 (16) = happyShift action_26
action_41 _ = happyReduce_11

action_42 (15) = happyShift action_25
action_42 (16) = happyShift action_26
action_42 _ = happyReduce_9

action_43 (17) = happyShift action_23
action_43 (18) = happyShift action_24
action_43 _ = happyReduce_15

action_44 (17) = happyShift action_23
action_44 (18) = happyShift action_24
action_44 _ = happyReduce_14

action_45 _ = happyReduce_18

action_46 _ = happyReduce_17

action_47 _ = happyReduce_27

action_48 (20) = happyShift action_49
action_48 _ = happyFail

action_49 (12) = happyShift action_2
action_49 (13) = happyShift action_11
action_49 (14) = happyShift action_12
action_49 (16) = happyShift action_13
action_49 (19) = happyShift action_14
action_49 (23) = happyShift action_15
action_49 (25) = happyShift action_16
action_49 (26) = happyShift action_17
action_49 (33) = happyShift action_18
action_49 (4) = happyGoto action_52
action_49 (5) = happyGoto action_4
action_49 (6) = happyGoto action_5
action_49 (7) = happyGoto action_6
action_49 (8) = happyGoto action_7
action_49 (9) = happyGoto action_8
action_49 (10) = happyGoto action_9
action_49 (11) = happyGoto action_10
action_49 _ = happyFail

action_50 (21) = happyShift action_51
action_50 _ = happyFail

action_51 (12) = happyShift action_2
action_51 (13) = happyShift action_11
action_51 (14) = happyShift action_12
action_51 (16) = happyShift action_13
action_51 (19) = happyShift action_14
action_51 (23) = happyShift action_15
action_51 (25) = happyShift action_16
action_51 (26) = happyShift action_17
action_51 (33) = happyShift action_18
action_51 (4) = happyGoto action_54
action_51 (5) = happyGoto action_4
action_51 (6) = happyGoto action_5
action_51 (7) = happyGoto action_6
action_51 (8) = happyGoto action_7
action_51 (9) = happyGoto action_8
action_51 (10) = happyGoto action_9
action_51 (11) = happyGoto action_10
action_51 _ = happyFail

action_52 (21) = happyShift action_53
action_52 _ = happyFail

action_53 (24) = happyShift action_55
action_53 _ = happyFail

action_54 _ = happyReduce_1

action_55 (12) = happyShift action_2
action_55 (13) = happyShift action_11
action_55 (14) = happyShift action_12
action_55 (16) = happyShift action_13
action_55 (19) = happyShift action_14
action_55 (23) = happyShift action_15
action_55 (25) = happyShift action_16
action_55 (26) = happyShift action_17
action_55 (33) = happyShift action_18
action_55 (4) = happyGoto action_56
action_55 (5) = happyGoto action_4
action_55 (6) = happyGoto action_5
action_55 (7) = happyGoto action_6
action_55 (8) = happyGoto action_7
action_55 (9) = happyGoto action_8
action_55 (10) = happyGoto action_9
action_55 (11) = happyGoto action_10
action_55 _ = happyFail

action_56 _ = happyReduce_2

happyReduce_1 = happyReduce 6 4 happyReduction_1
happyReduction_1 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Decl happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_2 = happyReduce 8 4 happyReduction_2
happyReduction_2 ((HappyAbsSyn4  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (If happy_var_3 happy_var_5 happy_var_8
	) `HappyStk` happyRest

happyReduce_3 = happySpecReduce_1  4 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  5 happyReduction_4
happyReduction_4 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (Binary Or happy_var_1 happy_var_3
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  6 happyReduction_6
happyReduction_6 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (Binary And happy_var_1 happy_var_3
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  6 happyReduction_7
happyReduction_7 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  7 happyReduction_8
happyReduction_8 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (Binary EQ happy_var_1 happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  7 happyReduction_9
happyReduction_9 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (Binary LT happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  7 happyReduction_10
happyReduction_10 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (Binary GT happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  7 happyReduction_11
happyReduction_11 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (Binary LE happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  7 happyReduction_12
happyReduction_12 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (Binary GE happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  7 happyReduction_13
happyReduction_13 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  8 happyReduction_14
happyReduction_14 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (Binary Add happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  8 happyReduction_15
happyReduction_15 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (Binary Sub happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  8 happyReduction_16
happyReduction_16 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  9 happyReduction_17
happyReduction_17 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Binary Mult happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  9 happyReduction_18
happyReduction_18 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Binary Div happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  9 happyReduction_19
happyReduction_19 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_2  10 happyReduction_20
happyReduction_20 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Unary Neg happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_2  10 happyReduction_21
happyReduction_21 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Unary Not happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  10 happyReduction_22
happyReduction_22 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  11 happyReduction_23
happyReduction_23 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn11
		 (Literal (IntV happy_var_1)
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  11 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn11
		 (Literal (BoolV True)
	)

happyReduce_25 = happySpecReduce_1  11 happyReduction_25
happyReduction_25 _
	 =  HappyAbsSyn11
		 (Literal (BoolV False)
	)

happyReduce_26 = happySpecReduce_1  11 happyReduction_26
happyReduction_26 (HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn11
		 (Var happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  11 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (happy_var_2
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 35 35 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenVar -> cont 12;
	TokenSym happy_dollar_dollar -> cont 13;
	TokenInt happy_dollar_dollar -> cont 14;
	TokenPlus -> cont 15;
	TokenMinus -> cont 16;
	TokenTimes -> cont 17;
	TokenDiv -> cont 18;
	TokenLParen -> cont 19;
	TokenRParen -> cont 20;
	TokenSemiColon -> cont 21;
	TokenEq -> cont 22;
	TokenIf -> cont 23;
	TokenElse -> cont 24;
	TokenTrue -> cont 25;
	TokenFalse -> cont 26;
	TokenLT -> cont 27;
	TokenLE -> cont 28;
	TokenGT -> cont 29;
	TokenGE -> cont 30;
	TokenComp -> cont 31;
	TokenAnd -> cont 32;
	TokenNot -> cont 33;
	TokenOr -> cont 34;
	_ -> happyError' (tk:tks)
	}

happyError_ 35 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = return
    (<*>) = ap
instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> HappyIdentity a
happyError' = HappyIdentity . parseError

parser tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError _ = error "Parse error"

parseExpr = parser . scanTokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 16 "<built-in>" #-}
{-# LINE 1 "/Users/jeremybi/.stack/programs/x86_64-osx/ghc-7.10.3/lib/ghc-7.10.3/include/ghcversion.h" #-}


















{-# LINE 17 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 


{-# LINE 13 "templates/GenericTemplate.hs" #-}


{-# LINE 46 "templates/GenericTemplate.hs" #-}









{-# LINE 67 "templates/GenericTemplate.hs" #-}


{-# LINE 77 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action


{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

