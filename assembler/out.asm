@main
settimer 0
call @stackssys
call @input
call @~fact
prt
prttimer 0
ret
@~fact
call @dup
push 1
call @neq
loada
testz
clra
jumpf :_0_do_end
call @dup
push 1
call @minus
call @~fact
call @mul
:_0_do_end
ret
