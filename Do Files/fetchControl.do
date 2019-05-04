vsim work.fetchcontrol
# vsim work.fetchcontrol 
# Start time: 15:00:34 on May 01,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.fetchcontrol(behavioral)
add wave *
force -freeze sim:/fetchcontrol/i_rst 1 0
force -freeze sim:/fetchcontrol/i_hzrd 0 0
force -freeze sim:/fetchcontrol/i_brnch 0 0
force -freeze sim:/fetchcontrol/i_clk 1 10, 0 {60 ps} -r 100
run
force -freeze sim:/fetchcontrol/i_rst 0 0
run
run
run
force -freeze sim:/fetchcontrol/i_hzrd 1 0
run
run
run
force -freeze sim:/fetchcontrol/i_brnch 1 0
run
run
force -freeze sim:/fetchcontrol/i_hzrd 0 0
run
run
run
run
force -freeze sim:/fetchcontrol/i_brnch 0 0
run
run
run
run
run
force -freeze sim:/fetchcontrol/i_rst 1 0
run
run
force -freeze sim:/fetchcontrol/i_rst 0 0
run
run
