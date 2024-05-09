@main
settimer 0
speed 0
array *Lresult
push 'F'
storem *Lresult
call @drawNew
push 0
push 0
call @draw
push 1
readelm *size
jumpt :_35_readelm_done
call @__illegal_Array_Index
:_35_readelm_done
push 2
readelm *size
jumpt :_36_readelm_done
call @__illegal_Array_Index
:_36_readelm_done
call @draw
push 0
push 0
call @~(turtle)_goto
loadm *newF
push 0
call @eq
loada
testz
clra
jumpf :_37_do_end
call @~makeNewF
:_37_do_end
push 0
storem $n
call @input
storem $nn
:_38_condition_start
loadm $n
loadm $nn
call @neq
loada
testz
clra
jumpf :_38_repeat_end
call @~Koch
loadm $n
push 1
call @plus
storem $n
jump :_38_condition_start
:_38_repeat_end
loadm *Lresult
prt
push 1
storem $_39_Lresult
:_39_start_each
loadm $_39_Lresult
readelm *Lresult
jumpf :_39_end_each
call @dup
push 'F'
call @eq
loada
testz
clra
jumpf :_41_do_end
pull
push 4
call @~(turtle)_forward
jump :_40_match_end
:_41_do_end
call @dup
push '+'
call @eq
loada
testz
clra
jumpf :_42_do_end
pull
push 270
call @~(turtle)_right
jump :_40_match_end
:_42_do_end
call @dup
push '-'
call @eq
loada
testz
clra
jumpf :_43_do_end
pull
push 90
call @~(turtle)_right
jump :_40_match_end
:_43_do_end
pull
:_40_match_end
loadm $_39_Lresult
loadb
incb
moveb
storem $_39_Lresult
jump :_39_start_each
:_39_end_each
call @drawBuff
prttimer 0
ret
@~makeNewF
push 'F'
storem *newF
push '+'
storem *newF
push 'F'
storem *newF
push '-'
storem *newF
push 'F'
storem *newF
push '-'
storem *newF
push 'F'
storem *newF
push '+'
storem *newF
push 'F'
storem *newF
ret
@~Koch
push 1
storem $_0_Lresult
:_0_start_each
loadm $_0_Lresult
readelm *Lresult
jumpf :_0_end_each
call @dup
push 'F'
call @eq
loada
testz
clra
jumpf :_2_do_end
pull
push 1
storem $_3_newF
:_3_start_copy
loadm $_3_newF
readelm *newF
jumpf :_3_end_copy
storem *Ltemp
loadm $_3_newF
loadb
incb
moveb
storem $_3_newF
jump :_3_start_copy
:_3_end_copy
jump :_1_match_end
:_2_do_end
call @dup
push '+'
call @eq
loada
testz
clra
jumpf :_4_do_end
pull
push '+'
storem *Ltemp
jump :_1_match_end
:_4_do_end
call @dup
push '-'
call @eq
loada
testz
clra
jumpf :_5_do_end
pull
push '-'
storem *Ltemp
jump :_1_match_end
:_5_do_end
pull
:_1_match_end
loadm $_0_Lresult
loadb
incb
moveb
storem $_0_Lresult
jump :_0_start_each
:_0_end_each
array *Lresult
push 1
storem $_6_Ltemp
:_6_start_copy
loadm $_6_Ltemp
readelm *Ltemp
jumpf :_6_end_copy
storem *Lresult
loadm $_6_Ltemp
loadb
incb
moveb
storem $_6_Ltemp
jump :_6_start_copy
:_6_end_copy
array *Ltemp
ret
@~(turtle)_goto
storem $(turtle)_y
storem $(turtle)_x
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
ret
@~(turtle)_right
loadm $(turtle)_angle
call @plus
push 360
call @mod
storem $(turtle)_angle
ret
@~(turtle)_move
loadm $(turtle)_angle
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
jumpf :_8_do_end
pull
push 1
loadm $(turtle)_y
call @plus
push 2
readelm *size
jumpt :_9_readelm_done
call @__illegal_Array_Index
:_9_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_7_match_end
:_8_do_end
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_10_do_end
pull
push 1
loadm $(turtle)_x
call @plus
push 1
readelm *size
jumpt :_11_readelm_done
call @__illegal_Array_Index
:_11_readelm_done
call @mod
storem $(turtle)_x
push 1
loadm $(turtle)_y
call @plus
push 2
readelm *size
jumpt :_12_readelm_done
call @__illegal_Array_Index
:_12_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_7_match_end
:_10_do_end
call @dup
push 2
call @eq
loada
testz
clra
jumpf :_13_do_end
pull
push 1
loadm $(turtle)_x
call @plus
push 1
readelm *size
jumpt :_14_readelm_done
call @__illegal_Array_Index
:_14_readelm_done
call @mod
storem $(turtle)_x
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_7_match_end
:_13_do_end
call @dup
push 3
call @eq
loada
testz
clra
jumpf :_15_do_end
pull
push 1
loadm $(turtle)_x
call @plus
push 1
readelm *size
jumpt :_16_readelm_done
call @__illegal_Array_Index
:_16_readelm_done
call @mod
storem $(turtle)_x
push 2
readelm *size
jumpt :_17_readelm_done
call @__illegal_Array_Index
:_17_readelm_done
loadm $(turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_18_readelm_done
call @__illegal_Array_Index
:_18_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_7_match_end
:_15_do_end
call @dup
push 4
call @eq
loada
testz
clra
jumpf :_19_do_end
pull
push 2
readelm *size
jumpt :_20_readelm_done
call @__illegal_Array_Index
:_20_readelm_done
loadm $(turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_21_readelm_done
call @__illegal_Array_Index
:_21_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_7_match_end
:_19_do_end
call @dup
push 5
call @eq
loada
testz
clra
jumpf :_22_do_end
pull
push 1
readelm *size
jumpt :_23_readelm_done
call @__illegal_Array_Index
:_23_readelm_done
loadm $(turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_24_readelm_done
call @__illegal_Array_Index
:_24_readelm_done
call @mod
storem $(turtle)_x
push 2
readelm *size
jumpt :_25_readelm_done
call @__illegal_Array_Index
:_25_readelm_done
loadm $(turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_26_readelm_done
call @__illegal_Array_Index
:_26_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_7_match_end
:_22_do_end
call @dup
push 6
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
loadm $(turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_29_readelm_done
call @__illegal_Array_Index
:_29_readelm_done
call @mod
storem $(turtle)_x
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_7_match_end
:_27_do_end
call @dup
push 7
call @eq
loada
testz
clra
jumpf :_30_do_end
pull
push 1
readelm *size
jumpt :_31_readelm_done
call @__illegal_Array_Index
:_31_readelm_done
loadm $(turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_32_readelm_done
call @__illegal_Array_Index
:_32_readelm_done
call @mod
storem $(turtle)_x
push 1
loadm $(turtle)_y
call @plus
push 2
readelm *size
jumpt :_33_readelm_done
call @__illegal_Array_Index
:_33_readelm_done
call @mod
storem $(turtle)_y
jump :_7_match_end
:_30_do_end
pull
:_7_match_end
ret
@~(turtle)_forward
storem $steps
push 0
storem $s
:_34_condition_start
loadm $s
loadm $steps
call @neq
loada
testz
clra
jumpf :_34_repeat_end
call @~(turtle)_move
loadm $s
push 1
call @plus
storem $s
jump :_34_condition_start
:_34_repeat_end
ret
@__MemAllocGlobels
call @init_vmachine
push 0
storem $Ltime
push 0
storem $Ltime
array *size
push 160
storem *size
push 80
storem *size
array *Lresult
array *Ltemp
array *newF
push 0
call @drawRate
push 0
storem $(turtle)_x
push 0
storem $(turtle)_y
push 90
storem $(turtle)_angle
ret
