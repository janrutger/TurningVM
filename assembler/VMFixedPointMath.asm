
@F_INIT
    push 12
    storem $FPbits
    push 1
    loadm $FPbits
    push 1
    call @minus
    call @bsl
    storem $FP_half
    push 1
    loadm $FPbits
    call @bsl
    storem $FP_one
ret

@Fto
    loadm $FPbits
    call @bsl
ret

@Ffrom
    loadm $FPbits
    call @bsr
ret

@FADD
    call @plus
ret

@FMIN
    call @minus
ret

@FMUL
    call @mul
    loadm $FPbits
    call @bsr
ret

@FDIV
    storem $FP_tmp
    loadm $FPbits
    call @bsl
    loadm $FP_tmp
    call @div
ret

@FSQRT
    call @isqrt
    loadm $FPbits
    push 2
    call @div
    call @bsl
ret

@FFRAC
    call @dup
    loadm $FPbits
    call @bsr
    loadm $FPbits
    call @bsl
    call @minus
ret

@FFLOOR
    loadm $FPbits
    call @bsr
    loadm $FPbits
    call @bsl
ret

@FCEIL
    call @dup
    call @FFRAC
    storem $FP_fraction
    loadm $FPbits
    call @bsr
    loadm $FPbits
    call @bsl
    loadm $FP_fraction
    push 0
    call @lt
    loada
    testz
    clra
    jumpf :_0_do_end
        loadm $FP_one
        call @plus
    :_0_do_end
ret

@FROUND
    call @dup
    call @FFRAC
    storem $FP_fraction
    loadm $FPbits
    call @bsr
    loadm $FPbits
    call @bsl
    loadm $FP_fraction
    loadm $FP_half
    call @lt
    loada
    testz
    clra
    jumpf :_1_do_end
        loadm $FP_one
        call @plus
    :_1_do_end
ret

@FPRINT
    fp_prt
ret