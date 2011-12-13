
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name piano -dir "X:/Xilinx/piano/planAhead_run_1" -part xc3s1000ft256-5
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property top pianomain $srcset
set_param project.paUcfFile  "pianomain.ucf"
set hdlfile [add_files [list {wave_luts.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {volume_control.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {sumer.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {sin_generator.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {lib.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {pianomain.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
add_files "pianomain.ucf" -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s1000ft256-5
