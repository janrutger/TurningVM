@main
settimer 0
speed 0
call @~(FP)INIT
push 1
call @~(FP)to
storem $a
push 6
call @~(FP)to
storem $b
push 3
call @~(FP)to
storem $c
loadm $b
loadm $c
call @~(FP)div
call @~(FP)frac
call @~(FP)print
prttimer 0
ret
# Start of THINGS
@~(FP)INIT
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
@~(FP)frac
call @dup
loadm $FPbits
call @bsr
loadm $FPbits
call @bsl
call @minus
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
