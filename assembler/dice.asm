@main
call @rand

push 6
call @mul
push 100
call @div
push 1
call @plus


storem %_plotter
output %_plotter

ret
