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
call @~(Ding)_minus
prt
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
@__MemAllocGlobels
array *array
push 3
storem *array
push 5
storem *array
push 9
storem *array
ret
