@main
settimer 0
call @stackssys
call @input
storem $seed1
call @input
storem $seed2
push 0
call @plot
push 0
storem $acount
push 0
storem $bcount
push 0
storem $abcount
:loop
call @rawin
push 1
call @eq
loada
testz
clra
jumpf :_3_do_end
call @dup
push 'winner'
call @eq
loada
testz
clra
jumpf :_4_do_end
pull
call @~winner
jump :loop
:_4_do_end
call @dup
push 'runner'
call @eq
loada
testz
clra
jumpf :_5_do_end
pull
call @input
storem $max
push 0
storem $n
:_6_condition_start
loadm $n
loadm $max
call @neq
loada
testz
clra
jumpf :_6_repeat_end
call @~winner
loadm $n
push 1
call @plus
storem $n
jump :_6_condition_start
:_6_repeat_end
jump :loop
:_5_do_end
call @dup
push 'show'
call @eq
loada
testz
clra
jumpf :_7_do_end
pull
loadm $acount
prt
loadm $bcount
prt
loadm $abcount
prt
push 0
storem $acount
push 0
storem $bcount
push 0
storem $abcount
jump :loop
:_7_do_end
push 'q'
call @eq
loada
testz
clra
jumpf :_8_goto_end
jump :endloop
:_8_goto_end
jump :loop
:_3_do_end
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_9_do_end
pull
call @~dice1
prt
jump :loop
:_9_do_end
call @dup
push 2
call @eq
loada
testz
clra
jumpf :_10_do_end
pull
call @~dice2
prt
jump :loop
:_10_do_end
pull
jump :loop
:endloop
prttimer 0
ret
@~dice1
loadm $seed1
storem $seed
call @rand
push 6
call @mul
push 100
call @div
push 1
call @plus
loadm $seed
storem $seed1
ret
@~dice2
loadm $seed2
storem $seed
call @rand
push 6
call @mul
push 100
call @div
push 1
call @plus
loadm $seed
storem $seed2
ret
@~winner
call @~dice1
storem $a
call @~dice2
storem $b
loadm $a
loadm $b
call @lt
loada
testz
clra
jumpf :_0_do_end
push 1
call @plot
loadm $acount
push 1
call @plus
storem $acount
:_0_do_end
loadm $a
loadm $b
call @gt
loada
testz
clra
jumpf :_1_do_end
push 2
call @plot
loadm $bcount
push 1
call @plus
storem $bcount
:_1_do_end
loadm $a
loadm $b
call @eq
loada
testz
clra
jumpf :_2_do_end
push 3
call @plot
loadm $abcount
push 1
call @plus
storem $abcount
:_2_do_end
ret
