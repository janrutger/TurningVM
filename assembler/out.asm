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
jumpt :_6_readelm_done
call @__illegal_Array_Index
:_6_readelm_done
push 2
readelm *size
jumpt :_7_readelm_done
call @__illegal_Array_Index
:_7_readelm_done
call @draw
push 10
call @drawRate
push 0
storem $n
push 5000
storem $max
push 150
push 150
call @~(Turtle)goto
:_8_condition_start
loadm $n
loadm $max
call @gt
loada
testz
clra
jumpf :_8_repeat_end
call @~(Chaos)corner
call @~(Turtle)midway
loadm $n
push 1
call @plus
storem $n
loadm $n
prt
jump :_8_condition_start
:_8_repeat_end
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
call @drawBuff
prttimer 0
ret
# Start of THINGS
@~(Chaos)INIT
push 300
storem $(Chaos)P1x
push 25
storem $(Chaos)P1y
push 134
storem $(Chaos)P2x
push 146
storem $(Chaos)P2y
push 197
storem $(Chaos)P3x
push 342
storem $(Chaos)P3y
push 403
storem $(Chaos)P4x
push 342
storem $(Chaos)P4y
push 466
storem $(Chaos)P5x
push 146
storem $(Chaos)P5y
push 1
storem $(Chaos)cp
ret
@~(Chaos)corner
call @rand
push 4
call @mod
push 1
call @plus
loadm $(Chaos)cp
call @plus
push 5
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
call @dup
push 4
call @eq
loada
testz
clra
jumpf :_5_do_end
pull
loadm $(Chaos)P5x
loadm $(Chaos)P5y
jump :_0_match_end
:_5_do_end
pull
:_0_match_end
ret
@~(Chaos)P1
loadm $(Chaos)P1x
loadm $(Chaos)P1y
ret
@~(Chaos)P2
loadm $(Chaos)P2x
loadm $(Chaos)P2y
ret
@~(Chaos)P3
loadm $(Chaos)P3x
loadm $(Chaos)P3y
ret
@~(Chaos)P4
loadm $(Chaos)P4x
loadm $(Chaos)P4y
ret
@~(Chaos)P5
loadm $(Chaos)P5x
loadm $(Chaos)P5y
ret
@__MemAllocGlobels
call @init_vmachine
array *size
push 640
storem *size
push 320
storem *size
push 0
call @drawRate
ret
