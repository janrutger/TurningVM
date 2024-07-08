@main
settimer 0
speed 0
call @~(FP)INIT
push 25
call @~(FP)to
storem $a
push 8
call @~(FP)to
storem $b
push 5
call @~(FP)to
storem $c
loadm $b
loadm $c
call @~(FP)div
call @~(FP)round
call @~(FP)print
prttimer 0
ret
# Start of THINGS
@~(FP)INIT
push 1
loadm $FPbits
push 1
call @minus
call @bsl
storem $(FP)half
push 1
loadm $FPbits
call @bsl
storem $(FP)one
ret
@~(FP)to
loadm $FPbits
call @bsl
ret
@~(FP)from
loadm $FPbits
call @bsr
ret
@~(FP)add
call @plus
ret
@~(FP)min
call @minus
ret
@~(FP)mul
call @mul
loadm $FPbits
call @bsr
ret
@~(FP)div
storem $(FP)tmp
loadm $FPbits
call @bsl
loadm $(FP)tmp
call @div
ret
@~(FP)sqrt
call @isqrt
loadm $FPbits
push 2
call @div
call @bsl
ret
@~(FP)frac
call @dup
loadm $FPbits
call @bsr
loadm $FPbits
call @bsl
call @minus
ret
@~(FP)floor
loadm $FPbits
call @bsr
loadm $FPbits
call @bsl
ret
@~(FP)ceil
call @dup
call @dup
loadm $FPbits
call @bsr
loadm $FPbits
call @bsl
call @minus
storem $(FP)fraction
loadm $FPbits
call @bsr
loadm $FPbits
call @bsl
loadm $(FP)fraction
push 0
call @lt
loada
testz
clra
jumpf :_0_do_end
push 1
call @~(FP)to
call @plus
:_0_do_end
ret
@~(FP)round
call @dup
call @dup
loadm $FPbits
call @bsr
loadm $FPbits
call @bsl
call @minus
storem $(FP)fraction
loadm $FPbits
call @bsr
loadm $FPbits
call @bsl
loadm $(FP)fraction
loadm $(FP)half
call @lt
loada
testz
clra
jumpf :_1_do_end
loadm $(FP)one
call @plus
:_1_do_end
ret
@~(FP)print
call @FPprint
ret
@__MemAllocGlobels
call @init_vmachine
push 0
storem $FPbits
push 12
storem $FPbits
ret
