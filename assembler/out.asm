@main
settimer 0
speed 0
push 25
call @Fto
storem $a
push 11
call @Fto
storem $b
push 13
call @Fto
storem $c
loadm $b
loadm $c
call @FDIV
loadm $a
call @FADD
call @FSQRT
call @dup
call @FMUL
call @FPRINT
prttimer 0
ret
# Start of THINGS
