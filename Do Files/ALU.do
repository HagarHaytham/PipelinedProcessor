add wave -position insertpoint sim:/alu/*
force -freeze sim:/alu/s 00000 0
force -freeze sim:/alu/flagsIn 000 0
run
force -freeze sim:/alu/b 00000000000000 0
force -freeze sim:/alu/a 0000000000000000 0
force -freeze sim:/alu/s 00000 0
force -freeze sim:/alu/flagsIn 000 0
run
