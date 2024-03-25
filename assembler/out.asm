@main
settimer 0
speed 0
call @input
call @input
call @over
call @over
call @~lcm
prt
call @lcm
prt
prttimer 0
ret
@~lcm
storem $b
storem $a
loadm $a
loadm $b
loadm $a
loadm $b
call @_gcd
call @div
call @mul
ret
