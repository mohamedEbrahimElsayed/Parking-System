create_project project_2 D:/digital assignments/Projects -part xc7a35ticpg236-1l -force

add_files parking_system.v parking_basys_master.xdc

synth_design -rtl -top parking_system > elab.log

write_schematic elaborated_schematic.pdf -format pdf -force 

launch_runs synth_1 > synth.log

wait_on_run synth_1
open_run synth_1

write_schematic synthesized_schematic.pdf -format pdf -force 

write_verilog -force parking_sys_netlist.v

launch_runs impl_1 -to_step write_bitstream 

wait_on_run impl_1
open_run impl_1

open_hw

connect_hw_server