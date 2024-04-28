@main
settimer 0
speed 0
push 1
readelm *array
jumpt :_0_readelm_done
call @__illegal_Array_Index
:_0_readelm_done
storem $__Ding__n
push 2
readelm *array
jumpt :_1_readelm_done
call @__illegal_Array_Index
:_1_readelm_done
storem $__Ding__m
push 3
storem $m
push 5
push 6
call @mul
prt
call @~__Ding__plus
prttimer 0
ret
@~__Ding__plus
loadm $__Ding__m
loadm $__Ding__n
call @plus
prt
ret
@~__Ding__minus
loadm $__Ding__m
loadm $__Ding__n
call @minus
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
