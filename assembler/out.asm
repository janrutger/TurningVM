@main
settimer 0
speed 0
:_14_condition_start
loadm $start
loadm $max
call @neq
loada
testz
clra
jumpf :_14_repeat_end
loadm $start
storem *workingList
loadm $start
push 1
call @plus
storem $start
jump :_14_condition_start
:_14_repeat_end
call @~check4prime
push 1
storem $_15_primeList
:_15_start_each
loadm $_15_primeList
readelm *primeList
jumpf :_15_end_each
call @plot
loadm $_15_primeList
loadb
incb
moveb
storem $_15_primeList
jump :_15_start_each
:_15_end_each
prttimer 0
ret
@~calc
push 0
storem $res
push 1
readelm *arg
jumpt :_0_readelm_done
call @__illegal_Array_Index
:_0_readelm_done
push 2
readelm *arg
jumpt :_1_readelm_done
call @__illegal_Array_Index
:_1_readelm_done
call @mod
push 0
call @neq
loada
testz
clra
jumpf :_2_do_end
push 1
readelm *arg
jumpt :_3_readelm_done
call @__illegal_Array_Index
:_3_readelm_done
storem $res
:_2_do_end
done $res
@~check4prime
:startrun
push 1
readelm *workingList
jumpt :_4_readelm_done
call @__illegal_Array_Index
:_4_readelm_done
storem $n
loadm $n
storem *primeList
loadm $n
call @plot
push 1
storem $_5_workingList
:_5_start_each
loadm $_5_workingList
readelm *workingList
jumpf :_5_end_each
storem $i
loadm $i
loadm $n
call @neq
loada
testz
clra
jumpf :_6_do_end
loadm $i
storem *arg
loadm $n
storem *arg
push 'jobinput_calc'
job @~calc
array *arg
:_6_do_end
loadm $_5_workingList
loadb
incb
moveb
storem $_5_workingList
jump :_5_start_each
:_5_end_each
:_7_condition_start
pending
push 0
call @neq
loada
testz
clra
jumpf :_7_repeat_end
:lus
result
jumpf :_8_no_result
loadm $res
push 0
call @neq
loada
testz
clra
jumpf :_9_do_end
loadm $res
storem *tmp
jump :lus
:_9_do_end
:_8_no_result
join
jump :_7_condition_start
:_7_repeat_end
array *workingList
push 1
storem $_10_tmp
:_10_start_copy
loadm $_10_tmp
readelm *tmp
jumpf :_10_end_copy
storem *workingList
loadm $_10_tmp
loadb
incb
moveb
storem $_10_tmp
jump :_10_start_copy
:_10_end_copy
array *tmp
array *arg
loadm $max
push 1
readelm *workingList
jumpt :_11_readelm_done
call @__illegal_Array_Index
:_11_readelm_done
call @dup
call @mul
call @lt
loada
testz
clra
jumpf :_12_goto_end
jump :startrun
:_12_goto_end
push 1
storem $_13_workingList
:_13_start_each
loadm $_13_workingList
readelm *workingList
jumpf :_13_end_each
call @dup
storem *primeList
call @plot
loadm $_13_workingList
loadb
incb
moveb
storem $_13_workingList
jump :_13_start_each
:_13_end_each
ret
@__MemAllocGlobels
array *workingList
array *primeList
array *tmp
array *arg
push 0
storem $max
push 2500
storem $max
push 0
storem $start
push 2
storem $start
push 0
storem $i
push 0
storem $n
push 0
storem $res
push 'jobinput_calc'
index *arg
ret
