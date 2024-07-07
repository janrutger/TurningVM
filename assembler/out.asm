@main
settimer 0
speed 0
call @~(FP)INIT
push 1
call @~(FP)to
storem $a
push 3
call @~(FP)to
storem $b
push 2
call @~(FP)to
storem $c
loadm $a
loadm $b
call @~(FP)div
call @dup
call @~(FP)print
loadm $b
call @~(FP)mul
call @dup
call @~(FP)print
loadm $b
call @~(FP)add
call @dup
call @~(FP)print
loadm $a
call @~(FP)min
call @dup
call @~(FP)print
loadm $c
call @~(FP)div
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
