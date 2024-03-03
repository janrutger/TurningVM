@main
settimer 0
speed 0
array *org
array *dest
push 0
storem $n
:_0_condition_start
loadm $n
push 2500
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $n
storem *org
loadm $n
push 1
call @plus
storem $n
jump :_0_condition_start
:_0_repeat_end
settimer 17
push 1
storem $_1_org
:_1_start_copy
loadm $_1_org
readelm *org
jumpf :_1_end_copy
storem *dest
loadm $_1_org
loadb
incb
moveb
storem $_1_org
jump :_1_start_copy
:_1_end_copy
prttimer 17
loadm *org
prt
loadm *dest
prt
prttimer 0
ret
