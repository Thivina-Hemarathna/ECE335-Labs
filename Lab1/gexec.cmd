# project name
name ECE335_Project_1_2023
# execution graph
job 32 -d "1"  -post { extract_vars "$nodedir" n32_des.out 32 }  -o n32_des "sdevice pp32_des.cmd"
job 38 -d "1"  -post { extract_vars "$nodedir" n38_des.out 38 }  -o n38_des "sdevice pp38_des.cmd"
job 1   -post { extract_vars "$nodedir" n1_dvs.out 1 }  -o n1_dvs "sde -e -l n1_dvs.cmd"
job 6   -post { extract_vars "$nodedir" n6_dvs.out 6 }  -o n6_dvs "sde -e -l n6_dvs.cmd"
job 4   -post { extract_vars "$nodedir" n4_dvs.out 4 }  -o n4_dvs "sde -e -l n4_dvs.cmd"
job 39 -d "1"  -post { extract_vars "$wdir" n39_des.out 39 }  -o n39_des "sdevice pp39_des.cmd"
job 40 -d "4"  -post { extract_vars "$wdir" n40_des.out 40 }  -o n40_des "sdevice pp40_des.cmd"
job 41 -d "4"  -post { extract_vars "$wdir" n41_des.out 41 }  -o n41_des "sdevice pp41_des.cmd"
job 42 -d "6"  -post { extract_vars "$wdir" n42_des.out 42 }  -o n42_des "sdevice pp42_des.cmd"
job 43 -d "6"  -post { extract_vars "$wdir" n43_des.out 43 }  -o n43_des "sdevice pp43_des.cmd"
job 8 -d "1"  -post { extract_vars "$wdir" n8_des.out 8 }  -o n8_des "sdevice pp8_des.cmd"
job 9 -d "4"  -post { extract_vars "$wdir" n9_des.out 9 }  -o n9_des "sdevice pp9_des.cmd"
job 10 -d "6"  -post { extract_vars "$wdir" n10_des.out 10 }  -o n10_des "sdevice pp10_des.cmd"
job 35 -d "1"  -post { extract_vars "$wdir" n35_des.out 35 }  -o n35_des "sdevice pp35_des.cmd"
job 36 -d "4"  -post { extract_vars "$wdir" n36_des.out 36 }  -o n36_des "sdevice pp36_des.cmd"
job 37 -d "6"  -post { extract_vars "$wdir" n37_des.out 37 }  -o n37_des "sdevice pp37_des.cmd"
check sde_dvs.cmd 1700366214
check sdevice_des.cmd 1700366280
check sdevice.par 1700224403
check sdevice1_des.cmd 1700355913
check global_tooldb 1665432052
check gtree.dat 1700225678
check ./sdevice_Silicon.par 1700224404
# included files
file sdevice.par included ./sdevice_Silicon.par
