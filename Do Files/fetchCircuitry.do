vsim work.fetchcirc
# vsim work.fetchcirc 
# Start time: 17:14:19 on May 01,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.fetchcirc(struct)
# Loading work.fetchcontrol(behavioral)
# Loading work.circuitpc(behavioral)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.updwncntr(behavioral)
# Loading ieee.numeric_std(body)
# Loading work.ram(syncram)
mem load -i ram.mem mem
add wave *
force -freeze sim:/fetchcirc/i_rst 1 0
force -freeze sim:/fetchcirc/i_hzrd 0 0
force -freeze sim:/fetchcirc/i_brnch 0 0
force -freeze sim:/fetchcirc/i_adrs 0 0
force -freeze sim:/fetchcirc/i_clkC 1 10, 0 {60 ps} -r 100
force -freeze sim:/fetchcirc/i_clkM 1 20, 0 {60 ps} -r 100
run
force -freeze sim:/fetchcirc/i_rst 0 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 180 ps  Iteration: 0  Instance: /fetchcirc/mem
run
run
run
run
run
run
force -freeze sim:/fetchcirc/i_brnch 1 0
run
run
