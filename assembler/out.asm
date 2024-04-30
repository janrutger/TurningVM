@main
settimer 0
speed 0
push 1
readelm *array
jumpt :_0_readelm_done
call @__illegal_Array_Index
:_0_readelm_done
storem $(Ding)_n
push 2
readelm *array
jumpt :_1_readelm_done
call @__illegal_Array_Index
:_1_readelm_done
storem $(Ding)_m
push 3
storem $m
push 5
push 6
call @mul
loadm $m
call @minus
prt
call @~(Ding)_plus
call @~(Ding)_multi
call @~(Ding)_minus
prt
call @input
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_3_do_end
prt
jump :_2_match_end
:_3_do_end
call @dup
push 2
call @gt
loada
testz
clra
jumpf :_4_do_end
prt
jump :_2_match_end
:_4_do_end
pull
push 0
prt
jump :_2_match_end
pull
:_2_match_end
call @input
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_6_do_end
prt
jump :_5_match_end
:_6_do_end
pull
:_5_match_end
prttimer 0
ret
@~(Ding)_plus
loadm $(Ding)_m
loadm $(Ding)_n
call @plus
prt
ret
@~(Ding)_minus
loadm $(Ding)_m
loadm $(Ding)_n
call @minus
ret
@~(Ding)_multi
call @~(Ding)_minus
call @~(Ding)_minus
call @mul
prt
ret
@__MemAllocGlobels
array *array
push 3
storem *array
push 5
storem *array
push 9
storem *array
ret
