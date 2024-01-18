
ext::SetInfoDef 1

set N     11
set i     1
set Lg    0.045
set Vd    1.2
set Vg    1.2
set Type  nMOS
puts ""
puts "Gate Length: $Lg um \n"

set ID "$Type"
set N   ${Type}_${N}

set COLORS  [list green blue red orange magenta violet brown]
set NCOLORS [llength $COLORS]
set color   [lindex  $COLORS [expr $i%$NCOLORS]]

echo "#########################################"
echo "Plotting Id-Vg (sat) curve"
echo "#########################################"
load_file IdVg_n10_des.plt -name PLT_Sat($N)

if {[lsearch [list_plots] Plot_IdVg] == -1} {
	create_plot -1d -name Plot_IdVg
}
select_plots Plot_IdVg

set Vgs [get_variable_data "gate OuterVoltage" -dataset PLT_Sat($N)]
set Ids [get_variable_data "drain TotalCurrent" -dataset PLT_Sat($N)]
ext::AbsList out= absIds x= $Ids ;# Compute absolute value of drain currents
create_variable -name absId -dataset PLT_Sat($N) -values $absIds


create_curve -name IdVgSat($N) -dataset PLT_Sat($N) \
	-axisX "gate OuterVoltage" -axisY "absId"
	
set_curve_prop IdVgSat($N) -label "IdVg(Sat) ($ID Lg=$Lg Vd=$Vd)" \
	-color $color -line_style solid -line_width 3
	 
set_plot_prop -title "I<sub>d</sub>-V<sub>gs</sub> Curve" -title_font_size 20
set_axis_prop -axis x -title {Gate Voltage [V]} \
	-title_font_size 16 -scale_font_size 14 -type linear 
set_axis_prop -axis y -title {Drain Current [A/<greek>m</greek>m]} \
	-title_font_size 16 -scale_font_size 14 -type log
set_legend_prop -font_size 12 -location bottom_right -font_att bold

echo "#########################################"
echo "Extracting parameters from Id-Vgs (sat) curve"
echo "#########################################"

set Io    [expr 100e-9/$Lg] ; # [A/um]

set SIGN 1.0

ext::ExtractVti 	 out= Vti    name= "VtiSat" v= $Vgs i= $absIds io= $Io 
ext::ExtractExtremum out= Idmax  name= "IdSat"  x= $Vgs y= $absIds extremum= "max"
ext::ExtractIoff     out= Ioff   name= "out"    v= $Vgs i= $absIds vo= [expr $SIGN*1e-4] 
ext::ExtractSS       out= SS     name= "SSsat"  v= $Vgs i= $absIds vo= [expr $SIGN*1e-2] 
ext::ExtractGm       out= gm     name= "gmSat"  v= $Vgs i= $absIds 

echo "Vti (Vg at Io= [format %.3e $Io] A/um) is [format %.3f $Vti] V"
echo "Max IdSat is [format %.3e $Idmax] A/um"
echo "Ioff is [format %.3e $Ioff] A/um"
echo "SSsat is [format %.3f $SS] mV/dec"
echo "Max gm is [format %.3e $gm] S/um"

