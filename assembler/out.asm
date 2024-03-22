@main
settimer 0
speed 0
loadm *table
push 1
call @eq
loada
testz
clra
jumpf :_3_do_end
push 'jobinput_makeTable'
job @~makeTable
push 1
call @sleep
:_3_do_end
:_4_condition_start
pending
push 0
call @neq
loada
testz
clra
jumpf :_4_repeat_end
result
jumpf :_5_no_result
loadm *table
prt
:_5_no_result
join
jump :_4_condition_start
:_4_repeat_end
push 1
storem $_6_table
:_6_start_each
loadm $_6_table
readelm *table
jumpf :_6_end_each
loadm $offset
call @plus
call @plot
loadm $_6_table
loadb
incb
moveb
storem $_6_table
jump :_6_start_each
:_6_end_each
push 1
storem $_7_table
:_7_start_each
loadm $_7_table
readelm *table
jumpf :_7_end_each
loadm $offset
call @swap
call @minus
call @plot
loadm $_7_table
loadb
incb
moveb
storem $_7_table
jump :_7_start_each
:_7_end_each
prttimer 0
ret
@~stepX
loadm $x
push 1
call @plus
storem $x
loadm $x
ret
@~sine
push 180
loadm $x
call @minus
loadm $x
call @mul
storem $u
push 4000
loadm $u
call @mul
push 40500
loadm $u
call @minus
call @div
storem $y
done $y
@~makeTable
:_0_condition_start
call @~stepX
push 180
call @neq
loada
testz
clra
jumpf :_0_repeat_end
push 'jobinput_sine'
job @~sine
jump :_0_condition_start
:_0_repeat_end
:_1_condition_start
pending
push 0
call @neq
loada
testz
clra
jumpf :_1_repeat_end
result
jumpf :_2_no_result
loadm $y
storem *table
:_2_no_result
jump :_1_condition_start
:_1_repeat_end
done *table
@__MemAllocGlobels
push 0
storem $offset
push 1000
storem $offset
push 0
storem $x
push 0
storem $x
push 0
storem $y
array *table
push 0
storem *table
push 'jobinput_sine'
index $x
push 'jobinput_makeTable'
index $x
ret
