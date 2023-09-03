@main
    push 'hello\_world:\_'
    call @char2prtbuff

    push 42
    call @num2prtbuff

    call @printbuff

ret 