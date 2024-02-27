@main
settimer 0
speed 0
array *A1
push 3
storem *A1
push 5
storem *A1
push 6
storem *A1
push 'jobinput_test'
index *A1
push 'jobinput_test'
job @~test
join
:getResult
result
jumpf :_1_no_result
push 1
storem $_2_A2
:_2_start_each
loadm $_2_A2
readelm *A2
jumpf :_2_end_each
prt
loadm $_2_A2
loadb
incb
moveb
storem $_2_A2
jump :_2_start_each
:_2_end_each
jump :klaar
:_1_no_result
jump :getResult
:klaar
push 0
storem $n
array *A3
push 4
storem *A3
push 8
storem *A3
push 16
storem *A3
array *A4
push 3
storem *A4
push 6
storem *A4
push 9
storem *A4
:_3_condition_start
loadm *A3
call @~step
call @lt
loada
testz
clra
jumpf :_3_repeat_end
loadm $n
readelm *A3
jumpt :_4_readelm_done
call @__illegal_Array_Index
:_4_readelm_done
loadm $n
readelm *A4
jumpt :_5_readelm_done
call @__illegal_Array_Index
:_5_readelm_done
call @mul
prt
jump :_3_condition_start
:_3_repeat_end
prttimer 0
ret
@~test
array *A2
push 1
storem $_0_A1
:_0_start_each
loadm $_0_A1
readelm *A1
jumpf :_0_end_each
call @dup
call @mul
storem *A2
loadm $_0_A1
loadb
incb
moveb
storem $_0_A1
jump :_0_start_each
:_0_end_each
done *A2
@~step
loadm $n
loadm $n
push 1
call @plus
storem $n
ret
