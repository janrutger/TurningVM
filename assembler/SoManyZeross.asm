@main
    push 3
    speed 1
    :loop
        call @dup
        call @dup

        prt
        call @mul

    jump :loop


ret