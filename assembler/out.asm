@main
settimer 0
speed 0
push F3.0
call @~p1
call @plus
call @~p2
call @minus
call @~p3
call @plus
call @~p4
call @minus
call @~p5
call @plus
call @~p6
call @minus
call @~p7
call @plus
call @~p8
call @minus
call @~p9
call @plus
fp_prt
push F1.0
push F3.0
call @F_div
push F3.0
call @F_mul
fp_prt
prttimer 0
ret
@~p1
push F4.0
push 2
push 3
push 4
call @mul
call @mul
call @F_to_fpn
call @F_div
ret
@~p2
push F4.0
push 4
push 5
push 6
call @mul
call @mul
call @F_to_fpn
call @F_div
ret
@~p3
push F4.0
push 6
push 7
push 8
call @mul
call @mul
call @F_to_fpn
call @F_div
ret
@~p4
push F4.0
push 8
push 9
push 10
call @mul
call @mul
call @F_to_fpn
call @F_div
ret
@~p5
push F4.0
push 10
push 11
push 12
call @mul
call @mul
call @F_to_fpn
call @F_div
ret
@~p6
push F4.0
push 12
push 13
push 14
call @mul
call @mul
call @F_to_fpn
call @F_div
ret
@~p7
push F4.0
push 14
push 15
push 16
call @mul
call @mul
call @F_to_fpn
call @F_div
ret
@~p8
push F4.0
push 16
push 17
push 18
call @mul
call @mul
call @F_to_fpn
call @F_div
ret
@~p9
push F4.0
push 18
push 19
push 20
call @mul
call @mul
call @F_to_fpn
call @F_div
ret
# Start of THINGS
