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
