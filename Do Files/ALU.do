vsim -gui work.alu
add wave -position insertpoint sim:/alu/*

############# 1 operand operations #########
# NOP 00
force -freeze sim:/alu/a 0000000000000000 0
force -freeze sim:/alu/b 0000000000000000 0
force -freeze sim:/alu/s 00000 0
force -freeze sim:/alu/flagsIn 000 0
run

# SetC 01
force -freeze sim:/alu/s 00001 0
run

# CLRC 02
force -freeze sim:/alu/s 00010 0
run

#NOT 
force -freeze sim:/alu/s 00011 0
run

#INC
force -freeze sim:/alu/a 0000000000000011 0
force -freeze sim:/alu/s 00100 0
run

#DEC 
force -freeze sim:/alu/s 00101 0
run


############# 2 operand operations #########

#MOV 01000
force -freeze sim:/alu/a 0000000000000001 0
force -freeze sim:/alu/b 0000000000000000 0
force -freeze sim:/alu/s 01000 0
run

#Add 01001
force -freeze sim:/alu/a 1111111111111111 0
force -freeze sim:/alu/b 0000000000000001 0
force -freeze sim:/alu/s 01001 0
run

#Add 01001
force -freeze sim:/alu/a 0000000000000010 0
force -freeze sim:/alu/b 0000000000000011 0
force -freeze sim:/alu/s 01001 0
run

#SUB 01010
force -freeze sim:/alu/a 0000000000000011 0
force -freeze sim:/alu/b 0000000000000010 0
force -freeze sim:/alu/s 01010 0
run

#AND 01011
force -freeze sim:/alu/a 0000000000000011 0
force -freeze sim:/alu/b 0000000000000010 0
force -freeze sim:/alu/s 01011 0
run


#OR 01100
force -freeze sim:/alu/a 0000000000000011 0
force -freeze sim:/alu/b 0000000000000010 0
force -freeze sim:/alu/s 01100 0
run


#SHR 
force -freeze sim:/alu/a 0000000000000001 0
force -freeze sim:/alu/b 0000000000000001 0
force -freeze sim:/alu/s 01110 0
run

#SHR a =64 c = 0C 
force -freeze sim:/alu/a 0000000001100100 0
force -freeze sim:/alu/b 0000000000000011 0
force -freeze sim:/alu/s 01110 0
run

#SHL a=19 C--> 0, N -->0 , Z -->0
force -freeze sim:/alu/a 0000000000011001 0
force -freeze sim:/alu/b 0000000000000010 0
force -freeze sim:/alu/s 01101 0
run

#SHL 
force -freeze sim:/alu/a 1000000000000000 0
force -freeze sim:/alu/b 0000000000000001 0
force -freeze sim:/alu/s 01101 0
run

#not alu operation
force -freeze sim:/alu/s 11101 0
run