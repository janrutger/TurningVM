@main
settimer 0
speed 0
push 99
call @isqrt
prt
push 99
call @F_to_fpn
call @F_sqrt
fp_prt
push F99.999
call @F_sqrt
fp_prt
push F1.5
push F1.25
call @F_add
push F0.251
call @F_add
fp_prt
push F1.5
call @plot
push F1.25
call @plot
push F0.25
call @plot
prttimer 0
ret
# Start of THINGS
