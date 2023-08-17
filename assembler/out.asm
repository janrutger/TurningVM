@main
call @stackssys
push 1000
storem $offset
push 1
storem $x
loadm $offset
call @plot
:_0_condition_start
loadm $x
push 180
call @neq
loada
testz
clra
jumpf :_0_repeat_end
push 180
loadm $x
call @minus
loadm $x
call @mul
storem $u
loadm $offset
push 4000
loadm $u
call @mul
push 40500
loadm $u
call @minus
call @div
call @plus
call @plot
loadm $x
push 1
call @plus
storem $x
jump :_0_condition_start
:_0_repeat_end
push 1
storem $x
loadm $offset
call @plot
:_1_condition_start
loadm $x
push 180
call @neq
loada
testz
clra
jumpf :_1_repeat_end
push 180
loadm $x
call @minus
loadm $x
call @mul
storem $u
loadm $offset
push 4000
loadm $u
call @mul
push 40500
loadm $u
call @minus
call @div
call @minus
call @plot
loadm $x
push 1
call @plus
storem $x
jump :_1_condition_start
:_1_repeat_end
ret
