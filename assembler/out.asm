@main
call @stackssys
push 1
storem $s
:_0_condition_start
loadm $s
push 2000
call @neq
loada
testz
clra
jumpf :_0_repeat_end
push 2
loadm $s
call @lt
loada
testz
clra
jumpf :_1_do_end
push 1
call @plot
jump :einde
:_1_do_end
loadm $s
push 2
call @div
storem $x0
loadm $s
loadm $x0
call @div
loadm $x0
call @plus
push 2
call @div
storem $x1
:_2_condition_start
loadm $x0
loadm $x1
call @lt
loada
testz
clra
jumpf :_2_repeat_end
loadm $x1
storem $x0
loadm $s
loadm $x0
call @div
loadm $x0
call @plus
push 2
call @div
storem $x1
jump :_2_condition_start
:_2_repeat_end
loadm $x0
call @plot
:einde
loadm $s
push 1
call @plus
storem $s
jump :_0_condition_start
:_0_repeat_end
ret
