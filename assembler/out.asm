@main
call @stackssys
push 0
storem $quotient
push 0
storem $counter
storem $divisor
storem $number
loadm $divisor
push 2
call @gt
loada
testz
clra
jumpf :_0_goto_end
jump :uitzonderingen
:_0_goto_end
:_1_condition_start
loadm $number
loadm $counter
call @lt
loada
testz
clra
jumpf :_1_repeat_end
loadm $counter
loadm $divisor
call @plus
storem $counter
loadm $quotient
push 1
call @plus
storem $quotient
jump :_1_condition_start
:_1_repeat_end
jump :einde
:uitzonderingen
push 1
loadm $divisor
call @eq
loada
testz
clra
jumpf :_2_do_end
loadm $divisor
storem $quotient
loadm $divisor
storem $counter
:_2_do_end
push 2
loadm $divisor
call @eq
loada
testz
clra
jumpf :_3_do_end
:_3_do_end
push 0
loadm $divisor
call @eq
loada
testz
clra
jumpf :_4_do_end
:_4_do_end
:einde
loadm $quotient
loadm $counter
loadm $number
call @minus
ret
