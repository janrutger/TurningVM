@main
settimer 0
speed 0
push 0
storem $n
push 0
storem $x
push 2
storem $x
array *A1
push 3
storem *A1
push 5
storem *A1
push 6
storem *A1
array *A2
array *A3
loadm $n
prt
loadm $x
prt
loadm *A1
prt
loadm *A2
prt
push 1
prt
push 1
readelm *A1
jumpt :_0_readelm_done
call @__illegal_Array_Index
:_0_readelm_done
prt
push 2
readelm *A1
jumpt :_1_readelm_done
call @__illegal_Array_Index
:_1_readelm_done
prt
push 3
readelm *A1
jumpt :_2_readelm_done
call @__illegal_Array_Index
:_2_readelm_done
prt
push 55
storem $y
loadm $y
prt
push 22
storem *A2
loadm *A2
prt
push 33
storem *A3
loadm *A3
readelm *A3
jumpt :_3_readelm_done
call @__illegal_Array_Index
:_3_readelm_done
prt
array *A2
loadm *A2
prt
push 1
storem $_4_A1
:_4_start_each
loadm $_4_A1
readelm *A1
jumpf :_4_end_each
call @dup
call @mul
prt
loadm $_4_A1
loadb
incb
moveb
storem $_4_A1
jump :_4_start_each
:_4_end_each
prttimer 0
ret
