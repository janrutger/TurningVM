@main




push 21
push 2
push 2

:jajaja

multi

storeb
storem $bewaarmain


loadb
decb
jumpt :end_main

storeb
loadm $bewaarmain
push 2
loadm $bewaarmain

storem %_plotter

clra
clrb

jump :jajaja



:end_main
    ret
