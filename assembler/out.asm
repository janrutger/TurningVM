@main
settimer 0
speed 0
array *data
array *tmp
push 140
storem $max
settimer 17
:_0_condition_start
loadm $max
push 0
call @neq
loada
testz
clra
jumpf :_0_repeat_end
call @rand
storem *data
loadm $max
push 1
call @minus
storem $max
call @plotnew
push '_input_plotarray'
index  *data
call @plotarray
jump :_0_condition_start
:_0_repeat_end
prttimer 17
call @~plot
settimer 17
call @~sort
prttimer 17
call @~plot
prttimer 0
ret
@~plot
call @plotnew
push '_input_plotarray'
index  *data
call @plotarray
ret
@~sort
push 0
storem $sorting
:_1_condition_start
loadm $sorting
loada
testz
clra
jumpf :_1_repeat_end
push 1
storem $sorting
push 1
storem $n
push 2
storem $nn
:lus
loadm $nn
loadm *data
push 1
call @plus
call @eq
loada
testz
clra
jumpf :_2_goto_end
jump :done
:_2_goto_end
loadm $n
readelm *data
jumpt :_3_readelm_done
call @__illegal_Array_Index
:_3_readelm_done
loadm $nn
readelm *data
jumpt :_4_readelm_done
call @__illegal_Array_Index
:_4_readelm_done
call @lt
loada
testz
clra
jumpf :_5_do_end
loadm $nn
readelm *data
jumpt :_6_readelm_done
call @__illegal_Array_Index
:_6_readelm_done
storem *tmp
loadm $nn
push 1
call @plus
storem $nn
push 0
storem $sorting
jump :lus
:_5_do_end
loadm $n
readelm *data
jumpt :_7_readelm_done
call @__illegal_Array_Index
:_7_readelm_done
storem *tmp
loadm $nn
storem $n
loadm $nn
push 1
call @plus
storem $nn
jump :lus
:done
loadm $n
readelm *data
jumpt :_8_readelm_done
call @__illegal_Array_Index
:_8_readelm_done
storem *tmp
array *data
push 1
storem $_9_tmp
:_9_start_copy
loadm $_9_tmp
readelm *tmp
jumpf :_9_end_copy
storem *data
loadm $_9_tmp
loadb
incb
moveb
storem $_9_tmp
jump :_9_start_copy
:_9_end_copy
array *tmp
call @~plot
jump :_1_condition_start
:_1_repeat_end
ret
