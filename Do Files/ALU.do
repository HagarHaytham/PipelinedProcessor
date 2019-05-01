vsim -gui work.alu
add wave -position insertpoint sim:/alu/*
# NOP
force -freeze sim:/alu/b 00000000000000 0
force -freeze sim:/alu/a 0000000000000000 0
force -freeze sim:/alu/s 00000 0
force -freeze sim:/alu/flagsIn 000 0
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

