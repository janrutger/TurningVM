@main
call @stackssys
push 75
storem $aRandom
push 3
storem $seed
push 74
storem $cRandom
push 65537
storem $m
loadm $aRandom
loadm $seed
call @mul
loadm $cRandom
call @plus
loadm $m
call @mod
call @dup
storem $seed
call @dup
call @plot
ret
