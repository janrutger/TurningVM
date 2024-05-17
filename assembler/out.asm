@main
settimer 0
speed 0
array *P1
push 15
storem *P1
push 57
storem *P1
array *P2
push 30
storem *P2
push 10
storem *P2
push 0
call @drawRate
call @drawNew
push 0
push 0
call @draw
push 1
readelm *size
jumpt :_53_readelm_done
call @__illegal_Array_Index
:_53_readelm_done
push 2
readelm *size
jumpt :_54_readelm_done
call @__illegal_Array_Index
:_54_readelm_done
call @draw
push 0
push 0
call @~(Turtle)_goto
loadm $x
readelm *P2
jumpt :_55_readelm_done
call @__illegal_Array_Index
:_55_readelm_done
loadm $y
readelm *P2
jumpt :_56_readelm_done
call @__illegal_Array_Index
:_56_readelm_done
call @~(Turtle)_goto
loadm $x
readelm *P1
jumpt :_57_readelm_done
call @__illegal_Array_Index
:_57_readelm_done
loadm $y
readelm *P1
jumpt :_58_readelm_done
call @__illegal_Array_Index
:_58_readelm_done
call @~(Turtle)_goto
call @drawBuff
loadm $x
readelm *P2
jumpt :_59_readelm_done
call @__illegal_Array_Index
:_59_readelm_done
loadm $y
readelm *P2
jumpt :_60_readelm_done
call @__illegal_Array_Index
:_60_readelm_done
call @~(Turtle)_line
call @drawBuff
prttimer 0
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
call @dup
prt
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
jumpf :_1_do_end
pull
push 1
loadm $(Turtle)_y
call @plus
push 2
readelm *size
jumpt :_2_readelm_done
call @__illegal_Array_Index
:_2_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_0_match_end
:_1_do_end
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_3_do_end
pull
push 1
loadm $(Turtle)_x
call @plus
push 1
readelm *size
jumpt :_4_readelm_done
call @__illegal_Array_Index
:_4_readelm_done
call @mod
storem $(Turtle)_x
push 1
loadm $(Turtle)_y
call @plus
push 2
readelm *size
jumpt :_5_readelm_done
call @__illegal_Array_Index
:_5_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_0_match_end
:_3_do_end
call @dup
push 2
call @eq
loada
testz
clra
jumpf :_6_do_end
pull
push 1
loadm $(Turtle)_x
call @plus
push 1
readelm *size
jumpt :_7_readelm_done
call @__illegal_Array_Index
:_7_readelm_done
call @mod
storem $(Turtle)_x
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_0_match_end
:_6_do_end
call @dup
push 3
call @eq
loada
testz
clra
jumpf :_8_do_end
pull
push 1
loadm $(Turtle)_x
call @plus
push 1
readelm *size
jumpt :_9_readelm_done
call @__illegal_Array_Index
:_9_readelm_done
call @mod
storem $(Turtle)_x
push 2
readelm *size
jumpt :_10_readelm_done
call @__illegal_Array_Index
:_10_readelm_done
loadm $(Turtle)_y
call @plus
push 1
call @minus
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
jump :_0_match_end
:_8_do_end
call @dup
push 4
call @eq
loada
testz
clra
jumpf :_12_do_end
pull
push 2
readelm *size
jumpt :_13_readelm_done
call @__illegal_Array_Index
:_13_readelm_done
loadm $(Turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_14_readelm_done
call @__illegal_Array_Index
:_14_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_0_match_end
:_12_do_end
call @dup
push 5
call @eq
loada
testz
clra
jumpf :_15_do_end
pull
push 1
readelm *size
jumpt :_16_readelm_done
call @__illegal_Array_Index
:_16_readelm_done
loadm $(Turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_17_readelm_done
call @__illegal_Array_Index
:_17_readelm_done
call @mod
storem $(Turtle)_x
push 2
readelm *size
jumpt :_18_readelm_done
call @__illegal_Array_Index
:_18_readelm_done
loadm $(Turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_19_readelm_done
call @__illegal_Array_Index
:_19_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_0_match_end
:_15_do_end
call @dup
push 6
call @eq
loada
testz
clra
jumpf :_20_do_end
pull
push 1
readelm *size
jumpt :_21_readelm_done
call @__illegal_Array_Index
:_21_readelm_done
loadm $(Turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_22_readelm_done
call @__illegal_Array_Index
:_22_readelm_done
call @mod
storem $(Turtle)_x
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_0_match_end
:_20_do_end
call @dup
push 7
call @eq
loada
testz
clra
jumpf :_23_do_end
pull
push 1
readelm *size
jumpt :_24_readelm_done
call @__illegal_Array_Index
:_24_readelm_done
loadm $(Turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_25_readelm_done
call @__illegal_Array_Index
:_25_readelm_done
call @mod
storem $(Turtle)_x
push 1
loadm $(Turtle)_y
call @plus
push 2
readelm *size
jumpt :_26_readelm_done
call @__illegal_Array_Index
:_26_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_0_match_end
:_23_do_end
pull
:_0_match_end
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
jumpf :_28_do_end
pull
loadm $(Turtle)_targetY
call @dup
loadm $(Turtle)_y
call @gt
loada
testz
clra
jumpf :_30_do_end
pull
push 'West\_South'
call @char2prtbuff
call @printbuff
call @~(Turtle)_slope
call @dup
push 100
call @lt
loada
testz
clra
jumpf :_32_do_end
pull
push 180
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_31_match_end
:_32_do_end
call @dup
push 5
call @gt
loada
testz
clra
jumpf :_33_do_end
pull
push 270
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_31_match_end
:_33_do_end
push 225
storem $(Turtle)_angle
call @~(Turtle)_move
pull
:_31_match_end
jump :_29_match_end
:_30_do_end
call @dup
loadm $(Turtle)_y
call @lt
loada
testz
clra
jumpf :_34_do_end
pull
push 'West\_North'
call @char2prtbuff
call @printbuff
call @~(Turtle)_slope
call @dup
push 100
call @lt
loada
testz
clra
jumpf :_36_do_end
pull
push 270
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_35_match_end
:_36_do_end
call @dup
push 5
call @gt
loada
testz
clra
jumpf :_37_do_end
pull
push 0
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_35_match_end
:_37_do_end
push 315
storem $(Turtle)_angle
call @~(Turtle)_move
pull
:_35_match_end
jump :_29_match_end
:_34_do_end
push 270
storem $(Turtle)_angle
call @~(Turtle)_move
pull
:_29_match_end
jump :_27_match_end
:_28_do_end
call @dup
loadm $(Turtle)_x
call @lt
loada
testz
clra
jumpf :_38_do_end
pull
loadm $(Turtle)_targetY
call @dup
loadm $(Turtle)_y
call @gt
loada
testz
clra
jumpf :_40_do_end
pull
push 'East\_South'
call @char2prtbuff
call @printbuff
call @~(Turtle)_slope
call @dup
push 100
call @lt
loada
testz
clra
jumpf :_42_do_end
pull
push 180
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_41_match_end
:_42_do_end
call @dup
push 5
call @gt
loada
testz
clra
jumpf :_43_do_end
pull
push 90
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_41_match_end
:_43_do_end
push 135
storem $(Turtle)_angle
call @~(Turtle)_move
pull
:_41_match_end
jump :_39_match_end
:_40_do_end
call @dup
loadm $(Turtle)_y
call @lt
loada
testz
clra
jumpf :_44_do_end
pull
push 'East\_North'
call @char2prtbuff
call @printbuff
call @~(Turtle)_slope
call @dup
push 100
call @lt
loada
testz
clra
jumpf :_46_do_end
pull
push 0
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_45_match_end
:_46_do_end
call @dup
push 5
call @gt
loada
testz
clra
jumpf :_47_do_end
pull
push 90
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_45_match_end
:_47_do_end
push 45
storem $(Turtle)_angle
call @~(Turtle)_move
pull
:_45_match_end
jump :_39_match_end
:_44_do_end
push 'East'
call @char2prtbuff
call @printbuff
push 90
storem $(Turtle)_angle
call @~(Turtle)_move
pull
:_39_match_end
jump :_27_match_end
:_38_do_end
loadm $(Turtle)_targetY
call @dup
loadm $(Turtle)_y
call @gt
loada
testz
clra
jumpf :_49_do_end
pull
push 180
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_48_match_end
:_49_do_end
call @dup
loadm $(Turtle)_y
call @lt
loada
testz
clra
jumpf :_50_do_end
pull
push 0
storem $(Turtle)_angle
call @~(Turtle)_move
jump :_48_match_end
:_50_do_end
push 'DONE....'
call @char2prtbuff
call @printbuff
push 1
storem $(Turtle)_lineDrawing
pull
:_48_match_end
pull
:_27_match_end
ret
@~(Turtle)_line
storem $tmpY
storem $tmpX
:_51_condition_start
loadm $(Turtle)_lineDrawing
loada
testz
clra
jumpf :_51_repeat_end
loadm $tmpX
loadm $tmpY
call @~(Turtle)_dot
jump :_51_condition_start
:_51_repeat_end
push 0
storem $(Turtle)_lineDrawing
ret
@~(Turtle)_forward
storem $steps
push 0
storem $s
:_52_condition_start
loadm $s
loadm $steps
call @neq
loada
testz
clra
jumpf :_52_repeat_end
call @~(Turtle)_move
loadm $s
push 1
call @plus
storem $s
jump :_52_condition_start
:_52_repeat_end
ret
@__MemAllocGlobels
call @init_vmachine
array *size
push 160
storem *size
push 80
storem *size
push 0
storem $x
push 1
storem $x
push 0
storem $y
push 2
storem $y
push 0
call @drawRate
push 0
storem $(Turtle)_x
push 0
storem $(Turtle)_y
push 0
storem $(Turtle)_targetX
push 0
storem $(Turtle)_targetY
push 0
storem $(Turtle)_lineDrawing
push 90
storem $(Turtle)_angle
ret
