{-# OPTIONS_GHC -w #-}
module Parser (parseExpr) where
import Data.Char (isDigit, isSpace, isAlpha)
import Prelude hiding (LT, GT, EQ)
import Declare
import Tokens
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t4 t5 t6
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6

action_0 (7) = happyShift action_5
action_0 (8) = happyShift action_6
action_0 (9) = happyShift action_7
action_0 (13) = happyShift action_8
action_0 (16) = happyShift action_9
action_0 (24) = happyShift action_10
action_0 (26) = happyShift action_11
action_0 (27) = happyShift action_12
action_0 (34) = happyShift action_13
action_0 (36) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_4
action_0 _ = happyFail

action_1 (36) = happyShift action_2
action_1 _ = happyFail

action_2 (16) = happyShift action_31
action_2 _ = happyFail

action_3 (12) = happyShift action_20
action_3 (13) = happyShift action_21
action_3 (14) = happyShift action_22
action_3 (15) = happyShift action_23
action_3 (28) = happyShift action_24
action_3 (29) = happyShift action_25
action_3 (30) = happyShift action_26
action_3 (31) = happyShift action_27
action_3 (32) = happyShift action_28
action_3 (33) = happyShift action_29
action_3 (35) = happyShift action_30
action_3 (38) = happyAccept
action_3 _ = happyFail

action_4 (16) = happyShift action_19
action_4 _ = happyReduce_17

action_5 (8) = happyShift action_18
action_5 _ = happyFail

action_6 _ = happyReduce_19

action_7 _ = happyReduce_21

action_8 (7) = happyShift action_5
action_8 (8) = happyShift action_6
action_8 (9) = happyShift action_7
action_8 (13) = happyShift action_8
action_8 (16) = happyShift action_9
action_8 (24) = happyShift action_10
action_8 (26) = happyShift action_11
action_8 (27) = happyShift action_12
action_8 (34) = happyShift action_13
action_8 (36) = happyShift action_2
action_8 (4) = happyGoto action_17
action_8 (5) = happyGoto action_4
action_8 _ = happyFail

action_9 (7) = happyShift action_5
action_9 (8) = happyShift action_6
action_9 (9) = happyShift action_7
action_9 (13) = happyShift action_8
action_9 (16) = happyShift action_9
action_9 (24) = happyShift action_10
action_9 (26) = happyShift action_11
action_9 (27) = happyShift action_12
action_9 (34) = happyShift action_13
action_9 (36) = happyShift action_2
action_9 (4) = happyGoto action_16
action_9 (5) = happyGoto action_4
action_9 _ = happyFail

action_10 (16) = happyShift action_15
action_10 _ = happyFail

action_11 _ = happyReduce_22

action_12 _ = happyReduce_23

action_13 (7) = happyShift action_5
action_13 (8) = happyShift action_6
action_13 (9) = happyShift action_7
action_13 (13) = happyShift action_8
action_13 (16) = happyShift action_9
action_13 (24) = happyShift action_10
action_13 (26) = happyShift action_11
action_13 (27) = happyShift action_12
action_13 (34) = happyShift action_13
action_13 (36) = happyShift action_2
action_13 (4) = happyGoto action_14
action_13 (5) = happyGoto action_4
action_13 _ = happyFail

action_14 _ = happyReduce_16

action_15 (7) = happyShift action_5
action_15 (8) = happyShift action_6
action_15 (9) = happyShift action_7
action_15 (13) = happyShift action_8
action_15 (16) = happyShift action_9
action_15 (24) = happyShift action_10
action_15 (26) = happyShift action_11
action_15 (27) = happyShift action_12
action_15 (34) = happyShift action_13
action_15 (36) = happyShift action_2
action_15 (4) = happyGoto action_47
action_15 (5) = happyGoto action_4
action_15 _ = happyFail

action_16 (12) = happyShift action_20
action_16 (13) = happyShift action_21
action_16 (14) = happyShift action_22
action_16 (15) = happyShift action_23
action_16 (17) = happyShift action_46
action_16 (28) = happyShift action_24
action_16 (29) = happyShift action_25
action_16 (30) = happyShift action_26
action_16 (31) = happyShift action_27
action_16 (32) = happyShift action_28
action_16 (33) = happyShift action_29
action_16 (35) = happyShift action_30
action_16 _ = happyFail

action_17 _ = happyReduce_15

action_18 (23) = happyShift action_45
action_18 _ = happyFail

action_19 (7) = happyShift action_5
action_19 (8) = happyShift action_6
action_19 (9) = happyShift action_7
action_19 (13) = happyShift action_8
action_19 (16) = happyShift action_9
action_19 (24) = happyShift action_10
action_19 (26) = happyShift action_11
action_19 (27) = happyShift action_12
action_19 (34) = happyShift action_13
action_19 (36) = happyShift action_2
action_19 (4) = happyGoto action_44
action_19 (5) = happyGoto action_4
action_19 _ = happyFail

action_20 (7) = happyShift action_5
action_20 (8) = happyShift action_6
action_20 (9) = happyShift action_7
action_20 (13) = happyShift action_8
action_20 (16) = happyShift action_9
action_20 (24) = happyShift action_10
action_20 (26) = happyShift action_11
action_20 (27) = happyShift action_12
action_20 (34) = happyShift action_13
action_20 (36) = happyShift action_2
action_20 (4) = happyGoto action_43
action_20 (5) = happyGoto action_4
action_20 _ = happyFail

action_21 (7) = happyShift action_5
action_21 (8) = happyShift action_6
action_21 (9) = happyShift action_7
action_21 (13) = happyShift action_8
action_21 (16) = happyShift action_9
action_21 (24) = happyShift action_10
action_21 (26) = happyShift action_11
action_21 (27) = happyShift action_12
action_21 (34) = happyShift action_13
action_21 (36) = happyShift action_2
action_21 (4) = happyGoto action_42
action_21 (5) = happyGoto action_4
action_21 _ = happyFail

action_22 (7) = happyShift action_5
action_22 (8) = happyShift action_6
action_22 (9) = happyShift action_7
action_22 (13) = happyShift action_8
action_22 (16) = happyShift action_9
action_22 (24) = happyShift action_10
action_22 (26) = happyShift action_11
action_22 (27) = happyShift action_12
action_22 (34) = happyShift action_13
action_22 (36) = happyShift action_2
action_22 (4) = happyGoto action_41
action_22 (5) = happyGoto action_4
action_22 _ = happyFail

action_23 (7) = happyShift action_5
action_23 (8) = happyShift action_6
action_23 (9) = happyShift action_7
action_23 (13) = happyShift action_8
action_23 (16) = happyShift action_9
action_23 (24) = happyShift action_10
action_23 (26) = happyShift action_11
action_23 (27) = happyShift action_12
action_23 (34) = happyShift action_13
action_23 (36) = happyShift action_2
action_23 (4) = happyGoto action_40
action_23 (5) = happyGoto action_4
action_23 _ = happyFail

action_24 (7) = happyShift action_5
action_24 (8) = happyShift action_6
action_24 (9) = happyShift action_7
action_24 (13) = happyShift action_8
action_24 (16) = happyShift action_9
action_24 (24) = happyShift action_10
action_24 (26) = happyShift action_11
action_24 (27) = happyShift action_12
action_24 (34) = happyShift action_13
action_24 (36) = happyShift action_2
action_24 (4) = happyGoto action_39
action_24 (5) = happyGoto action_4
action_24 _ = happyFail

action_25 (7) = happyShift action_5
action_25 (8) = happyShift action_6
action_25 (9) = happyShift action_7
action_25 (13) = happyShift action_8
action_25 (16) = happyShift action_9
action_25 (24) = happyShift action_10
action_25 (26) = happyShift action_11
action_25 (27) = happyShift action_12
action_25 (34) = happyShift action_13
action_25 (36) = happyShift action_2
action_25 (4) = happyGoto action_38
action_25 (5) = happyGoto action_4
action_25 _ = happyFail

action_26 (7) = happyShift action_5
action_26 (8) = happyShift action_6
action_26 (9) = happyShift action_7
action_26 (13) = happyShift action_8
action_26 (16) = happyShift action_9
action_26 (24) = happyShift action_10
action_26 (26) = happyShift action_11
action_26 (27) = happyShift action_12
action_26 (34) = happyShift action_13
action_26 (36) = happyShift action_2
action_26 (4) = happyGoto action_37
action_26 (5) = happyGoto action_4
action_26 _ = happyFail

action_27 (7) = happyShift action_5
action_27 (8) = happyShift action_6
action_27 (9) = happyShift action_7
action_27 (13) = happyShift action_8
action_27 (16) = happyShift action_9
action_27 (24) = happyShift action_10
action_27 (26) = happyShift action_11
action_27 (27) = happyShift action_12
action_27 (34) = happyShift action_13
action_27 (36) = happyShift action_2
action_27 (4) = happyGoto action_36
action_27 (5) = happyGoto action_4
action_27 _ = happyFail

action_28 (7) = happyShift action_5
action_28 (8) = happyShift action_6
action_28 (9) = happyShift action_7
action_28 (13) = happyShift action_8
action_28 (16) = happyShift action_9
action_28 (24) = happyShift action_10
action_28 (26) = happyShift action_11
action_28 (27) = happyShift action_12
action_28 (34) = happyShift action_13
action_28 (36) = happyShift action_2
action_28 (4) = happyGoto action_35
action_28 (5) = happyGoto action_4
action_28 _ = happyFail

action_29 (7) = happyShift action_5
action_29 (8) = happyShift action_6
action_29 (9) = happyShift action_7
action_29 (13) = happyShift action_8
action_29 (16) = happyShift action_9
action_29 (24) = happyShift action_10
action_29 (26) = happyShift action_11
action_29 (27) = happyShift action_12
action_29 (34) = happyShift action_13
action_29 (36) = happyShift action_2
action_29 (4) = happyGoto action_34
action_29 (5) = happyGoto action_4
action_29 _ = happyFail

action_30 (7) = happyShift action_5
action_30 (8) = happyShift action_6
action_30 (9) = happyShift action_7
action_30 (13) = happyShift action_8
action_30 (16) = happyShift action_9
action_30 (24) = happyShift action_10
action_30 (26) = happyShift action_11
action_30 (27) = happyShift action_12
action_30 (34) = happyShift action_13
action_30 (36) = happyShift action_2
action_30 (4) = happyGoto action_33
action_30 (5) = happyGoto action_4
action_30 _ = happyFail

action_31 (8) = happyShift action_32
action_31 _ = happyFail

action_32 (21) = happyShift action_51
action_32 _ = happyFail

action_33 (12) = happyShift action_20
action_33 (13) = happyShift action_21
action_33 (14) = happyShift action_22
action_33 (15) = happyShift action_23
action_33 (28) = happyShift action_24
action_33 (29) = happyShift action_25
action_33 (30) = happyShift action_26
action_33 (31) = happyShift action_27
action_33 (32) = happyShift action_28
action_33 (33) = happyShift action_29
action_33 _ = happyReduce_4

action_34 (12) = happyShift action_20
action_34 (13) = happyShift action_21
action_34 (14) = happyShift action_22
action_34 (15) = happyShift action_23
action_34 (28) = happyShift action_24
action_34 (29) = happyShift action_25
action_34 (30) = happyShift action_26
action_34 (31) = happyShift action_27
action_34 (32) = happyShift action_28
action_34 _ = happyReduce_5

action_35 (12) = happyShift action_20
action_35 (13) = happyShift action_21
action_35 (14) = happyShift action_22
action_35 (15) = happyShift action_23
action_35 (28) = happyShift action_24
action_35 (29) = happyShift action_25
action_35 (30) = happyShift action_26
action_35 (31) = happyShift action_27
action_35 (32) = happyFail
action_35 _ = happyReduce_6

action_36 (12) = happyShift action_20
action_36 (13) = happyShift action_21
action_36 (14) = happyShift action_22
action_36 (15) = happyShift action_23
action_36 (28) = happyFail
action_36 (29) = happyFail
action_36 (30) = happyFail
action_36 (31) = happyFail
action_36 _ = happyReduce_10

action_37 (12) = happyShift action_20
action_37 (13) = happyShift action_21
action_37 (14) = happyShift action_22
action_37 (15) = happyShift action_23
action_37 (28) = happyFail
action_37 (29) = happyFail
action_37 (30) = happyFail
action_37 (31) = happyFail
action_37 _ = happyReduce_8

action_38 (12) = happyShift action_20
action_38 (13) = happyShift action_21
action_38 (14) = happyShift action_22
action_38 (15) = happyShift action_23
action_38 (28) = happyFail
action_38 (29) = happyFail
action_38 (30) = happyFail
action_38 (31) = happyFail
action_38 _ = happyReduce_9

action_39 (12) = happyShift action_20
action_39 (13) = happyShift action_21
action_39 (14) = happyShift action_22
action_39 (15) = happyShift action_23
action_39 (28) = happyFail
action_39 (29) = happyFail
action_39 (30) = happyFail
action_39 (31) = happyFail
action_39 _ = happyReduce_7

action_40 _ = happyReduce_14

action_41 _ = happyReduce_13

action_42 (14) = happyShift action_22
action_42 (15) = happyShift action_23
action_42 _ = happyReduce_12

action_43 (14) = happyShift action_22
action_43 (15) = happyShift action_23
action_43 _ = happyReduce_11

action_44 (12) = happyShift action_20
action_44 (13) = happyShift action_21
action_44 (14) = happyShift action_22
action_44 (15) = happyShift action_23
action_44 (17) = happyShift action_50
action_44 (28) = happyShift action_24
action_44 (29) = happyShift action_25
action_44 (30) = happyShift action_26
action_44 (31) = happyShift action_27
action_44 (32) = happyShift action_28
action_44 (33) = happyShift action_29
action_44 (35) = happyShift action_30
action_44 _ = happyFail

action_45 (7) = happyShift action_5
action_45 (8) = happyShift action_6
action_45 (9) = happyShift action_7
action_45 (13) = happyShift action_8
action_45 (16) = happyShift action_9
action_45 (24) = happyShift action_10
action_45 (26) = happyShift action_11
action_45 (27) = happyShift action_12
action_45 (34) = happyShift action_13
action_45 (36) = happyShift action_2
action_45 (4) = happyGoto action_49
action_45 (5) = happyGoto action_4
action_45 _ = happyFail

action_46 _ = happyReduce_20

action_47 (12) = happyShift action_20
action_47 (13) = happyShift action_21
action_47 (14) = happyShift action_22
action_47 (15) = happyShift action_23
action_47 (17) = happyShift action_48
action_47 (28) = happyShift action_24
action_47 (29) = happyShift action_25
action_47 (30) = happyShift action_26
action_47 (31) = happyShift action_27
action_47 (32) = happyShift action_28
action_47 (33) = happyShift action_29
action_47 (35) = happyShift action_30
action_47 _ = happyFail

action_48 (7) = happyShift action_5
action_48 (8) = happyShift action_6
action_48 (9) = happyShift action_7
action_48 (13) = happyShift action_8
action_48 (16) = happyShift action_9
action_48 (24) = happyShift action_10
action_48 (26) = happyShift action_11
action_48 (27) = happyShift action_12
action_48 (34) = happyShift action_13
action_48 (36) = happyShift action_2
action_48 (4) = happyGoto action_56
action_48 (5) = happyGoto action_4
action_48 _ = happyFail

action_49 (12) = happyShift action_20
action_49 (13) = happyShift action_21
action_49 (14) = happyShift action_22
action_49 (15) = happyShift action_23
action_49 (20) = happyShift action_55
action_49 (28) = happyShift action_24
action_49 (29) = happyShift action_25
action_49 (30) = happyShift action_26
action_49 (31) = happyShift action_27
action_49 (32) = happyShift action_28
action_49 (33) = happyShift action_29
action_49 (35) = happyShift action_30
action_49 _ = happyFail

action_50 _ = happyReduce_18

action_51 (10) = happyShift action_53
action_51 (11) = happyShift action_54
action_51 (6) = happyGoto action_52
action_51 _ = happyFail

action_52 (17) = happyShift action_59
action_52 (37) = happyShift action_60
action_52 _ = happyFail

action_53 _ = happyReduce_24

action_54 _ = happyReduce_25

action_55 (7) = happyShift action_5
action_55 (8) = happyShift action_6
action_55 (9) = happyShift action_7
action_55 (13) = happyShift action_8
action_55 (16) = happyShift action_9
action_55 (24) = happyShift action_10
action_55 (26) = happyShift action_11
action_55 (27) = happyShift action_12
action_55 (34) = happyShift action_13
action_55 (36) = happyShift action_2
action_55 (4) = happyGoto action_58
action_55 (5) = happyGoto action_4
action_55 _ = happyFail

action_56 (12) = happyShift action_20
action_56 (13) = happyShift action_21
action_56 (14) = happyShift action_22
action_56 (15) = happyShift action_23
action_56 (20) = happyShift action_57
action_56 (28) = happyShift action_24
action_56 (29) = happyShift action_25
action_56 (30) = happyShift action_26
action_56 (31) = happyShift action_27
action_56 (32) = happyShift action_28
action_56 (33) = happyShift action_29
action_56 (35) = happyShift action_30
action_56 _ = happyFail

action_57 (25) = happyShift action_63
action_57 _ = happyFail

action_58 (12) = happyShift action_20
action_58 (13) = happyShift action_21
action_58 (14) = happyShift action_22
action_58 (15) = happyShift action_23
action_58 (28) = happyShift action_24
action_58 (29) = happyShift action_25
action_58 (30) = happyShift action_26
action_58 (31) = happyShift action_27
action_58 (32) = happyShift action_28
action_58 (33) = happyShift action_29
action_58 (35) = happyShift action_30
action_58 _ = happyReduce_2

action_59 (19) = happyShift action_62
action_59 _ = happyFail

action_60 (10) = happyShift action_53
action_60 (11) = happyShift action_54
action_60 (6) = happyGoto action_61
action_60 _ = happyFail

action_61 (37) = happyShift action_60
action_61 _ = happyReduce_26

action_62 (7) = happyShift action_5
action_62 (8) = happyShift action_6
action_62 (9) = happyShift action_7
action_62 (13) = happyShift action_8
action_62 (16) = happyShift action_9
action_62 (24) = happyShift action_10
action_62 (26) = happyShift action_11
action_62 (27) = happyShift action_12
action_62 (34) = happyShift action_13
action_62 (36) = happyShift action_2
action_62 (4) = happyGoto action_65
action_62 (5) = happyGoto action_4
action_62 _ = happyFail

action_63 (7) = happyShift action_5
action_63 (8) = happyShift action_6
action_63 (9) = happyShift action_7
action_63 (13) = happyShift action_8
action_63 (16) = happyShift action_9
action_63 (24) = happyShift action_10
action_63 (26) = happyShift action_11
action_63 (27) = happyShift action_12
action_63 (34) = happyShift action_13
action_63 (36) = happyShift action_2
action_63 (4) = happyGoto action_64
action_63 (5) = happyGoto action_4
action_63 _ = happyFail

action_64 (12) = happyShift action_20
action_64 (13) = happyShift action_21
action_64 (14) = happyShift action_22
action_64 (15) = happyShift action_23
action_64 (28) = happyShift action_24
action_64 (29) = happyShift action_25
action_64 (30) = happyShift action_26
action_64 (31) = happyShift action_27
action_64 (32) = happyShift action_28
action_64 (33) = happyShift action_29
action_64 (35) = happyShift action_30
action_64 _ = happyReduce_3

action_65 (12) = happyShift action_20
action_65 (13) = happyShift action_21
action_65 (14) = happyShift action_22
action_65 (15) = happyShift action_23
action_65 (18) = happyShift action_66
action_65 (28) = happyShift action_24
action_65 (29) = happyShift action_25
action_65 (30) = happyShift action_26
action_65 (31) = happyShift action_27
action_65 (32) = happyShift action_28
action_65 (33) = happyShift action_29
action_65 (35) = happyShift action_30
action_65 _ = happyFail

action_66 _ = happyReduce_1

happyReduce_1 = happyReduce 9 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Fun (happy_var_3, happy_var_5) happy_var_8
	) `HappyStk` happyRest

happyReduce_2 = happyReduce 6 4 happyReduction_2
happyReduction_2 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Decl happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_3 = happyReduce 8 4 happyReduction_3
happyReduction_3 ((HappyAbsSyn4  happy_var_8) `HappyStk`
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

happyReduce_4 = happySpecReduce_3  4 happyReduction_4
happyReduction_4 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin Or happy_var_1 happy_var_3
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  4 happyReduction_5
happyReduction_5 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin And happy_var_1 happy_var_3
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  4 happyReduction_6
happyReduction_6 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin EQ happy_var_1 happy_var_3
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  4 happyReduction_7
happyReduction_7 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin LT happy_var_1 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  4 happyReduction_8
happyReduction_8 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin GT happy_var_1 happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  4 happyReduction_9
happyReduction_9 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin LE happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  4 happyReduction_10
happyReduction_10 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin GE happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  4 happyReduction_11
happyReduction_11 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin Add happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  4 happyReduction_12
happyReduction_12 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin Sub happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  4 happyReduction_13
happyReduction_13 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin Mult happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  4 happyReduction_14
happyReduction_14 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Bin Div happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_2  4 happyReduction_15
happyReduction_15 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Unary Neg happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  4 happyReduction_16
happyReduction_16 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Unary Not happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  4 happyReduction_17
happyReduction_17 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happyReduce 4 5 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Call happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_19 = happySpecReduce_1  5 happyReduction_19
happyReduction_19 (HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn5
		 (Var happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  5 happyReduction_20
happyReduction_20 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (happy_var_2
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  5 happyReduction_21
happyReduction_21 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn5
		 (Lit (IntV happy_var_1)
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  5 happyReduction_22
happyReduction_22 _
	 =  HappyAbsSyn5
		 (Lit (BoolV True)
	)

happyReduce_23 = happySpecReduce_1  5 happyReduction_23
happyReduction_23 _
	 =  HappyAbsSyn5
		 (Lit (BoolV False)
	)

happyReduce_24 = happySpecReduce_1  6 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn6
		 (TInt
	)

happyReduce_25 = happySpecReduce_1  6 happyReduction_25
happyReduction_25 _
	 =  HappyAbsSyn6
		 (TBool
	)

happyReduce_26 = happySpecReduce_3  6 happyReduction_26
happyReduction_26 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (TFun happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 38 38 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenVar -> cont 7;
	TokenSym happy_dollar_dollar -> cont 8;
	TokenInt happy_dollar_dollar -> cont 9;
	TokenTInt -> cont 10;
	TokenTBool -> cont 11;
	TokenPlus -> cont 12;
	TokenMinus -> cont 13;
	TokenTimes -> cont 14;
	TokenDiv -> cont 15;
	TokenLParen -> cont 16;
	TokenRParen -> cont 17;
	TokenRB -> cont 18;
	TokenLB -> cont 19;
	TokenSemiColon -> cont 20;
	TokenColon -> cont 21;
	TokenComma -> cont 22;
	TokenEq -> cont 23;
	TokenIf -> cont 24;
	TokenElse -> cont 25;
	TokenTrue -> cont 26;
	TokenFalse -> cont 27;
	TokenLT -> cont 28;
	TokenLE -> cont 29;
	TokenGT -> cont 30;
	TokenGE -> cont 31;
	TokenComp -> cont 32;
	TokenAnd -> cont 33;
	TokenNot -> cont 34;
	TokenOr -> cont 35;
	TokenFunc -> cont 36;
	TokenArrow -> cont 37;
	_ -> happyError' (tk:tks)
	}

happyError_ 38 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

happyThen :: () => Either String a -> (a -> Either String b) -> Either String b
happyThen = (>>=)
happyReturn :: () => a -> Either String a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Either String a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> Either String a
happyError' = parseError

parser tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError _ = Left "Parse error"

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

