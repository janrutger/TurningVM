@main
settimer 0
speed 0
push 99
call @drawRate
call @~grid
:loop
call @input
storem $gridpoint
loadm $gridpoint
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_12_do_end
pull
push 12
push 12
call @~circle
jump :_11_match_end
:_12_do_end
call @dup
push 2
call @eq
loada
testz
clra
jumpf :_13_do_end
pull
push 37
push 12
call @~cross
jump :_11_match_end
:_13_do_end
call @dup
push 3
call @eq
loada
testz
clra
jumpf :_14_do_end
pull
push 62
push 12
call @~circle
jump :_11_match_end
:_14_do_end
call @dup
push 4
call @eq
loada
testz
clra
jumpf :_15_do_end
pull
push 12
push 37
call @~cross
jump :_11_match_end
:_15_do_end
call @dup
push 5
call @eq
loada
testz
clra
jumpf :_16_do_end
pull
push 37
push 37
call @~circle
jump :_11_match_end
:_16_do_end
call @dup
push 6
call @eq
loada
testz
clra
jumpf :_17_do_end
pull
push 62
push 37
call @~cross
jump :_11_match_end
:_17_do_end
call @dup
push 7
call @eq
loada
testz
clra
jumpf :_18_do_end
pull
push 12
push 62
call @~circle
jump :_11_match_end
:_18_do_end
call @dup
push 8
call @eq
loada
testz
clra
jumpf :_19_do_end
pull
push 37
push 62
call @~cross
jump :_11_match_end
:_19_do_end
call @dup
push 9
call @eq
loada
testz
clra
jumpf :_20_do_end
pull
push 62
push 62
call @~circle
jump :_11_match_end
:_20_do_end
call @dup
push 0
call @eq
loada
testz
clra
jumpf :_21_do_end
pull
jump :done
jump :_11_match_end
:_21_do_end
pull
:_11_match_end
jump :loop
:done
call @drawBuff
prttimer 0
ret
@~circle
push 0
storem $start
call @~(Turtle)goto
:_0_condition_start
loadm $start
push 360
call @gt
loada
testz
clra
jumpf :_0_repeat_end
call @~(Turtle)move
push 45
call @~(Turtle)right
call @~(Turtle)move
loadm $start
push 45
call @plus
storem $start
jump :_0_condition_start
:_0_repeat_end
call @drawBuff
ret
@~cross
array *cursor
call @swap
storem *cursor
storem *cursor
push 1
readelm *cursor
jumpt :_1_readelm_done
call @__illegal_Array_Index
:_1_readelm_done
push 2
readelm *cursor
jumpt :_2_readelm_done
call @__illegal_Array_Index
:_2_readelm_done
call @~(Turtle)goto
push 1
readelm *cursor
jumpt :_3_readelm_done
call @__illegal_Array_Index
:_3_readelm_done
push 5
call @plus
push 2
readelm *cursor
jumpt :_4_readelm_done
call @__illegal_Array_Index
:_4_readelm_done
push 5
call @minus
call @~(Turtle)line
push 1
readelm *cursor
jumpt :_5_readelm_done
call @__illegal_Array_Index
:_5_readelm_done
push 5
call @plus
push 2
readelm *cursor
jumpt :_6_readelm_done
call @__illegal_Array_Index
:_6_readelm_done
call @~(Turtle)goto
push 1
readelm *cursor
jumpt :_7_readelm_done
call @__illegal_Array_Index
:_7_readelm_done
push 2
readelm *cursor
jumpt :_8_readelm_done
call @__illegal_Array_Index
:_8_readelm_done
push 5
call @minus
call @~(Turtle)line
call @drawBuff
ret
@~grid
call @drawNew
push 0
push 0
call @draw
push 1
readelm *size
jumpt :_9_readelm_done
call @__illegal_Array_Index
:_9_readelm_done
push 2
readelm *size
jumpt :_10_readelm_done
call @__illegal_Array_Index
:_10_readelm_done
call @draw
push 5
push 25
call @~(Turtle)goto
push 75
push 25
call @~(Turtle)line
push 25
push 5
call @~(Turtle)goto
push 25
push 75
call @~(Turtle)line
push 5
push 50
call @~(Turtle)goto
push 75
push 50
call @~(Turtle)line
push 50
push 5
call @~(Turtle)goto
push 50
push 75
call @~(Turtle)line
call @drawBuff
ret
@__MemAllocGlobels
call @init_vmachine
array *size
push 160
storem *size
push 80
storem *size
call @~(Turtle)INIT
push 0
call @drawRate
ret
