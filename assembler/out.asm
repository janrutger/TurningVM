@main
settimer 0
speed 0
push 0
storem $(turtle)_x
push 0
storem $(turtle)_y
push 0
storem $(turtle)_angle
push 0
push 0
call @draw
push 1
readelm *size
jumpt :_0_readelm_done
call @__illegal_Array_Index
:_0_readelm_done
push 2
readelm *size
jumpt :_1_readelm_done
call @__illegal_Array_Index
:_1_readelm_done
call @draw
call @~(turtle)_move
push 45
call @~(turtle)_right
call @~(turtle)_move
push 45
call @~(turtle)_right
call @~(turtle)_move
push 45
call @~(turtle)_right
call @~(turtle)_move
push 45
call @~(turtle)_right
call @~(turtle)_move
push 45
call @~(turtle)_right
call @~(turtle)_move
push 45
call @~(turtle)_right
call @~(turtle)_move
push 45
call @~(turtle)_right
call @~(turtle)_move
prttimer 0
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
jumpf :_3_do_end
pull
push 1
loadm $(turtle)_y
call @plus
push 2
readelm *size
jumpt :_4_readelm_done
call @__illegal_Array_Index
:_4_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_2_match_end
:_3_do_end
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_5_do_end
pull
push 1
loadm $(turtle)_x
call @plus
push 1
readelm *size
jumpt :_6_readelm_done
call @__illegal_Array_Index
:_6_readelm_done
call @mod
storem $(turtle)_x
push 1
loadm $(turtle)_y
call @plus
push 2
readelm *size
jumpt :_7_readelm_done
call @__illegal_Array_Index
:_7_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_2_match_end
:_5_do_end
call @dup
push 2
call @eq
loada
testz
clra
jumpf :_8_do_end
pull
push 1
loadm $(turtle)_x
call @plus
push 1
readelm *size
jumpt :_9_readelm_done
call @__illegal_Array_Index
:_9_readelm_done
call @mod
storem $(turtle)_x
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_2_match_end
:_8_do_end
call @dup
push 3
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
push 2
readelm *size
jumpt :_12_readelm_done
call @__illegal_Array_Index
:_12_readelm_done
loadm $(turtle)_y
call @plus
push 1
call @minus
push 2
readelm *size
jumpt :_13_readelm_done
call @__illegal_Array_Index
:_13_readelm_done
call @mod
storem $(turtle)_y
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_2_match_end
:_10_do_end
call @dup
push 4
call @eq
loada
testz
clra
jumpf :_14_do_end
pull
push 2
readelm *size
jumpt :_15_readelm_done
call @__illegal_Array_Index
:_15_readelm_done
loadm $(turtle)_y
call @plus
push 1
call @minus
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
jump :_2_match_end
:_14_do_end
call @dup
push 5
call @eq
loada
testz
clra
jumpf :_17_do_end
pull
push 1
readelm *size
jumpt :_18_readelm_done
call @__illegal_Array_Index
:_18_readelm_done
loadm $(turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_19_readelm_done
call @__illegal_Array_Index
:_19_readelm_done
call @mod
storem $(turtle)_x
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
jump :_2_match_end
:_17_do_end
call @dup
push 6
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
loadm $(turtle)_x
loadm $(turtle)_y
call @draw
jump :_2_match_end
:_22_do_end
call @dup
push 7
call @eq
loada
testz
clra
jumpf :_25_do_end
pull
push 1
readelm *size
jumpt :_26_readelm_done
call @__illegal_Array_Index
:_26_readelm_done
loadm $(turtle)_x
call @plus
push 1
call @minus
push 1
readelm *size
jumpt :_27_readelm_done
call @__illegal_Array_Index
:_27_readelm_done
call @mod
storem $(turtle)_x
push 1
loadm $(turtle)_y
call @plus
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
jump :_2_match_end
:_25_do_end
pull
:_2_match_end
ret
@__MemAllocGlobels
array *size
push 160
storem *size
push 80
storem *size
ret
