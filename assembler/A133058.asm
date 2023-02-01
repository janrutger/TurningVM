@oeis
    push 1 
    push 1
    storem %_plotter
    output %_plotter     
    push 1  
    push 1
    storem %_plotter 
    output %_plotter   

    push 2      
    storem $n


:loop
    loada       
    storea      

    storea      
    loadm $n    

    call @gcd  

    push 1     
    loada
    teste       
    jumpt :no-cf  

:cf           
    loada
    storea 
    storea     
    storeb   

    call @modulo 

    storea 
    storea
    storem %_plotter 
    output %_plotter    
    jump :incn  

:no-cf          
    loada
    storea
    storea     
    loadm $n    
    push 1      
    loada
    add        
    add        

    storea  
    storea
    storem %_plotter 
    output %_plotter  
    jump :incn  

:incn
    push 1      
    loadm $n
    loada
    add         
    storea      
    storem $n  
    push 700
    loadb
    teste      
    jumpt :done 

    clra
    clrb
    
    jump :loop

:done   
    clra
    clrb

    ret

