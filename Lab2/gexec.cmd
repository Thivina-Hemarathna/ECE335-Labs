# project name
name Project_2
# execution graph
job 3   -post { extract_vars "$nodedir" n3_dvs.out 3 }  -o n3_dvs "sde -e -l n3_dvs.cmd"
job 8 -d "7"  -post { extract_vars "$nodedir" n8_vis.out 8 }  -o n8_vis "svisual n8_vis.tcl"
job 11 -d "10"  -post { extract_vars "$nodedir" n11_vis.out 11 }  -o n11_vis "svisual n11_vis.tcl"
job 17 -d "16"  -post { extract_vars "$wdir" n17_vis.out 17 }  -o n17_vis "svisual n17_vis.tcl"
job 7 -d "3"  -post { extract_vars "$wdir" n7_des.out 7 }  -o n7_des "sdevice pp7_des.cmd"
job 10 -d "3"  -post { extract_vars "$wdir" n10_des.out 10 }  -o n10_des "sdevice pp10_des.cmd"
job 16 -d "3"  -post { extract_vars "$wdir" n16_des.out 16 }  -o n16_des "sdevice pp16_des.cmd"
check sde_dvs.cmd 1701852041
check IdVg_lin_des.cmd 1478476194
check sdevice.par 1478476195
check PlotIdVg_lin_vis.tcl 1478476195
check IdVg_sat_des.cmd 1478476194
check PlotIdVg_sat_vis.tcl 1478476195
check IdVd_des.cmd 1478476194
check PlotIdVd_vis.tcl 1478476195
check global_tooldb 1665432052
check gtree.dat 1701850784
check gtooldb.tcl 1478476195
check Si.par 1478476195
# included files
file sdevice.par included Si.par
