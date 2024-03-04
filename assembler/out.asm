@main
settimer 0
speed 0
array *workingList
array *tmp
array *primeList
push 5000
storem $max
push 2
storem $start
:_0_condition_start
loadm $start
loadm $max
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $start
storem *workingList
loadm $start
push 1
call @plus
storem $start
jump :_0_condition_start
:_0_repeat_end
call @~check4prime
prttimer 0
ret
@~check4prime
:startrun
push 1
readelm *workingList
jumpt :_1_readelm_done
call @__illegal_Array_Index
:_1_readelm_done
storem $n
loadm $n
storem *primeList
loadm $n
call @plot
push 1
storem $_2_workingList
:_2_start_each
loadm $_2_workingList
readelm *workingList
jumpf :_2_end_each
storem $i
loadm $i
loadm $n
call @neq
loada
testz
clra
jumpf :_3_do_end
loadm $i
loadm $n
call @mod
push 0
call @neq
loada
testz
clra
jumpf :_4_do_end
loadm $i
storem *tmp
:_4_do_end
:_3_do_end
loadm $_2_workingList
loadb
incb
moveb
storem $_2_workingList
jump :_2_start_each
:_2_end_each
array *workingList
push 1
storem $_5_tmp
:_5_start_copy
loadm $_5_tmp
readelm *tmp
jumpf :_5_end_copy
storem *workingList
loadm $_5_tmp
loadb
incb
moveb
storem $_5_tmp
jump :_5_start_copy
:_5_end_copy
array *tmp
loadm $max
push 1
readelm *workingList
jumpt :_6_readelm_done
call @__illegal_Array_Index
:_6_readelm_done
call @dup
call @mul
call @lt
loada
testz
clra
jumpf :_7_goto_end
jump :startrun
:_7_goto_end
push 1
storem $_8_workingList
:_8_start_each
loadm $_8_workingList
readelm *workingList
jumpf :_8_end_each
call @dup
storem *primeList
call @plot
loadm $_8_workingList
loadb
incb
moveb
storem $_8_workingList
jump :_8_start_each
:_8_end_each
ret
