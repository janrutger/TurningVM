@main
settimer 0
call @stackssys
push 1
storem $n
:_0_condition_start
loadm $n
push 10
call @neq
loada
testz
clra
jumpf :_0_repeat_end
loadm $n
call @~dubbel
loadm $n
push 1
call @plus
storem $n
jump :_0_condition_start
:_0_repeat_end
prttimer 0
ret
@~dubbel
call @dup
call @mul
prt
ret
