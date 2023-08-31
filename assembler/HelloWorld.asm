@main 
    
    push 'hello'
    call @char2prtbuff
    push 'world?'
    call @char2prtbuff

    push 42
    call @num2prtbuff

    call @printbuff

ret 
