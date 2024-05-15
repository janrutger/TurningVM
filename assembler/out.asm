@main
settimer 0
speed 0
push 0
call @drawRate
call @drawNew
push 0
push 0
call @draw
push 1
readelm *size
jumpt :_40_readelm_done
call @__illegal_Array_Index
:_40_readelm_done
push 2
readelm *size
jumpt :_41_readelm_done
call @__illegal_Array_Index
:_41_readelm_done
call @draw
push 0
push 0
call @~(Turtle)_goto
loadm $x
readelm *P2
jumpt :_42_readelm_done
call @__illegal_Array_Index
:_42_readelm_done
loadm $y
readelm *P2
jumpt :_43_readelm_done
call @__illegal_Array_Index
:_43_readelm_done
call @~(Turtle)_goto
loadm $x
readelm *P1
jumpt :_44_readelm_done
call @__illegal_Array_Index
:_44_readelm_done
loadm $y
readelm *P1
jumpt :_45_readelm_done
call @__illegal_Array_Index
:_45_readelm_done
call @~(Turtle)_goto
loadm $x
readelm *P2
jumpt :_46_readelm_done
call @__illegal_Array_Index
:_46_readelm_done
loadm $y
readelm *P2
jumpt :_47_readelm_done
call @__illegal_Array_Index
:_47_readelm_done
call @~(Turtle)_line
loadm $x
readelm *P2
jumpt :_48_readelm_done
call @__illegal_Array_Index
:_48_readelm_done
loadm $y
readelm *P2
jumpt :_49_readelm_done
call @__illegal_Array_Index
:_49_readelm_done
call @~(Turtle)_line
loadm $x
readelm *P2
jumpt :_50_readelm_done
call @__illegal_Array_Index
:_50_readelm_done
loadm $y
readelm *P2
jumpt :_51_readelm_done
call @__illegal_Array_Index
:_51_readelm_done
call @~(Turtle)_line
loadm $x
readelm *P2
jumpt :_52_readelm_done
call @__illegal_Array_Index
:_52_readelm_done
loadm $y
readelm *P2
jumpt :_53_readelm_done
call @__illegal_Array_Index
:_53_readelm_done
call @~(Turtle)_line
loadm $x
readelm *P2
jumpt :_54_readelm_done
call @__illegal_Array_Index
:_54_readelm_done
loadm $y
readelm *P2
jumpt :_55_readelm_done
call @__illegal_Array_Index
:_55_readelm_done
call @~(Turtle)_line
loadm $x
readelm *P2
jumpt :_56_readelm_done
call @__illegal_Array_Index
:_56_readelm_done
loadm $y
readelm *P2
jumpt :_57_readelm_done
call @__illegal_Array_Index
:_57_readelm_done
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
loadm $(Turtle)_x
loadm $(Turtle)_targetX
call @diff
call @div
ret
@~(Turtle)_line
storem $(Turtle)_targetY
storem $(Turtle)_targetX
loadm $(Turtle)_targetX
call @dup
loadm $(Turtle)_x
call @gt
loada
testz
clra
jumpf :_1_do_end
pull
loadm $(Turtle)_targetY
call @dup
loadm $(Turtle)_y
call @gt
loada
testz
clra
jumpf :_3_do_end
pull
call @~(Turtle)_slope
prt
loadm $(Turtle)_x
push 1
call @minus
storem $(Turtle)_x
loadm $(Turtle)_y
push 1
call @minus
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_2_match_end
:_3_do_end
call @dup
loadm $(Turtle)_y
call @lt
loada
testz
clra
jumpf :_4_do_end
pull
call @~(Turtle)_slope
prt
loadm $(Turtle)_x
push 1
call @minus
storem $(Turtle)_x
loadm $(Turtle)_y
push 1
call @plus
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_2_match_end
:_4_do_end
loadm $(Turtle)_x
push 1
call @minus
storem $(Turtle)_x
loadm $(Turtle)_y
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
pull
:_2_match_end
jump :_0_match_end
:_1_do_end
call @dup
loadm $(Turtle)_x
call @lt
loada
testz
clra
jumpf :_5_do_end
pull
loadm $(Turtle)_targetY
call @dup
loadm $(Turtle)_y
call @gt
loada
testz
clra
jumpf :_7_do_end
pull
call @~(Turtle)_slope
prt
loadm $(Turtle)_x
push 1
call @plus
storem $(Turtle)_x
loadm $(Turtle)_y
push 1
call @minus
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_6_match_end
:_7_do_end
call @dup
loadm $(Turtle)_y
call @lt
loada
testz
clra
jumpf :_8_do_end
pull
call @~(Turtle)_slope
prt
loadm $(Turtle)_x
push 1
call @plus
storem $(Turtle)_x
loadm $(Turtle)_y
push 1
call @plus
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_6_match_end
:_8_do_end
loadm $(Turtle)_x
push 1
call @plus
storem $(Turtle)_x
loadm $(Turtle)_y
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
pull
:_6_match_end
jump :_0_match_end
:_5_do_end
loadm $(Turtle)_targetY
call @dup
loadm $(Turtle)_y
call @gt
loada
testz
clra
jumpf :_10_do_end
pull
loadm $(Turtle)_x
storem $(Turtle)_x
loadm $(Turtle)_y
push 1
call @minus
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_9_match_end
:_10_do_end
call @dup
loadm $(Turtle)_y
call @lt
loada
testz
clra
jumpf :_11_do_end
pull
loadm $(Turtle)_x
push 1
storem $(Turtle)_x
loadm $(Turtle)_y
push 1
call @plus
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_9_match_end
:_11_do_end
push 'DONE....'
call @char2prtbuff
call @printbuff
pull
:_9_match_end
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
jumpf :_13_do_end
pull
push 1
loadm $(Turtle)_y
call @plus
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
jump :_12_match_end
:_13_do_end
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_15_do_end
pull
push 1
loadm $(Turtle)_x
call @plus
push 1
readelm *size
jumpt :_16_readelm_done
call @__illegal_Array_Index
:_16_readelm_done
call @mod
storem $(Turtle)_x
push 1
loadm $(Turtle)_y
call @plus
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
jump :_12_match_end
:_15_do_end
call @dup
push 2
call @eq
loada
testz
clra
jumpf :_18_do_end
pull
push 1
loadm $(Turtle)_x
call @plus
push 1
readelm *size
jumpt :_19_readelm_done
call @__illegal_Array_Index
:_19_readelm_done
call @mod
storem $(Turtle)_x
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_12_match_end
:_18_do_end
call @dup
push 3
call @eq
loada
testz
clra
jumpf :_20_do_end
pull
push 1
loadm $(Turtle)_x
call @plus
push 1
readelm *size
jumpt :_21_readelm_done
call @__illegal_Array_Index
:_21_readelm_done
call @mod
storem $(Turtle)_x
push 2
readelm *size
jumpt :_22_readelm_done
call @__illegal_Array_Index
:_22_readelm_done
loadm $(Turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_23_readelm_done
call @__illegal_Array_Index
:_23_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_12_match_end
:_20_do_end
call @dup
push 4
call @eq
loada
testz
clra
jumpf :_24_do_end
pull
push 2
readelm *size
jumpt :_25_readelm_done
call @__illegal_Array_Index
:_25_readelm_done
loadm $(Turtle)_y
call @plus
push 1
call @minus
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
jump :_12_match_end
:_24_do_end
call @dup
push 5
call @eq
loada
testz
clra
jumpf :_27_do_end
pull
push 1
readelm *size
jumpt :_28_readelm_done
call @__illegal_Array_Index
:_28_readelm_done
loadm $(Turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_29_readelm_done
call @__illegal_Array_Index
:_29_readelm_done
call @mod
storem $(Turtle)_x
push 2
readelm *size
jumpt :_30_readelm_done
call @__illegal_Array_Index
:_30_readelm_done
loadm $(Turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_31_readelm_done
call @__illegal_Array_Index
:_31_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_12_match_end
:_27_do_end
call @dup
push 6
call @eq
loada
testz
clra
jumpf :_32_do_end
pull
push 1
readelm *size
jumpt :_33_readelm_done
call @__illegal_Array_Index
:_33_readelm_done
loadm $(Turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_34_readelm_done
call @__illegal_Array_Index
:_34_readelm_done
call @mod
storem $(Turtle)_x
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_12_match_end
:_32_do_end
call @dup
push 7
call @eq
loada
testz
clra
jumpf :_35_do_end
pull
push 1
readelm *size
jumpt :_36_readelm_done
call @__illegal_Array_Index
:_36_readelm_done
loadm $(Turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_37_readelm_done
call @__illegal_Array_Index
:_37_readelm_done
call @mod
storem $(Turtle)_x
push 1
loadm $(Turtle)_y
call @plus
push 2
readelm *size
jumpt :_38_readelm_done
call @__illegal_Array_Index
:_38_readelm_done
call @mod
storem $(Turtle)_y
loadm $(Turtle)_x
loadm $(Turtle)_y
call @draw
jump :_12_match_end
:_35_do_end
pull
:_12_match_end
ret
@~(Turtle)_forward
storem $steps
push 0
storem $s
:_39_condition_start
loadm $s
loadm $steps
call @neq
loada
testz
clra
jumpf :_39_repeat_end
call @~(Turtle)_move
loadm $s
push 1
call @plus
storem $s
jump :_39_condition_start
:_39_repeat_end
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
array *P1
push 35
storem *P1
push 30
storem *P1
array *P2
push 40
storem *P2
push 70
storem *P2
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
push 90
storem $(Turtle)_angle
ret
