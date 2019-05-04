vsim work.datamemcirc
# vsim work.datamemcirc 
# Start time: 06:19:54 on May 04,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.datamemcirc(struct)
# Loading work.memcntrl(struct)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading ieee.numeric_std(body)
# Loading work.ram(syncram)
add wave *
force -freeze sim:/datamemcirc/i_rst 1 0
force -freeze sim:/datamemcirc/i_opcd 0 0
force -freeze sim:/datamemcirc/i_dst 0 0
force -freeze sim:/datamemcirc/i_adrs 0 0
force -freeze sim:/datamemcirc/i_data 11111111 0
force -freeze sim:/datamemcirc/i_clkC 1 10, 0 {60 ps} -r 100
force -freeze sim:/datamemcirc/i_clkM 1 20, 0 {70 ps} -r 100
run
force -freeze sim:/datamemcirc/i_rst 0 0
run
run
force -freeze sim:/datamemcirc/i_opcd 10 0
run
force -freeze sim:/datamemcirc/i_opcd 11 0
run
force -freeze sim:/datamemcirc/i_dst 8 0
run
force -freeze sim:/datamemcirc/i_opcd 14 0
force -freeze sim:/datamemcirc/i_dst 4'h9 0
run
force -freeze sim:/datamemcirc/i_opcd 13 0
run
force -freeze sim:/datamemcirc/i_dst 0 0
run
run
