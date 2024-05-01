@main
settimer 0
speed 0
push 0
storem $(turtle)_x
push 0
storem $(turtle)_y
push 90
storem $(turtle)_angle
push 0
push 0
call @draw
push 1
readelm *size
jumpt :_12_readelm_done
call @__illegal_Array_Index
:_12_readelm_done
push 2
readelm *size
jumpt :_13_readelm_done
call @__illegal_Array_Index
:_13_readelm_done
call @draw
call @~makeNewF
push 'F'
storem *Lresult
push 0
storem $n
call @input
storem $nn
:_42_condition_start
loadm $n
loadm $nn
call @neq
loada
testz
clra
jumpf :_42_repeat_end
call @~Koch
loadm $n
push 1
call @plus
storem $n
jump :_42_condition_start
:_42_repeat_end
loadm *Lresult
prt
push 1
storem $_43_Lresult
:_43_start_each
loadm $_43_Lresult
readelm *Lresult
jumpf :_43_end_each
call @dup
push 'A'
call @eq
loada
testz
clra
jumpf :_45_do_end
pull
push 4
call @~(turtle)_forward
jump :_44_match_end
:_45_do_end
call @dup
push 'B'
call @eq
loada
testz
clra
jumpf :_46_do_end
pull
push 315
call @~(turtle)_right
push 1
call @~(turtle)_forward
jump :_44_match_end
:_46_do_end
call @dup
push 'F'
call @eq
loada
testz
clra
jumpf :_47_do_end
pull
push 2
call @~(turtle)_forward
jump :_44_match_end
:_47_do_end
call @dup
push '+'
call @eq
loada
testz
clra
jumpf :_48_do_end
pull
push 270
call @~(turtle)_right
jump :_44_match_end
:_48_do_end
call @dup
push '-'
call @eq
loada
testz
clra
jumpf :_49_do_end
pull
push 90
call @~(turtle)_right
jump :_44_match_end
:_49_do_end
:_44_match_end
loadm $_43_Lresult
loadb
incb
moveb
storem $_43_Lresult
jump :_43_start_each
:_43_end_each
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
@~Algae
push 1
storem $_0_Lresult
:_0_start_each
loadm $_0_Lresult
readelm *Lresult
jumpf :_0_end_each
call @dup
push 'A'
call @eq
loada
testz
clra
jumpf :_2_do_end
pull
push 'A'
storem *Ltemp
push 'B'
storem *Ltemp
jump :_1_match_end
:_2_do_end
call @dup
push 'B'
call @eq
loada
testz
clra
jumpf :_3_do_end
pull
push 'A'
storem *Ltemp
jump :_1_match_end
:_3_do_end
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
storem $_4_Ltemp
:_4_start_copy
loadm $_4_Ltemp
readelm *Ltemp
jumpf :_4_end_copy
storem *Lresult
loadm $_4_Ltemp
loadb
incb
moveb
storem $_4_Ltemp
jump :_4_start_copy
:_4_end_copy
array *Ltemp
ret
@~Koch
push 1
storem $_5_Lresult
:_5_start_each
loadm $_5_Lresult
readelm *Lresult
jumpf :_5_end_each
call @dup
push 'F'
call @eq
loada
testz
clra
jumpf :_7_do_end
pull
push 1
storem $_8_newF
:_8_start_copy
loadm $_8_newF
readelm *newF
jumpf :_8_end_copy
storem *Ltemp
loadm $_8_newF
loadb
incb
moveb
storem $_8_newF
jump :_8_start_copy
:_8_end_copy
jump :_6_match_end
:_7_do_end
call @dup
push '+'
call @eq
loada
testz
clra
jumpf :_9_do_end
pull
push '+'
storem *Ltemp
jump :_6_match_end
:_9_do_end
call @dup
push '-'
call @eq
loada
testz
clra
jumpf :_10_do_end
pull
push '-'
storem *Ltemp
jump :_6_match_end
:_10_do_end
:_6_match_end
loadm $_5_Lresult
loadb
incb
moveb
storem $_5_Lresult
jump :_5_start_each
:_5_end_each
array *Lresult
push 1
storem $_11_Ltemp
:_11_start_copy
loadm $_11_Ltemp
readelm *Ltemp
jumpf :_11_end_copy
storem *Lresult
loadm $_11_Ltemp
loadb
incb
moveb
storem $_11_Ltemp
jump :_11_start_copy
:_11_end_copy
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
push 360
call @mod
push 45
call @div
call @dup
push 0
call @eq
loada
testz
clra
jumpf :_15_do_end
pull
push 1
loadm $(turtle)_y
call @plus
push 2
readelm *size
jumpt :_16_readelm_done
call @__illegal_Array_Index
:_16_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_14_match_end
:_15_do_end
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_17_do_end
pull
push 1
loadm $(turtle)_x
call @plus
push 1
readelm *size
jumpt :_18_readelm_done
call @__illegal_Array_Index
:_18_readelm_done
call @mod
storem $(turtle)_x
push 1
loadm $(turtle)_y
call @plus
push 2
readelm *size
jumpt :_19_readelm_done
call @__illegal_Array_Index
:_19_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_14_match_end
:_17_do_end
call @dup
push 2
call @eq
loada
testz
clra
jumpf :_20_do_end
pull
push 1
loadm $(turtle)_x
call @plus
push 1
readelm *size
jumpt :_21_readelm_done
call @__illegal_Array_Index
:_21_readelm_done
call @mod
storem $(turtle)_x
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_14_match_end
:_20_do_end
call @dup
push 3
call @eq
loada
testz
clra
jumpf :_22_do_end
pull
push 1
loadm $(turtle)_x
call @plus
push 1
readelm *size
jumpt :_23_readelm_done
call @__illegal_Array_Index
:_23_readelm_done
call @mod
storem $(turtle)_x
push 2
readelm *size
jumpt :_24_readelm_done
call @__illegal_Array_Index
:_24_readelm_done
loadm $(turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_25_readelm_done
call @__illegal_Array_Index
:_25_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_14_match_end
:_22_do_end
call @dup
push 4
call @eq
loada
testz
clra
jumpf :_26_do_end
pull
push 2
readelm *size
jumpt :_27_readelm_done
call @__illegal_Array_Index
:_27_readelm_done
loadm $(turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_28_readelm_done
call @__illegal_Array_Index
:_28_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_14_match_end
:_26_do_end
call @dup
push 5
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
loadm $(turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_31_readelm_done
call @__illegal_Array_Index
:_31_readelm_done
call @mod
storem $(turtle)_x
push 2
readelm *size
jumpt :_32_readelm_done
call @__illegal_Array_Index
:_32_readelm_done
loadm $(turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_33_readelm_done
call @__illegal_Array_Index
:_33_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_14_match_end
:_29_do_end
call @dup
push 6
call @eq
loada
testz
clra
jumpf :_34_do_end
pull
push 1
readelm *size
jumpt :_35_readelm_done
call @__illegal_Array_Index
:_35_readelm_done
loadm $(turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_36_readelm_done
call @__illegal_Array_Index
:_36_readelm_done
call @mod
storem $(turtle)_x
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_14_match_end
:_34_do_end
call @dup
push 7
call @eq
loada
testz
clra
jumpf :_37_do_end
pull
push 1
readelm *size
jumpt :_38_readelm_done
call @__illegal_Array_Index
:_38_readelm_done
loadm $(turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_39_readelm_done
call @__illegal_Array_Index
:_39_readelm_done
call @mod
storem $(turtle)_x
push 1
loadm $(turtle)_y
call @plus
push 2
readelm *size
jumpt :_40_readelm_done
call @__illegal_Array_Index
:_40_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_14_match_end
:_37_do_end
:_14_match_end
ret
@~(turtle)_forward
storem $steps
push 0
storem $s
:_41_condition_start
loadm $s
loadm $steps
call @neq
loada
testz
clra
jumpf :_41_repeat_end
call @~(turtle)_move
loadm $s
push 1
call @plus
storem $s
jump :_41_condition_start
:_41_repeat_end
ret
@__MemAllocGlobels
array *size
push 160
storem *size
push 80
storem *size
array *Lresult
array *Ltemp
array *newF
ret
