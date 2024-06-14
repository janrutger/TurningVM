@main
settimer 0
speed 0
call @~(Turtle)INIT
call @~(Chaos)INIT
call @drawNew
push 0
push 0
call @draw
push 1
readelm *size
jumpt :_5_readelm_done
call @__illegal_Array_Index
:_5_readelm_done
push 2
readelm *size
jumpt :_6_readelm_done
call @__illegal_Array_Index
:_6_readelm_done
call @draw
push 120
call @drawRate
push 0
storem $n
push 70
push 70
call @mul
storem $max
array *cursor
push 30
storem *cursor
push 65
storem *cursor
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
call @~(Turtle)goto
:_9_condition_start
loadm $n
loadm $max
call @gt
loada
testz
clra
jumpf :_9_repeat_end
call @~(Chaos)corner
call @~(Turtle)midway
loadm $n
push 1
call @plus
storem $n
jump :_9_condition_start
:_9_repeat_end
call @drawBuff
prttimer 0
ret
# Start of THINGS
@~(Chaos)INIT
push 0
storem $(Chaos)P1x
push 0
storem $(Chaos)P1y
push 0
storem $(Chaos)P2x
push 70
storem $(Chaos)P2y
push 70
storem $(Chaos)P3x
push 70
storem $(Chaos)P3y
push 70
storem $(Chaos)P4x
push 0
storem $(Chaos)P4y
push 1
storem $(Chaos)cp
ret
@~(Chaos)corner
call @rand
push 3
call @mod
loadm $(Chaos)cp
call @plus
push 4
call @mod
push 1
call @plus
storem $(Chaos)cp
loadm $(Chaos)cp
call @dup
push 0
call @eq
loada
testz
clra
jumpf :_1_do_end
pull
loadm $(Chaos)P1x
loadm $(Chaos)P1y
jump :_0_match_end
:_1_do_end
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_2_do_end
pull
loadm $(Chaos)P2x
loadm $(Chaos)P2y
jump :_0_match_end
:_2_do_end
call @dup
push 2
call @eq
loada
testz
clra
jumpf :_3_do_end
pull
loadm $(Chaos)P3x
loadm $(Chaos)P3y
jump :_0_match_end
:_3_do_end
call @dup
push 3
call @eq
loada
testz
clra
jumpf :_4_do_end
pull
loadm $(Chaos)P4x
loadm $(Chaos)P4y
jump :_0_match_end
:_4_do_end
pull
:_0_match_end
ret
@__MemAllocGlobels
call @init_vmachine
array *size
push 160
storem *size
push 80
storem *size
push 0
call @drawRate
ret
