@main
settimer 0
call @stackssys
push 'hello\_world\_'
call @char2prtbuff
call @printbuff
prttimer 0
ret
