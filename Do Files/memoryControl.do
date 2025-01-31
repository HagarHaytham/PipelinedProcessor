vsim work.memcntrl
# vsim work.memcntrl 
# Start time: 19:49:00 on May 02,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.memcntrl(struct)
add wave *
force -freeze sim:/memcntrl/i_rst 1 0
force -freeze sim:/memcntrl/i_opcd 0 0
force -freeze sim:/memcntrl/i_dst 0 0
force -freeze sim:/memcntrl/i_clk 1 10, 0 {60 ps} -r 100
run
force -freeze sim:/memcntrl/i_rst 0 0
run
run
force -freeze sim:/memcntrl/i_opcd 5'h10 0
run
force -freeze sim:/memcntrl/i_opcd 5'h11 0
run
force -freeze sim:/memcntrl/i_dst 4'h8 0
run
run
force -freeze sim:/memcntrl/i_dst 4'h9 0
force -freeze sim:/memcntrl/i_opcd 5'h14 0
run
run
force -freeze sim:/memcntrl/i_dst 4'ha 0
run
run
