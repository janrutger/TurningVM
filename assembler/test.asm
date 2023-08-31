@main 

    push 10 
    push 15 
    push 35
    storem %_plotter
    storem %_plotter
    storem %_plotter

    output %_plotter

    push 'hello'
    push ' world'

    storem %_display
    push 1
    storem %_display

    storem %_display
    push 1
    storem %_display

    loadm %_display
    loadm %_display
    
ret 
