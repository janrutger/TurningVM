@main
call @stackssys
push 75
storem $a
push 7515
storem $x
push 74
storem $c
push 65537
storem $m
push 20
storem $counter
:_0_condition_start
loadm $counter
push 0
call @neq
loada
testz
jumpf :_0_repeat_end
loadm $a
loadm $x
call @mul
loadm $c
call @plus
loadm $m
call @mod
call @dup
storem $x
push 655
call @div
prt
loadm $counter
push 1
call @minus
storem $counter
jump :_0_condition_start
:_0_repeat_end
clra
ret
