@main
call @stackssys
push 10000000
storem $max
push 3
storem $n
loadm $max
storem $a
:_0_condition_start
loadm $n
loadm $max
call @gt
loada
testz
clra
jumpf :_0_repeat_end
loadm $a
loadm $max
loadm $n
call @div
call @minus
storem $a
loadm $n
prt
loadm $a
push 4
call @mul
prt
loadm $n
push 2
call @plus
storem $n
loadm $a
loadm $max
loadm $n
call @div
call @plus
storem $a
loadm $n
push 2
call @plus
storem $n
jump :_0_condition_start
:_0_repeat_end
loadm $a
push 4
call @mul
prt
ret
