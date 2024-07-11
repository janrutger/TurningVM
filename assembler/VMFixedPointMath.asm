
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

@F_to_fpn
    loadm $FPbits
    call @bsl
ret

@F_to_int
    loadm $FPbits
    call @bsr
ret

@F_add
    call @plus
ret

@F_min
    call @minus
ret

@F_mul
    call @mul
    loadm $FPbits
    call @bsr
ret

@F_div
    storem $FP_tmp
    loadm $FPbits
    call @bsl
    loadm $FP_tmp
    call @div
ret

@F_sqrt
    call @isqrt
    loadm $FPbits
    push 2
    call @div
    call @bsl
ret

@FPFRAC
    call @dup
    loadm $FPbits
    call @bsr
    loadm $FPbits
    call @bsl
    call @minus
ret

@F_floor
    loadm $FPbits
    call @bsr
    loadm $FPbits
    call @bsl
ret

@F_ceil
    call @dup
    call @FPFRAC
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

@F_round
    call @dup
    call @FPFRAC
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

