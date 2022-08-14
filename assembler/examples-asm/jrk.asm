push 3
push 4

halt



# test program
speed 1

lifo %mystack
lifo %_system

push 10
push 5
#push 0
#loada

call :xx
call :xx

storea
prt

halt

:xx
	add
ret

storem %mystack



push 5
storem %mystack

loadm %mystack

halt


push 0b1100
push 0b1010

storem $jan1
storem $jan

loadm $jan1
loadm $jan

storem $jan

halt


	speed 3

	push 2
	push 1

	loadb
	#loada

	speed 5

	testg

	halt