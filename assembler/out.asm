@main
settimer 0
speed 0
push 0
storem $start
push 10
storem $size
loadm $size
storem $end
push 400
storem $count
:_4_condition_start
loadm $count
push 0
call @neq
loada
testz
clra
jumpf :_4_repeat_end
array *block
loadm $start
storem *block
loadm $end
storem *block
push 'jobinput_batch'
job @~batch
loadm $start
loadm $size
call @plus
storem $start
loadm $start
loadm $size
call @plus
storem $end
loadm $count
push 1
call @minus
storem $count
jump :_4_condition_start
:_4_repeat_end
:_5_condition_start
pending
push 0
call @neq
loada
testz
clra
jumpf :_5_repeat_end
:lus
result
jumpf :_6_no_result
push 1
storem $_7_result
:_7_start_each
loadm $_7_result
readelm *result
jumpf :_7_end_each
call @plot
loadm $_7_result
loadb
incb
moveb
storem $_7_result
jump :_7_start_each
:_7_end_each
jump :lus
:_6_no_result
join
jump :_5_condition_start
:_5_repeat_end
prttimer 0
ret
@~calc
storem $n
push 0
storem $c
:_0_condition_start
push 0
loadm $n
call @gt
loada
testz
clra
jumpf :_0_repeat_end
loadm $n
loadm $n
call @isqrt
call @dup
call @mul
call @minus
storem $n
loadm $c
push 1
call @plus
storem $c
jump :_0_condition_start
:_0_repeat_end
loadm $c
ret
@~batch
array *result
push 1
readelm *block
jumpt :_1_readelm_done
call @__illegal_Array_Index
:_1_readelm_done
storem $m
push 2
readelm *block
jumpt :_2_readelm_done
call @__illegal_Array_Index
:_2_readelm_done
storem $end
:_3_condition_start
loadm $m
loadm $end
call @neq
loada
testz
clra
jumpf :_3_repeat_end
loadm $m
call @~calc
storem *result
loadm $m
push 1
call @plus
storem $m
jump :_3_condition_start
:_3_repeat_end
done *result
@__MemAllocGlobels
array *result
array *block
push 'jobinput_batch'
index *block
ret
