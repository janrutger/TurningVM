@main
settimer 0
speed 0
push 0
call @drawRate
call @drawNew
push 0
push 0
call @draw
push 1
readelm *size
jumpt :_0_readelm_done
call @__illegal_Array_Index
:_0_readelm_done
push 2
readelm *size
jumpt :_1_readelm_done
call @__illegal_Array_Index
:_1_readelm_done
call @draw
call @drawNew
push 0
push 0
call @~(Turtle)goto
array *P3
push 30
storem *P3
push 30
storem *P3
array *P2
push 50
storem *P2
push 10
storem *P2
array *P1
push 10
storem *P1
push 10
storem *P1
loadm $x
readelm *P3
jumpt :_2_readelm_done
call @__illegal_Array_Index
:_2_readelm_done
loadm $y
readelm *P3
jumpt :_3_readelm_done
call @__illegal_Array_Index
:_3_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P2
jumpt :_4_readelm_done
call @__illegal_Array_Index
:_4_readelm_done
loadm $y
readelm *P2
jumpt :_5_readelm_done
call @__illegal_Array_Index
:_5_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P1
jumpt :_6_readelm_done
call @__illegal_Array_Index
:_6_readelm_done
loadm $y
readelm *P1
jumpt :_7_readelm_done
call @__illegal_Array_Index
:_7_readelm_done
call @~(Turtle)goto
call @drawBuff
loadm $x
readelm *P2
jumpt :_8_readelm_done
call @__illegal_Array_Index
:_8_readelm_done
loadm $y
readelm *P2
jumpt :_9_readelm_done
call @__illegal_Array_Index
:_9_readelm_done
call @~(Turtle)line
loadm $x
readelm *P3
jumpt :_10_readelm_done
call @__illegal_Array_Index
:_10_readelm_done
loadm $y
readelm *P3
jumpt :_11_readelm_done
call @__illegal_Array_Index
:_11_readelm_done
call @~(Turtle)line
loadm $x
readelm *P1
jumpt :_12_readelm_done
call @__illegal_Array_Index
:_12_readelm_done
loadm $y
readelm *P1
jumpt :_13_readelm_done
call @__illegal_Array_Index
:_13_readelm_done
call @~(Turtle)line
call @drawBuff
array *P3
push 80
storem *P3
push 45
storem *P3
array *P2
push 100
storem *P2
push 10
storem *P2
array *P1
push 60
storem *P1
push 10
storem *P1
loadm $x
readelm *P3
jumpt :_14_readelm_done
call @__illegal_Array_Index
:_14_readelm_done
loadm $y
readelm *P3
jumpt :_15_readelm_done
call @__illegal_Array_Index
:_15_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P2
jumpt :_16_readelm_done
call @__illegal_Array_Index
:_16_readelm_done
loadm $y
readelm *P2
jumpt :_17_readelm_done
call @__illegal_Array_Index
:_17_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P1
jumpt :_18_readelm_done
call @__illegal_Array_Index
:_18_readelm_done
loadm $y
readelm *P1
jumpt :_19_readelm_done
call @__illegal_Array_Index
:_19_readelm_done
call @~(Turtle)goto
call @drawBuff
loadm $x
readelm *P2
jumpt :_20_readelm_done
call @__illegal_Array_Index
:_20_readelm_done
loadm $y
readelm *P2
jumpt :_21_readelm_done
call @__illegal_Array_Index
:_21_readelm_done
call @~(Turtle)line
loadm $x
readelm *P3
jumpt :_22_readelm_done
call @__illegal_Array_Index
:_22_readelm_done
loadm $y
readelm *P3
jumpt :_23_readelm_done
call @__illegal_Array_Index
:_23_readelm_done
call @~(Turtle)line
loadm $x
readelm *P1
jumpt :_24_readelm_done
call @__illegal_Array_Index
:_24_readelm_done
loadm $y
readelm *P1
jumpt :_25_readelm_done
call @__illegal_Array_Index
:_25_readelm_done
call @~(Turtle)line
call @drawBuff
array *P3
push 130
storem *P3
push 55
storem *P3
array *P2
push 150
storem *P2
push 10
storem *P2
array *P1
push 110
storem *P1
push 10
storem *P1
loadm $x
readelm *P3
jumpt :_26_readelm_done
call @__illegal_Array_Index
:_26_readelm_done
loadm $y
readelm *P3
jumpt :_27_readelm_done
call @__illegal_Array_Index
:_27_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P2
jumpt :_28_readelm_done
call @__illegal_Array_Index
:_28_readelm_done
loadm $y
readelm *P2
jumpt :_29_readelm_done
call @__illegal_Array_Index
:_29_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P1
jumpt :_30_readelm_done
call @__illegal_Array_Index
:_30_readelm_done
loadm $y
readelm *P1
jumpt :_31_readelm_done
call @__illegal_Array_Index
:_31_readelm_done
call @~(Turtle)goto
call @drawBuff
loadm $x
readelm *P2
jumpt :_32_readelm_done
call @__illegal_Array_Index
:_32_readelm_done
loadm $y
readelm *P2
jumpt :_33_readelm_done
call @__illegal_Array_Index
:_33_readelm_done
call @~(Turtle)line
loadm $x
readelm *P3
jumpt :_34_readelm_done
call @__illegal_Array_Index
:_34_readelm_done
loadm $y
readelm *P3
jumpt :_35_readelm_done
call @__illegal_Array_Index
:_35_readelm_done
call @~(Turtle)line
loadm $x
readelm *P1
jumpt :_36_readelm_done
call @__illegal_Array_Index
:_36_readelm_done
loadm $y
readelm *P1
jumpt :_37_readelm_done
call @__illegal_Array_Index
:_37_readelm_done
call @~(Turtle)line
call @drawBuff
array *P3
push 30
storem *P3
push 30
storem *P3
array *P2
push 50
storem *P2
push 75
storem *P2
array *P1
push 10
storem *P1
push 75
storem *P1
loadm $x
readelm *P3
jumpt :_38_readelm_done
call @__illegal_Array_Index
:_38_readelm_done
loadm $y
readelm *P3
jumpt :_39_readelm_done
call @__illegal_Array_Index
:_39_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P2
jumpt :_40_readelm_done
call @__illegal_Array_Index
:_40_readelm_done
loadm $y
readelm *P2
jumpt :_41_readelm_done
call @__illegal_Array_Index
:_41_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P1
jumpt :_42_readelm_done
call @__illegal_Array_Index
:_42_readelm_done
loadm $y
readelm *P1
jumpt :_43_readelm_done
call @__illegal_Array_Index
:_43_readelm_done
call @~(Turtle)goto
call @drawBuff
loadm $x
readelm *P2
jumpt :_44_readelm_done
call @__illegal_Array_Index
:_44_readelm_done
loadm $y
readelm *P2
jumpt :_45_readelm_done
call @__illegal_Array_Index
:_45_readelm_done
call @~(Turtle)line
loadm $x
readelm *P3
jumpt :_46_readelm_done
call @__illegal_Array_Index
:_46_readelm_done
loadm $y
readelm *P3
jumpt :_47_readelm_done
call @__illegal_Array_Index
:_47_readelm_done
call @~(Turtle)line
loadm $x
readelm *P1
jumpt :_48_readelm_done
call @__illegal_Array_Index
:_48_readelm_done
loadm $y
readelm *P1
jumpt :_49_readelm_done
call @__illegal_Array_Index
:_49_readelm_done
call @~(Turtle)line
call @drawBuff
array *P3
push 80
storem *P3
push 45
storem *P3
array *P2
push 100
storem *P2
push 75
storem *P2
array *P1
push 60
storem *P1
push 75
storem *P1
loadm $x
readelm *P3
jumpt :_50_readelm_done
call @__illegal_Array_Index
:_50_readelm_done
loadm $y
readelm *P3
jumpt :_51_readelm_done
call @__illegal_Array_Index
:_51_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P2
jumpt :_52_readelm_done
call @__illegal_Array_Index
:_52_readelm_done
loadm $y
readelm *P2
jumpt :_53_readelm_done
call @__illegal_Array_Index
:_53_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P1
jumpt :_54_readelm_done
call @__illegal_Array_Index
:_54_readelm_done
loadm $y
readelm *P1
jumpt :_55_readelm_done
call @__illegal_Array_Index
:_55_readelm_done
call @~(Turtle)goto
call @drawBuff
loadm $x
readelm *P2
jumpt :_56_readelm_done
call @__illegal_Array_Index
:_56_readelm_done
loadm $y
readelm *P2
jumpt :_57_readelm_done
call @__illegal_Array_Index
:_57_readelm_done
call @~(Turtle)line
loadm $x
readelm *P3
jumpt :_58_readelm_done
call @__illegal_Array_Index
:_58_readelm_done
loadm $y
readelm *P3
jumpt :_59_readelm_done
call @__illegal_Array_Index
:_59_readelm_done
call @~(Turtle)line
loadm $x
readelm *P1
jumpt :_60_readelm_done
call @__illegal_Array_Index
:_60_readelm_done
loadm $y
readelm *P1
jumpt :_61_readelm_done
call @__illegal_Array_Index
:_61_readelm_done
call @~(Turtle)line
call @drawBuff
array *P3
push 130
storem *P3
push 55
storem *P3
array *P2
push 150
storem *P2
push 75
storem *P2
array *P1
push 110
storem *P1
push 75
storem *P1
loadm $x
readelm *P3
jumpt :_62_readelm_done
call @__illegal_Array_Index
:_62_readelm_done
loadm $y
readelm *P3
jumpt :_63_readelm_done
call @__illegal_Array_Index
:_63_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P2
jumpt :_64_readelm_done
call @__illegal_Array_Index
:_64_readelm_done
loadm $y
readelm *P2
jumpt :_65_readelm_done
call @__illegal_Array_Index
:_65_readelm_done
call @~(Turtle)goto
loadm $x
readelm *P1
jumpt :_66_readelm_done
call @__illegal_Array_Index
:_66_readelm_done
loadm $y
readelm *P1
jumpt :_67_readelm_done
call @__illegal_Array_Index
:_67_readelm_done
call @~(Turtle)goto
call @drawBuff
loadm $x
readelm *P2
jumpt :_68_readelm_done
call @__illegal_Array_Index
:_68_readelm_done
loadm $y
readelm *P2
jumpt :_69_readelm_done
call @__illegal_Array_Index
:_69_readelm_done
call @~(Turtle)line
loadm $x
readelm *P3
jumpt :_70_readelm_done
call @__illegal_Array_Index
:_70_readelm_done
loadm $y
readelm *P3
jumpt :_71_readelm_done
call @__illegal_Array_Index
:_71_readelm_done
call @~(Turtle)line
loadm $x
readelm *P1
jumpt :_72_readelm_done
call @__illegal_Array_Index
:_72_readelm_done
loadm $y
readelm *P1
jumpt :_73_readelm_done
call @__illegal_Array_Index
:_73_readelm_done
call @~(Turtle)line
call @drawBuff
call @drawBuff
prttimer 0
ret
@__MemAllocGlobels
call @init_vmachine
array *size
push 160
storem *size
push 80
storem *size
push 0
storem $x
push 1
storem $x
push 0
storem $y
push 2
storem $y
call @~(Turtle)INIT
ret
