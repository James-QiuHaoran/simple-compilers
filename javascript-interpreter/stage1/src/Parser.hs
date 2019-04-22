{-# OPTIONS_GHC -w #-}
module Parser (parseExpr) where
import Data.Char (isDigit, isSpace, isAlpha)
import Prelude hiding (LT, GT, EQ)
import Declare
import Tokens
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10

action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_2
action_0 _ = happyReduce_3

action_1 (5) = happyGoto action_2
action_1 _ = happyFail

action_2 (11) = happyShift action_6
action_2 (12) = happyShift action_7
action_2 (13) = happyShift action_8
action_2 (17) = happyShift action_9
action_2 (20) = happyShift action_10
action_2 (28) = happyShift action_11
action_2 (30) = happyShift action_12
action_2 (31) = happyShift action_13
action_2 (38) = happyShift action_14
action_2 (40) = happyShift action_15
action_2 (6) = happyGoto action_4
action_2 (9) = happyGoto action_5
action_2 _ = happyFail

action_3 (41) = happyAccept
action_3 _ = happyFail

action_4 _ = happyReduce_2

action_5 (16) = happyShift action_23
action_5 (17) = happyShift action_24
action_5 (18) = happyShift action_25
action_5 (19) = happyShift action_26
action_5 (32) = happyShift action_27
action_5 (33) = happyShift action_28
action_5 (34) = happyShift action_29
action_5 (35) = happyShift action_30
action_5 (36) = happyShift action_31
action_5 (37) = happyShift action_32
action_5 (39) = happyShift action_33
action_5 _ = happyReduce_1

action_6 (12) = happyShift action_22
action_6 _ = happyFail

action_7 (20) = happyShift action_21
action_7 _ = happyReduce_29

action_8 _ = happyReduce_25

action_9 (11) = happyShift action_6
action_9 (12) = happyShift action_7
action_9 (13) = happyShift action_8
action_9 (17) = happyShift action_9
action_9 (20) = happyShift action_10
action_9 (28) = happyShift action_11
action_9 (30) = happyShift action_12
action_9 (31) = happyShift action_13
action_9 (38) = happyShift action_14
action_9 (9) = happyGoto action_20
action_9 _ = happyFail

action_10 (11) = happyShift action_6
action_10 (12) = happyShift action_7
action_10 (13) = happyShift action_8
action_10 (17) = happyShift action_9
action_10 (20) = happyShift action_10
action_10 (28) = happyShift action_11
action_10 (30) = happyShift action_12
action_10 (31) = happyShift action_13
action_10 (38) = happyShift action_14
action_10 (9) = happyGoto action_19
action_10 _ = happyFail

action_11 (20) = happyShift action_18
action_11 _ = happyFail

action_12 _ = happyReduce_26

action_13 _ = happyReduce_27

action_14 (11) = happyShift action_6
action_14 (12) = happyShift action_7
action_14 (13) = happyShift action_8
action_14 (17) = happyShift action_9
action_14 (20) = happyShift action_10
action_14 (28) = happyShift action_11
action_14 (30) = happyShift action_12
action_14 (31) = happyShift action_13
action_14 (38) = happyShift action_14
action_14 (9) = happyGoto action_17
action_14 _ = happyFail

action_15 (12) = happyShift action_16
action_15 _ = happyFail

action_16 (20) = happyShift action_50
action_16 _ = happyFail

action_17 _ = happyReduce_24

action_18 (11) = happyShift action_6
action_18 (12) = happyShift action_7
action_18 (13) = happyShift action_8
action_18 (17) = happyShift action_9
action_18 (20) = happyShift action_10
action_18 (28) = happyShift action_11
action_18 (30) = happyShift action_12
action_18 (31) = happyShift action_13
action_18 (38) = happyShift action_14
action_18 (9) = happyGoto action_49
action_18 _ = happyFail

action_19 (16) = happyShift action_23
action_19 (17) = happyShift action_24
action_19 (18) = happyShift action_25
action_19 (19) = happyShift action_26
action_19 (21) = happyShift action_48
action_19 (32) = happyShift action_27
action_19 (33) = happyShift action_28
action_19 (34) = happyShift action_29
action_19 (35) = happyShift action_30
action_19 (36) = happyShift action_31
action_19 (37) = happyShift action_32
action_19 (39) = happyShift action_33
action_19 _ = happyFail

action_20 _ = happyReduce_23

action_21 (11) = happyShift action_6
action_21 (12) = happyShift action_7
action_21 (13) = happyShift action_8
action_21 (17) = happyShift action_9
action_21 (20) = happyShift action_10
action_21 (28) = happyShift action_11
action_21 (30) = happyShift action_12
action_21 (31) = happyShift action_13
action_21 (38) = happyShift action_14
action_21 (9) = happyGoto action_46
action_21 (10) = happyGoto action_47
action_21 _ = happyReduce_33

action_22 (27) = happyShift action_45
action_22 _ = happyFail

action_23 (11) = happyShift action_6
action_23 (12) = happyShift action_7
action_23 (13) = happyShift action_8
action_23 (17) = happyShift action_9
action_23 (20) = happyShift action_10
action_23 (28) = happyShift action_11
action_23 (30) = happyShift action_12
action_23 (31) = happyShift action_13
action_23 (38) = happyShift action_14
action_23 (9) = happyGoto action_44
action_23 _ = happyFail

action_24 (11) = happyShift action_6
action_24 (12) = happyShift action_7
action_24 (13) = happyShift action_8
action_24 (17) = happyShift action_9
action_24 (20) = happyShift action_10
action_24 (28) = happyShift action_11
action_24 (30) = happyShift action_12
action_24 (31) = happyShift action_13
action_24 (38) = happyShift action_14
action_24 (9) = happyGoto action_43
action_24 _ = happyFail

action_25 (11) = happyShift action_6
action_25 (12) = happyShift action_7
action_25 (13) = happyShift action_8
action_25 (17) = happyShift action_9
action_25 (20) = happyShift action_10
action_25 (28) = happyShift action_11
action_25 (30) = happyShift action_12
action_25 (31) = happyShift action_13
action_25 (38) = happyShift action_14
action_25 (9) = happyGoto action_42
action_25 _ = happyFail

action_26 (11) = happyShift action_6
action_26 (12) = happyShift action_7
action_26 (13) = happyShift action_8
action_26 (17) = happyShift action_9
action_26 (20) = happyShift action_10
action_26 (28) = happyShift action_11
action_26 (30) = happyShift action_12
action_26 (31) = happyShift action_13
action_26 (38) = happyShift action_14
action_26 (9) = happyGoto action_41
action_26 _ = happyFail

action_27 (11) = happyShift action_6
action_27 (12) = happyShift action_7
action_27 (13) = happyShift action_8
action_27 (17) = happyShift action_9
action_27 (20) = happyShift action_10
action_27 (28) = happyShift action_11
action_27 (30) = happyShift action_12
action_27 (31) = happyShift action_13
action_27 (38) = happyShift action_14
action_27 (9) = happyGoto action_40
action_27 _ = happyFail

action_28 (11) = happyShift action_6
action_28 (12) = happyShift action_7
action_28 (13) = happyShift action_8
action_28 (17) = happyShift action_9
action_28 (20) = happyShift action_10
action_28 (28) = happyShift action_11
action_28 (30) = happyShift action_12
action_28 (31) = happyShift action_13
action_28 (38) = happyShift action_14
action_28 (9) = happyGoto action_39
action_28 _ = happyFail

action_29 (11) = happyShift action_6
action_29 (12) = happyShift action_7
action_29 (13) = happyShift action_8
action_29 (17) = happyShift action_9
action_29 (20) = happyShift action_10
action_29 (28) = happyShift action_11
action_29 (30) = happyShift action_12
action_29 (31) = happyShift action_13
action_29 (38) = happyShift action_14
action_29 (9) = happyGoto action_38
action_29 _ = happyFail

action_30 (11) = happyShift action_6
action_30 (12) = happyShift action_7
action_30 (13) = happyShift action_8
action_30 (17) = happyShift action_9
action_30 (20) = happyShift action_10
action_30 (28) = happyShift action_11
action_30 (30) = happyShift action_12
action_30 (31) = happyShift action_13
action_30 (38) = happyShift action_14
action_30 (9) = happyGoto action_37
action_30 _ = happyFail

action_31 (11) = happyShift action_6
action_31 (12) = happyShift action_7
action_31 (13) = happyShift action_8
action_31 (17) = happyShift action_9
action_31 (20) = happyShift action_10
action_31 (28) = happyShift action_11
action_31 (30) = happyShift action_12
action_31 (31) = happyShift action_13
action_31 (38) = happyShift action_14
action_31 (9) = happyGoto action_36
action_31 _ = happyFail

action_32 (11) = happyShift action_6
action_32 (12) = happyShift action_7
action_32 (13) = happyShift action_8
action_32 (17) = happyShift action_9
action_32 (20) = happyShift action_10
action_32 (28) = happyShift action_11
action_32 (30) = happyShift action_12
action_32 (31) = happyShift action_13
action_32 (38) = happyShift action_14
action_32 (9) = happyGoto action_35
action_32 _ = happyFail

action_33 (11) = happyShift action_6
action_33 (12) = happyShift action_7
action_33 (13) = happyShift action_8
action_33 (17) = happyShift action_9
action_33 (20) = happyShift action_10
action_33 (28) = happyShift action_11
action_33 (30) = happyShift action_12
action_33 (31) = happyShift action_13
action_33 (38) = happyShift action_14
action_33 (9) = happyGoto action_34
action_33 _ = happyFail

action_34 (16) = happyShift action_23
action_34 (17) = happyShift action_24
action_34 (18) = happyShift action_25
action_34 (19) = happyShift action_26
action_34 (32) = happyShift action_27
action_34 (33) = happyShift action_28
action_34 (34) = happyShift action_29
action_34 (35) = happyShift action_30
action_34 (36) = happyShift action_31
action_34 (37) = happyShift action_32
action_34 _ = happyReduce_12

action_35 (16) = happyShift action_23
action_35 (17) = happyShift action_24
action_35 (18) = happyShift action_25
action_35 (19) = happyShift action_26
action_35 (32) = happyShift action_27
action_35 (33) = happyShift action_28
action_35 (34) = happyShift action_29
action_35 (35) = happyShift action_30
action_35 (36) = happyShift action_31
action_35 _ = happyReduce_13

action_36 (16) = happyShift action_23
action_36 (17) = happyShift action_24
action_36 (18) = happyShift action_25
action_36 (19) = happyShift action_26
action_36 (32) = happyShift action_27
action_36 (33) = happyShift action_28
action_36 (34) = happyShift action_29
action_36 (35) = happyShift action_30
action_36 (36) = happyFail
action_36 _ = happyReduce_14

action_37 (16) = happyShift action_23
action_37 (17) = happyShift action_24
action_37 (18) = happyShift action_25
action_37 (19) = happyShift action_26
action_37 (32) = happyFail
action_37 (33) = happyFail
action_37 (34) = happyFail
action_37 (35) = happyFail
action_37 _ = happyReduce_18

action_38 (16) = happyShift action_23
action_38 (17) = happyShift action_24
action_38 (18) = happyShift action_25
action_38 (19) = happyShift action_26
action_38 (32) = happyFail
action_38 (33) = happyFail
action_38 (34) = happyFail
action_38 (35) = happyFail
action_38 _ = happyReduce_16

action_39 (16) = happyShift action_23
action_39 (17) = happyShift action_24
action_39 (18) = happyShift action_25
action_39 (19) = happyShift action_26
action_39 (32) = happyFail
action_39 (33) = happyFail
action_39 (34) = happyFail
action_39 (35) = happyFail
action_39 _ = happyReduce_17

action_40 (16) = happyShift action_23
action_40 (17) = happyShift action_24
action_40 (18) = happyShift action_25
action_40 (19) = happyShift action_26
action_40 (32) = happyFail
action_40 (33) = happyFail
action_40 (34) = happyFail
action_40 (35) = happyFail
action_40 _ = happyReduce_15

action_41 _ = happyReduce_22

action_42 _ = happyReduce_21

action_43 (18) = happyShift action_25
action_43 (19) = happyShift action_26
action_43 _ = happyReduce_20

action_44 (18) = happyShift action_25
action_44 (19) = happyShift action_26
action_44 _ = happyReduce_19

action_45 (11) = happyShift action_6
action_45 (12) = happyShift action_7
action_45 (13) = happyShift action_8
action_45 (17) = happyShift action_9
action_45 (20) = happyShift action_10
action_45 (28) = happyShift action_11
action_45 (30) = happyShift action_12
action_45 (31) = happyShift action_13
action_45 (38) = happyShift action_14
action_45 (9) = happyGoto action_56
action_45 _ = happyFail

action_46 (16) = happyShift action_23
action_46 (17) = happyShift action_24
action_46 (18) = happyShift action_25
action_46 (19) = happyShift action_26
action_46 (32) = happyShift action_27
action_46 (33) = happyShift action_28
action_46 (34) = happyShift action_29
action_46 (35) = happyShift action_30
action_46 (36) = happyShift action_31
action_46 (37) = happyShift action_32
action_46 (39) = happyShift action_33
action_46 _ = happyReduce_32

action_47 (21) = happyShift action_54
action_47 (26) = happyShift action_55
action_47 _ = happyFail

action_48 _ = happyReduce_30

action_49 (16) = happyShift action_23
action_49 (17) = happyShift action_24
action_49 (18) = happyShift action_25
action_49 (19) = happyShift action_26
action_49 (21) = happyShift action_53
action_49 (32) = happyShift action_27
action_49 (33) = happyShift action_28
action_49 (34) = happyShift action_29
action_49 (35) = happyShift action_30
action_49 (36) = happyShift action_31
action_49 (37) = happyShift action_32
action_49 (39) = happyShift action_33
action_49 _ = happyFail

action_50 (12) = happyShift action_52
action_50 (7) = happyGoto action_51
action_50 _ = happyReduce_7

action_51 (21) = happyShift action_61
action_51 (26) = happyShift action_62
action_51 _ = happyFail

action_52 (25) = happyShift action_60
action_52 _ = happyFail

action_53 (11) = happyShift action_6
action_53 (12) = happyShift action_7
action_53 (13) = happyShift action_8
action_53 (17) = happyShift action_9
action_53 (20) = happyShift action_10
action_53 (28) = happyShift action_11
action_53 (30) = happyShift action_12
action_53 (31) = happyShift action_13
action_53 (38) = happyShift action_14
action_53 (9) = happyGoto action_59
action_53 _ = happyFail

action_54 _ = happyReduce_28

action_55 (11) = happyShift action_6
action_55 (12) = happyShift action_7
action_55 (13) = happyShift action_8
action_55 (17) = happyShift action_9
action_55 (20) = happyShift action_10
action_55 (28) = happyShift action_11
action_55 (30) = happyShift action_12
action_55 (31) = happyShift action_13
action_55 (38) = happyShift action_14
action_55 (9) = happyGoto action_58
action_55 _ = happyFail

action_56 (16) = happyShift action_23
action_56 (17) = happyShift action_24
action_56 (18) = happyShift action_25
action_56 (19) = happyShift action_26
action_56 (24) = happyShift action_57
action_56 (32) = happyShift action_27
action_56 (33) = happyShift action_28
action_56 (34) = happyShift action_29
action_56 (35) = happyShift action_30
action_56 (36) = happyShift action_31
action_56 (37) = happyShift action_32
action_56 (39) = happyShift action_33
action_56 _ = happyFail

action_57 (11) = happyShift action_6
action_57 (12) = happyShift action_7
action_57 (13) = happyShift action_8
action_57 (17) = happyShift action_9
action_57 (20) = happyShift action_10
action_57 (28) = happyShift action_11
action_57 (30) = happyShift action_12
action_57 (31) = happyShift action_13
action_57 (38) = happyShift action_14
action_57 (9) = happyGoto action_69
action_57 _ = happyFail

action_58 (16) = happyShift action_23
action_58 (17) = happyShift action_24
action_58 (18) = happyShift action_25
action_58 (19) = happyShift action_26
action_58 (32) = happyShift action_27
action_58 (33) = happyShift action_28
action_58 (34) = happyShift action_29
action_58 (35) = happyShift action_30
action_58 (36) = happyShift action_31
action_58 (37) = happyShift action_32
action_58 (39) = happyShift action_33
action_58 _ = happyReduce_31

action_59 (16) = happyShift action_23
action_59 (17) = happyShift action_24
action_59 (18) = happyShift action_25
action_59 (19) = happyShift action_26
action_59 (24) = happyShift action_68
action_59 (32) = happyShift action_27
action_59 (33) = happyShift action_28
action_59 (34) = happyShift action_29
action_59 (35) = happyShift action_30
action_59 (36) = happyShift action_31
action_59 (37) = happyShift action_32
action_59 (39) = happyShift action_33
action_59 _ = happyFail

action_60 (14) = happyShift action_66
action_60 (15) = happyShift action_67
action_60 (8) = happyGoto action_65
action_60 _ = happyFail

action_61 (23) = happyShift action_64
action_61 _ = happyFail

action_62 (12) = happyShift action_63
action_62 _ = happyFail

action_63 (25) = happyShift action_72
action_63 _ = happyFail

action_64 (11) = happyShift action_6
action_64 (12) = happyShift action_7
action_64 (13) = happyShift action_8
action_64 (17) = happyShift action_9
action_64 (20) = happyShift action_10
action_64 (28) = happyShift action_11
action_64 (30) = happyShift action_12
action_64 (31) = happyShift action_13
action_64 (38) = happyShift action_14
action_64 (9) = happyGoto action_71
action_64 _ = happyFail

action_65 _ = happyReduce_6

action_66 _ = happyReduce_8

action_67 _ = happyReduce_9

action_68 (29) = happyShift action_70
action_68 _ = happyFail

action_69 (16) = happyShift action_23
action_69 (17) = happyShift action_24
action_69 (18) = happyShift action_25
action_69 (19) = happyShift action_26
action_69 (32) = happyShift action_27
action_69 (33) = happyShift action_28
action_69 (34) = happyShift action_29
action_69 (35) = happyShift action_30
action_69 (36) = happyShift action_31
action_69 (37) = happyShift action_32
action_69 (39) = happyShift action_33
action_69 _ = happyReduce_10

action_70 (11) = happyShift action_6
action_70 (12) = happyShift action_7
action_70 (13) = happyShift action_8
action_70 (17) = happyShift action_9
action_70 (20) = happyShift action_10
action_70 (28) = happyShift action_11
action_70 (30) = happyShift action_12
action_70 (31) = happyShift action_13
action_70 (38) = happyShift action_14
action_70 (9) = happyGoto action_75
action_70 _ = happyFail

action_71 (16) = happyShift action_23
action_71 (17) = happyShift action_24
action_71 (18) = happyShift action_25
action_71 (19) = happyShift action_26
action_71 (22) = happyShift action_74
action_71 (32) = happyShift action_27
action_71 (33) = happyShift action_28
action_71 (34) = happyShift action_29
action_71 (35) = happyShift action_30
action_71 (36) = happyShift action_31
action_71 (37) = happyShift action_32
action_71 (39) = happyShift action_33
action_71 _ = happyFail

action_72 (14) = happyShift action_66
action_72 (15) = happyShift action_67
action_72 (8) = happyGoto action_73
action_72 _ = happyFail

action_73 _ = happyReduce_5

action_74 _ = happyReduce_4

action_75 (16) = happyShift action_23
action_75 (17) = happyShift action_24
action_75 (18) = happyShift action_25
action_75 (19) = happyShift action_26
action_75 (32) = happyShift action_27
action_75 (33) = happyShift action_28
action_75 (34) = happyShift action_29
action_75 (35) = happyShift action_30
action_75 (36) = happyShift action_31
action_75 (37) = happyShift action_32
action_75 (39) = happyShift action_33
action_75 _ = happyReduce_11

happyReduce_1 = happySpecReduce_2  4 happyReduction_1
happyReduction_1 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Program happy_var_1 happy_var_2
	)
happyReduction_1 _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  5 happyReduction_2
happyReduction_2 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_0  5 happyReduction_3
happyReduction_3  =  HappyAbsSyn5
		 ([]
	)

happyReduce_4 = happyReduce 8 6 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn9  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 ((happy_var_2, Function happy_var_4 happy_var_7)
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 5 7 happyReduction_5
happyReduction_5 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (happy_var_1 ++ [(happy_var_3, happy_var_5)]
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_3  7 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_3)
	_
	(HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn7
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_0  7 happyReduction_7
happyReduction_7  =  HappyAbsSyn7
		 ([]
	)

happyReduce_8 = happySpecReduce_1  8 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn8
		 (TInt
	)

happyReduce_9 = happySpecReduce_1  8 happyReduction_9
happyReduction_9 _
	 =  HappyAbsSyn8
		 (TBool
	)

happyReduce_10 = happyReduce 6 9 happyReduction_10
happyReduction_10 ((HappyAbsSyn9  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Decl happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 8 9 happyReduction_11
happyReduction_11 ((HappyAbsSyn9  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (If happy_var_3 happy_var_5 happy_var_8
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_3  9 happyReduction_12
happyReduction_12 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin Or happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  9 happyReduction_13
happyReduction_13 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin And happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  9 happyReduction_14
happyReduction_14 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin EQ happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  9 happyReduction_15
happyReduction_15 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin LT happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  9 happyReduction_16
happyReduction_16 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin GT happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  9 happyReduction_17
happyReduction_17 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin LE happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  9 happyReduction_18
happyReduction_18 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin GE happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  9 happyReduction_19
happyReduction_19 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin Add happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  9 happyReduction_20
happyReduction_20 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin Sub happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  9 happyReduction_21
happyReduction_21 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin Mult happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  9 happyReduction_22
happyReduction_22 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Bin Div happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_2  9 happyReduction_23
happyReduction_23 (HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (Unary Neg happy_var_2
	)
happyReduction_23 _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_2  9 happyReduction_24
happyReduction_24 (HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (Unary Not happy_var_2
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  9 happyReduction_25
happyReduction_25 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn9
		 (Lit (IntV happy_var_1)
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  9 happyReduction_26
happyReduction_26 _
	 =  HappyAbsSyn9
		 (Lit (BoolV True)
	)

happyReduce_27 = happySpecReduce_1  9 happyReduction_27
happyReduction_27 _
	 =  HappyAbsSyn9
		 (Lit (BoolV False)
	)

happyReduce_28 = happyReduce 4 9 happyReduction_28
happyReduction_28 (_ `HappyStk`
	(HappyAbsSyn10  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Call happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_29 = happySpecReduce_1  9 happyReduction_29
happyReduction_29 (HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn9
		 (Var happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  9 happyReduction_30
happyReduction_30 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (happy_var_2
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  10 happyReduction_31
happyReduction_31 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  10 happyReduction_32
happyReduction_32 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_0  10 happyReduction_33
happyReduction_33  =  HappyAbsSyn10
		 ([]
	)

happyNewToken action sts stk [] =
	action 41 41 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenVar -> cont 11;
	TokenSym happy_dollar_dollar -> cont 12;
	TokenInt happy_dollar_dollar -> cont 13;
	TokenTInt -> cont 14;
	TokenTBool -> cont 15;
	TokenPlus -> cont 16;
	TokenMinus -> cont 17;
	TokenTimes -> cont 18;
	TokenDiv -> cont 19;
	TokenLParen -> cont 20;
	TokenRParen -> cont 21;
	TokenRB -> cont 22;
	TokenLB -> cont 23;
	TokenSemiColon -> cont 24;
	TokenColon -> cont 25;
	TokenComma -> cont 26;
	TokenEq -> cont 27;
	TokenIf -> cont 28;
	TokenElse -> cont 29;
	TokenTrue -> cont 30;
	TokenFalse -> cont 31;
	TokenLT -> cont 32;
	TokenLE -> cont 33;
	TokenGT -> cont 34;
	TokenGE -> cont 35;
	TokenComp -> cont 36;
	TokenAnd -> cont 37;
	TokenNot -> cont 38;
	TokenOr -> cont 39;
	TokenFunc -> cont 40;
	_ -> happyError' (tk:tks)
	}

happyError_ 41 tk tks = happyError' tks
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

