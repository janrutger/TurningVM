@main
settimer 0
speed 0
call @~grid
push 'playX'
storem $player
push 'input\_playerX'
call @char2prtbuff
call @printbuff
push 0
storem $steps
:_38_condition_start
loadm $steps
push 9
call @neq
loada
testz
clra
jumpf :_38_repeat_end
call @input
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_40_do_end
pull
loadm $player
call @~(c1)take
jump :_39_match_end
:_40_do_end
call @dup
push 2
call @eq
loada
testz
clra
jumpf :_41_do_end
pull
loadm $player
call @~(c2)take
jump :_39_match_end
:_41_do_end
call @dup
push 3
call @eq
loada
testz
clra
jumpf :_42_do_end
pull
loadm $player
call @~(c3)take
jump :_39_match_end
:_42_do_end
call @dup
push 4
call @eq
loada
testz
clra
jumpf :_43_do_end
pull
loadm $player
call @~(c4)take
jump :_39_match_end
:_43_do_end
call @dup
push 5
call @eq
loada
testz
clra
jumpf :_44_do_end
pull
loadm $player
call @~(c5)take
jump :_39_match_end
:_44_do_end
call @dup
push 6
call @eq
loada
testz
clra
jumpf :_45_do_end
pull
loadm $player
call @~(c6)take
jump :_39_match_end
:_45_do_end
call @dup
push 7
call @eq
loada
testz
clra
jumpf :_46_do_end
pull
loadm $player
call @~(c7)take
jump :_39_match_end
:_46_do_end
call @dup
push 8
call @eq
loada
testz
clra
jumpf :_47_do_end
pull
loadm $player
call @~(c8)take
jump :_39_match_end
:_47_do_end
call @dup
push 9
call @eq
loada
testz
clra
jumpf :_48_do_end
pull
loadm $player
call @~(c9)take
jump :_39_match_end
:_48_do_end
call @dup
push 0
call @eq
loada
testz
clra
jumpf :_49_do_end
pull
jump :done
jump :_39_match_end
:_49_do_end
pull
:_39_match_end
call @dup
push 0
call @eq
loada
testz
clra
jumpf :_51_do_end
pull
loadm $player
push 'playX'
call @eq
loada
testz
clra
jumpf :_52_do_end
call @~cross
:_52_do_end
loadm $player
push 'playO'
call @eq
loada
testz
clra
jumpf :_53_do_end
call @~circle
:_53_do_end
call @~(c1)owner
prt
call @~(c2)owner
prt
loadm $player
call @dup
push 'playX'
call @eq
loada
testz
clra
jumpf :_55_do_end
pull
push 'playO'
storem $player
push 'input\_playerO'
call @char2prtbuff
call @printbuff
jump :_54_match_end
:_55_do_end
push 'playX'
storem $player
push 'input\_playerX'
call @char2prtbuff
call @printbuff
pull
:_54_match_end
push 1
loadm $steps
call @plus
storem $steps
jump :_50_match_end
:_51_do_end
call @dup
push 1
call @eq
loada
testz
clra
jumpf :_56_do_end
pull
push 'Invalid\_move'
call @char2prtbuff
call @printbuff
jump :_50_match_end
:_56_do_end
pull
:_50_match_end
jump :_38_condition_start
:_38_repeat_end
:done
call @drawBuff
prttimer 0
ret
@~circle
push 0
storem $start
call @~(Turtle)goto
:_27_condition_start
loadm $start
push 360
call @gt
loada
testz
clra
jumpf :_27_repeat_end
call @~(Turtle)move
push 45
call @~(Turtle)right
call @~(Turtle)move
loadm $start
push 45
call @plus
storem $start
jump :_27_condition_start
:_27_repeat_end
call @drawBuff
ret
@~cross
array *cursor
call @swap
storem *cursor
storem *cursor
push 1
readelm *cursor
jumpt :_28_readelm_done
call @__illegal_Array_Index
:_28_readelm_done
push 2
readelm *cursor
jumpt :_29_readelm_done
call @__illegal_Array_Index
:_29_readelm_done
call @~(Turtle)goto
push 1
readelm *cursor
jumpt :_30_readelm_done
call @__illegal_Array_Index
:_30_readelm_done
push 5
call @plus
push 2
readelm *cursor
jumpt :_31_readelm_done
call @__illegal_Array_Index
:_31_readelm_done
push 5
call @minus
call @~(Turtle)line
push 1
readelm *cursor
jumpt :_32_readelm_done
call @__illegal_Array_Index
:_32_readelm_done
push 5
call @plus
push 2
readelm *cursor
jumpt :_33_readelm_done
call @__illegal_Array_Index
:_33_readelm_done
call @~(Turtle)goto
push 1
readelm *cursor
jumpt :_34_readelm_done
call @__illegal_Array_Index
:_34_readelm_done
push 2
readelm *cursor
jumpt :_35_readelm_done
call @__illegal_Array_Index
:_35_readelm_done
push 5
call @minus
call @~(Turtle)line
call @drawBuff
ret
@~grid
call @drawNew
push 0
push 0
call @draw
push 1
readelm *size
jumpt :_36_readelm_done
call @__illegal_Array_Index
:_36_readelm_done
push 2
readelm *size
jumpt :_37_readelm_done
call @__illegal_Array_Index
:_37_readelm_done
call @draw
push 5
push 25
call @~(Turtle)goto
push 75
push 25
call @~(Turtle)line
push 25
push 5
call @~(Turtle)goto
push 25
push 75
call @~(Turtle)line
push 5
push 50
call @~(Turtle)goto
push 75
push 50
call @~(Turtle)line
push 50
push 5
call @~(Turtle)goto
push 50
push 75
call @~(Turtle)line
call @drawBuff
ret
@~(c1)INIT
push 12
storem $(c1)x
push 12
storem $(c1)y
push 'free'
storem $(c1)player
ret
@~(c1)take
loadm $(c1)player
call @dup
push 'free'
call @eq
loada
testz
clra
jumpf :_1_do_end
pull
storem $(c1)player
loadm $(c1)x
loadm $(c1)y
push 0
jump :_0_match_end
:_1_do_end
call @dup
push 'free'
call @neq
loada
testz
clra
jumpf :_2_do_end
pull
pull
push 1
jump :_0_match_end
:_2_do_end
pull
:_0_match_end
ret
@~(c1)owner
loadm $(c1)player
ret
@~(c2)INIT
push 37
storem $(c2)x
push 12
storem $(c2)y
push 'free'
storem $(c2)player
ret
@~(c2)take
loadm $(c2)player
call @dup
push 'free'
call @eq
loada
testz
clra
jumpf :_4_do_end
pull
storem $(c2)player
loadm $(c2)x
loadm $(c2)y
push 0
jump :_3_match_end
:_4_do_end
call @dup
push 'free'
call @neq
loada
testz
clra
jumpf :_5_do_end
pull
pull
push 1
jump :_3_match_end
:_5_do_end
pull
:_3_match_end
ret
@~(c2)owner
loadm $(c2)player
ret
@~(c3)INIT
push 62
storem $(c3)x
push 12
storem $(c3)y
push 'free'
storem $(c3)player
ret
@~(c3)take
loadm $(c3)player
call @dup
push 'free'
call @eq
loada
testz
clra
jumpf :_7_do_end
pull
storem $(c3)player
loadm $(c3)x
loadm $(c3)y
push 0
jump :_6_match_end
:_7_do_end
call @dup
push 'free'
call @neq
loada
testz
clra
jumpf :_8_do_end
pull
pull
push 1
jump :_6_match_end
:_8_do_end
pull
:_6_match_end
ret
@~(c3)owner
loadm $(c3)player
ret
@~(c4)INIT
push 12
storem $(c4)x
push 37
storem $(c4)y
push 'free'
storem $(c4)player
ret
@~(c4)take
loadm $(c4)player
call @dup
push 'free'
call @eq
loada
testz
clra
jumpf :_10_do_end
pull
storem $(c4)player
loadm $(c4)x
loadm $(c4)y
push 0
jump :_9_match_end
:_10_do_end
call @dup
push 'free'
call @neq
loada
testz
clra
jumpf :_11_do_end
pull
pull
push 1
jump :_9_match_end
:_11_do_end
pull
:_9_match_end
ret
@~(c4)owner
loadm $(c4)player
ret
@~(c5)INIT
push 37
storem $(c5)x
push 37
storem $(c5)y
push 'free'
storem $(c5)player
ret
@~(c5)take
loadm $(c5)player
call @dup
push 'free'
call @eq
loada
testz
clra
jumpf :_13_do_end
pull
storem $(c5)player
loadm $(c5)x
loadm $(c5)y
push 0
jump :_12_match_end
:_13_do_end
call @dup
push 'free'
call @neq
loada
testz
clra
jumpf :_14_do_end
pull
pull
push 1
jump :_12_match_end
:_14_do_end
pull
:_12_match_end
ret
@~(c5)owner
loadm $(c5)player
ret
@~(c6)INIT
push 62
storem $(c6)x
push 37
storem $(c6)y
push 'free'
storem $(c6)player
ret
@~(c6)take
loadm $(c6)player
call @dup
push 'free'
call @eq
loada
testz
clra
jumpf :_16_do_end
pull
storem $(c6)player
loadm $(c6)x
loadm $(c6)y
push 0
jump :_15_match_end
:_16_do_end
call @dup
push 'free'
call @neq
loada
testz
clra
jumpf :_17_do_end
pull
pull
push 1
jump :_15_match_end
:_17_do_end
pull
:_15_match_end
ret
@~(c6)owner
loadm $(c6)player
ret
@~(c7)INIT
push 12
storem $(c7)x
push 62
storem $(c7)y
push 'free'
storem $(c7)player
ret
@~(c7)take
loadm $(c7)player
call @dup
push 'free'
call @eq
loada
testz
clra
jumpf :_19_do_end
pull
storem $(c7)player
loadm $(c7)x
loadm $(c7)y
push 0
jump :_18_match_end
:_19_do_end
call @dup
push 'free'
call @neq
loada
testz
clra
jumpf :_20_do_end
pull
pull
push 1
jump :_18_match_end
:_20_do_end
pull
:_18_match_end
ret
@~(c7)owner
loadm $(c7)player
ret
@~(c8)INIT
push 37
storem $(c8)x
push 62
storem $(c8)y
push 'free'
storem $(c8)player
ret
@~(c8)take
loadm $(c8)player
call @dup
push 'free'
call @eq
loada
testz
clra
jumpf :_22_do_end
pull
storem $(c8)player
loadm $(c8)x
loadm $(c8)y
push 0
jump :_21_match_end
:_22_do_end
call @dup
push 'free'
call @neq
loada
testz
clra
jumpf :_23_do_end
pull
pull
push 1
jump :_21_match_end
:_23_do_end
pull
:_21_match_end
ret
@~(c8)owner
loadm $(c8)player
ret
@~(c9)INIT
push 62
storem $(c9)x
push 62
storem $(c9)y
push 'free'
storem $(c9)player
ret
@~(c9)take
loadm $(c9)player
call @dup
push 'free'
call @eq
loada
testz
clra
jumpf :_25_do_end
pull
storem $(c9)player
loadm $(c9)x
loadm $(c9)y
push 0
jump :_24_match_end
:_25_do_end
call @dup
push 'free'
call @neq
loada
testz
clra
jumpf :_26_do_end
pull
pull
push 1
jump :_24_match_end
:_26_do_end
pull
:_24_match_end
ret
@~(c9)owner
loadm $(c9)player
ret
@__MemAllocGlobels
call @init_vmachine
array *size
push 160
storem *size
push 80
storem *size
call @~(Turtle)INIT
call @~(c1)INIT
call @~(c2)INIT
call @~(c3)INIT
call @~(c4)INIT
call @~(c5)INIT
call @~(c6)INIT
call @~(c7)INIT
call @~(c8)INIT
call @~(c9)INIT
push 0
call @drawRate
ret
