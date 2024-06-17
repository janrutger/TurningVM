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
jumpt :_4_readelm_done
call @__illegal_Array_Index
:_4_readelm_done
push 2
readelm *size
jumpt :_5_readelm_done
call @__illegal_Array_Index
:_5_readelm_done
call @draw
push 5
call @drawRate
push 0
storem $n
push 70
push 70
call @mul
storem $max
push 30
push 65
call @~(Turtle)goto
:_6_condition_start
loadm $n
loadm $max
call @gt
loada
testz
clra
jumpf :_6_repeat_end
call @~(Chaos)corner
call @~(Turtle)midway
loadm $n
push 1
call @plus
storem $n
jump :_6_condition_start
:_6_repeat_end
push 0
push 0
call @draw
push 1
readelm *size
jumpt :_7_readelm_done
call @__illegal_Array_Index
:_7_readelm_done
push 2
readelm *size
jumpt :_8_readelm_done
call @__illegal_Array_Index
:_8_readelm_done
call @draw
call @drawBuff
prttimer 0
ret
# Start of THINGS
@~(Chaos)INIT
push 0
storem $(Chaos)P1x
push 0
storem $(Chaos)P1y
push 31
storem $(Chaos)P2x
push 60
storem $(Chaos)P2y
push 61
storem $(Chaos)P3x
push 0
storem $(Chaos)P3y
push 1
storem $(Chaos)cp
ret
@~(Chaos)corner
call @rand
push 2
call @mod
push 1
call @plus
loadm $(Chaos)cp
call @plus
push 3
call @mod
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
