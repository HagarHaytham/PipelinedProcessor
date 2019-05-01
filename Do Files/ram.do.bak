vsim -gui work.ram
# vsim 
# Start time: 15:50:51 on May 01,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading ieee.numeric_std(body)
# Loading work.ram(syncram)
add wave -position insertpoint sim:/ram/*
force -freeze sim:/ram/clk 1 10, 0 {60 ns} -r 100
force -freeze sim:/ram/word 0 0
force -freeze sim:/ram/RW 0 0
force -freeze sim:/ram/address 001 0
run
force -freeze sim:/ram/word 1 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 1010 ns  Iteration: 0  Instance: /ram
force -freeze sim:/ram/RW 1 0
force -freeze sim:/ram/datain 0103 0
force -freeze sim:/ram/address 003 0
run

force -freeze sim:/ram/datain 0103 0