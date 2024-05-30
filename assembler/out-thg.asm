@~(Turtle)_INIT
push 0
call @drawRate
push 0
storem $(Turtle)_x
push 0
storem $(Turtle)_y
push 7
storem $(Turtle)_low
push 4
storem $(Turtle)_midL
push 15
storem $(Turtle)_mid
push 20
storem $(Turtle)_high
push 400
storem $(Turtle)_midH
push 0
storem $(Turtle)_targetX
push 0
storem $(Turtle)_targetY
push 0
storem $(Turtle)_lineDrawing
push 90
storem $(Turtle)_angle
ret
@~(Turtle)_goto
storem $(Turtle)_y
storem $(Turtle)_x
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
ret
@~(Turtle)_right
loadm $(Turtle)_angle
call @plus
push 360
call @mod
storem $(Turtle)_angle
ret
@~(Turtle)_slope
loadm $(Turtle)_y
loadm $(Turtle)_targetY
call @diff
push 15
call @mul
loadm $(Turtle)_x
loadm $(Turtle)_targetX
call @diff
call @div
ret
@~(Turtle)_notOnTarget
loadm $(Turtle)_y
loadm $(Turtle)_targetY
call @eq
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_1_do_end
pull
push 0
jump :_0_match_end
:_1_do_end
call @dup
push 0
call @eq
loada
testz
clra
jumpf :_2_do_end
pull
loadm $(Turtle)_x
loadm $(Turtle)_targetX
call @eq
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_4_do_end
pull
push 0
jump :_3_match_end
:_4_do_end
call @dup
push 0
call @eq
loada
testz
clra
jumpf :_5_do_end
pull
push 1
jump :_3_match_end
:_5_do_end
pull
:_3_match_end
jump :_0_match_end
:_2_do_end
pull
:_0_match_end
ret
@~(Turtle)_move
loadm $(Turtle)_angle
push 22
call @plus
push 45
call @div
call @dup
push 0
call @eq
loada
testz
clra
jumpf :_7_do_end
pull
push 1
loadm $(Turtle)_y
call @plus
push 2
readelm *size
jumpt :_8_readelm_done
call @__illegal_Array_Index
:_8_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_6_match_end
:_7_do_end
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_9_do_end
pull
push 1
loadm $(Turtle)_x
call @plus
push 1
readelm *size
jumpt :_10_readelm_done
call @__illegal_Array_Index
:_10_readelm_done
call @mod
storem $(Turtle)_x
push 1
loadm $(Turtle)_y
call @plus
push 2
readelm *size
jumpt :_11_readelm_done
call @__illegal_Array_Index
:_11_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_6_match_end
:_9_do_end
call @dup
push 2
call @eq
loada
testz
clra
jumpf :_12_do_end
pull
push 1
loadm $(Turtle)_x
call @plus
push 1
readelm *size
jumpt :_13_readelm_done
call @__illegal_Array_Index
:_13_readelm_done
call @mod
storem $(Turtle)_x
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_6_match_end
:_12_do_end
call @dup
push 3
call @eq
loada
testz
clra
jumpf :_14_do_end
pull
push 1
loadm $(Turtle)_x
call @plus
push 1
readelm *size
jumpt :_15_readelm_done
call @__illegal_Array_Index
:_15_readelm_done
call @mod
storem $(Turtle)_x
push 2
readelm *size
jumpt :_16_readelm_done
call @__illegal_Array_Index
:_16_readelm_done
loadm $(Turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_17_readelm_done
call @__illegal_Array_Index
:_17_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_6_match_end
:_14_do_end
call @dup
push 4
call @eq
loada
testz
clra
jumpf :_18_do_end
pull
push 2
readelm *size
jumpt :_19_readelm_done
call @__illegal_Array_Index
:_19_readelm_done
loadm $(Turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_20_readelm_done
call @__illegal_Array_Index
:_20_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_6_match_end
:_18_do_end
call @dup
push 5
call @eq
loada
testz
clra
jumpf :_21_do_end
pull
push 1
readelm *size
jumpt :_22_readelm_done
call @__illegal_Array_Index
:_22_readelm_done
loadm $(Turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_23_readelm_done
call @__illegal_Array_Index
:_23_readelm_done
call @mod
storem $(Turtle)_x
push 2
readelm *size
jumpt :_24_readelm_done
call @__illegal_Array_Index
:_24_readelm_done
loadm $(Turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_25_readelm_done
call @__illegal_Array_Index
:_25_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_6_match_end
:_21_do_end
call @dup
push 6
call @eq
loada
testz
clra
jumpf :_26_do_end
pull
push 1
readelm *size
jumpt :_27_readelm_done
call @__illegal_Array_Index
:_27_readelm_done
loadm $(Turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_28_readelm_done
call @__illegal_Array_Index
:_28_readelm_done
call @mod
storem $(Turtle)_x
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_6_match_end
:_26_do_end
call @dup
push 7
call @eq
loada
testz
clra
jumpf :_29_do_end
pull
push 1
readelm *size
jumpt :_30_readelm_done
call @__illegal_Array_Index
:_30_readelm_done
loadm $(Turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_31_readelm_done
call @__illegal_Array_Index
:_31_readelm_done
call @mod
storem $(Turtle)_x
push 1
loadm $(Turtle)_y
call @plus
push 2
readelm *size
jumpt :_32_readelm_done
call @__illegal_Array_Index
:_32_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_6_match_end
:_29_do_end
pull
:_6_match_end
ret
@~(Turtle)_dot
storem $(Turtle)_targetY
storem $(Turtle)_targetX
push 0
storem $(Turtle)_lineDrawing
loadm $(Turtle)_targetX
call @dup
loadm $(Turtle)_x
call @gt
loada
testz
clra
jumpf :_34_do_end
pull
loadm $(Turtle)_targetY
call @dup
loadm $(Turtle)_y
call @gt
loada
testz
clra
jumpf :_36_do_end
pull
push 'West\_South'
call @char2prtbuff
call @printbuff
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_high
call @lt
loada
testz
clra
jumpf :_38_do_end
pull
push 180
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_39_do_end
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_midH
call @gt
loada
testz
clra
jumpf :_41_do_end
pull
push 225
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_40_match_end
:_41_do_end
pull
:_40_match_end
:_39_do_end
jump :_37_match_end
:_38_do_end
call @dup
loadm $(Turtle)_low
call @gt
loada
testz
clra
jumpf :_42_do_end
pull
push 270
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_43_do_end
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_midL
call @lt
loada
testz
clra
jumpf :_45_do_end
pull
push 225
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_44_match_end
:_45_do_end
pull
:_44_match_end
:_43_do_end
jump :_37_match_end
:_42_do_end
push 225
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_46_do_end
call @~(Turtle)_slope
call @dup
push 20
call @lt
loada
testz
clra
jumpf :_48_do_end
pull
push 180
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_47_match_end
:_48_do_end
call @dup
push 10
call @gt
loada
testz
clra
jumpf :_49_do_end
pull
push 270
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_47_match_end
:_49_do_end
pull
:_47_match_end
:_46_do_end
pull
:_37_match_end
jump :_35_match_end
:_36_do_end
call @dup
loadm $(Turtle)_y
call @lt
loada
testz
clra
jumpf :_50_do_end
pull
push 'West\_North'
call @char2prtbuff
call @printbuff
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_high
call @lt
loada
testz
clra
jumpf :_52_do_end
pull
push 0
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_53_do_end
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_midH
call @gt
loada
testz
clra
jumpf :_55_do_end
pull
push 315
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_54_match_end
:_55_do_end
pull
:_54_match_end
:_53_do_end
jump :_51_match_end
:_52_do_end
call @dup
loadm $(Turtle)_low
call @gt
loada
testz
clra
jumpf :_56_do_end
pull
push 270
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_57_do_end
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_midL
call @lt
loada
testz
clra
jumpf :_59_do_end
pull
push 315
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_58_match_end
:_59_do_end
pull
:_58_match_end
:_57_do_end
jump :_51_match_end
:_56_do_end
push 315
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_60_do_end
call @~(Turtle)_slope
call @dup
push 20
call @lt
loada
testz
clra
jumpf :_62_do_end
pull
push 0
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_61_match_end
:_62_do_end
call @dup
push 10
call @gt
loada
testz
clra
jumpf :_63_do_end
pull
push 270
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_61_match_end
:_63_do_end
pull
:_61_match_end
:_60_do_end
pull
:_51_match_end
jump :_35_match_end
:_50_do_end
push 270
storem $(Turtle)_angle
call @~(Turtle)_move
pull
:_35_match_end
jump :_33_match_end
:_34_do_end
call @dup
loadm $(Turtle)_x
call @lt
loada
testz
clra
jumpf :_64_do_end
pull
loadm $(Turtle)_targetY
call @dup
loadm $(Turtle)_y
call @gt
loada
testz
clra
jumpf :_66_do_end
pull
push 'East\_South'
call @char2prtbuff
call @printbuff
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_high
call @lt
loada
testz
clra
jumpf :_68_do_end
pull
push 180
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_69_do_end
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_midH
call @gt
loada
testz
clra
jumpf :_71_do_end
pull
push 135
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_70_match_end
:_71_do_end
pull
:_70_match_end
:_69_do_end
jump :_67_match_end
:_68_do_end
call @dup
loadm $(Turtle)_low
call @gt
loada
testz
clra
jumpf :_72_do_end
pull
push 90
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_73_do_end
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_midL
call @lt
loada
testz
clra
jumpf :_75_do_end
pull
push 135
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_74_match_end
:_75_do_end
pull
:_74_match_end
:_73_do_end
jump :_67_match_end
:_72_do_end
push 135
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_76_do_end
call @~(Turtle)_slope
call @dup
push 20
call @lt
loada
testz
clra
jumpf :_78_do_end
pull
push 180
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_77_match_end
:_78_do_end
call @dup
push 10
call @gt
loada
testz
clra
jumpf :_79_do_end
pull
push 90
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_77_match_end
:_79_do_end
pull
:_77_match_end
:_76_do_end
pull
:_67_match_end
jump :_65_match_end
:_66_do_end
call @dup
loadm $(Turtle)_y
call @lt
loada
testz
clra
jumpf :_80_do_end
pull
push 'East\_North'
call @char2prtbuff
call @printbuff
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_high
call @lt
loada
testz
clra
jumpf :_82_do_end
pull
push 0
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_83_do_end
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_midH
call @gt
loada
testz
clra
jumpf :_85_do_end
pull
push 45
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_84_match_end
:_85_do_end
pull
:_84_match_end
:_83_do_end
jump :_81_match_end
:_82_do_end
call @dup
loadm $(Turtle)_low
call @gt
loada
testz
clra
jumpf :_86_do_end
pull
push 90
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_87_do_end
call @~(Turtle)_slope
call @dup
loadm $(Turtle)_midL
call @lt
loada
testz
clra
jumpf :_89_do_end
pull
push 45
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_88_match_end
:_89_do_end
pull
:_88_match_end
:_87_do_end
jump :_81_match_end
:_86_do_end
push 45
storem $(Turtle)_angle
call @~(Turtle)_move
call @~(Turtle)_notOnTarget
loada
testz
clra
jumpf :_90_do_end
call @~(Turtle)_slope
call @dup
push 20
call @lt
loada
testz
clra
jumpf :_92_do_end
pull
push 0
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_91_match_end
:_92_do_end
call @dup
push 10
call @gt
loada
testz
clra
jumpf :_93_do_end
pull
push 90
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_91_match_end
:_93_do_end
pull
:_91_match_end
:_90_do_end
pull
:_81_match_end
jump :_65_match_end
:_80_do_end
push 'East'
call @char2prtbuff
call @printbuff
push 90
storem $(Turtle)_angle
call @~(Turtle)_move
pull
:_65_match_end
jump :_33_match_end
:_64_do_end
loadm $(Turtle)_targetY
call @dup
loadm $(Turtle)_y
call @gt
loada
testz
clra
jumpf :_95_do_end
pull
push 'South'
call @char2prtbuff
call @printbuff
push 180
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_94_match_end
:_95_do_end
call @dup
loadm $(Turtle)_y
call @lt
loada
testz
clra
jumpf :_96_do_end
pull
push 'North'
call @char2prtbuff
call @printbuff
push 0
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_94_match_end
:_96_do_end
push 1
storem $(Turtle)_lineDrawing
pull
:_94_match_end
pull
:_33_match_end
ret
@~(Turtle)_line
storem $tmpY
storem $tmpX
:_97_condition_start
loadm $(Turtle)_lineDrawing
loada
testz
clra
jumpf :_97_repeat_end
loadm $tmpX
loadm $tmpY
call @~(Turtle)_dot
jump :_97_condition_start
:_97_repeat_end
push 0
storem $(Turtle)_lineDrawing
ret
@~(Turtle)_forward
storem $steps
push 0
storem $s
:_98_condition_start
loadm $s
loadm $steps
call @neq
loada
testz
clra
jumpf :_98_repeat_end
call @~(Turtle)_move
loadm $s
push 1
call @plus
storem $s
jump :_98_condition_start
:_98_repeat_end
ret
