vsim work.ram
# vsim 
# Start time: 17:23:28 on May 01,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading ieee.numeric_std(body)
# Loading work.ram(syncram)

mem load -i {ram.mem} /ram/ram
add wave -position insertpoint sim:/ram/*

force -freeze sim:/ram/clk 1 10, 0 {60 ns} -r 100
force -freeze sim:/ram/word 0 0
force -freeze sim:/ram/RW 0 0
force -freeze sim:/ram/address 000A 0
run
force -freeze sim:/ram/word 1 0
force -freeze sim:/ram/address 20'h00002 0
run
force -freeze sim:/ram/word 0 0
force -freeze sim:/ram/address 20'h00005 0
run
force -freeze sim:/ram/RW 1 0
force -freeze sim:/ram/datain 00FF 0
force -freeze sim:/ram/address 0008 0
run
force -freeze sim:/ram/RW 0 0
run