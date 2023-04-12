@main
call @stackssys
push 1
call @dup
call @plot
call @dup
call @plot
storem $previous
push 2
storem $next
:_0_condition_start
loadm $next
push 700
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $previous
loadm $next
call @_gcd
storem $cfactor
push 1
loadm $cfactor
call @eq
loada
testz
clra
jumpf :_1_do_end
loadm $previous
loadm $next
push 1
call @plus
call @plus
jump :nextnumber
:_1_do_end
loadm $previous
loadm $cfactor
call @div
:nextnumber
call @dup
call @plot
storem $previous
loadm $next
push 1
call @plus
storem $next
jump :_0_condition_start
:_0_repeat_end
ret
