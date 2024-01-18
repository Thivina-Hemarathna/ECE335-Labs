
ext::SetInfoDef 1
set N     17
set i     1
set Lg    0.045
set Type  nMOS
set Vdd   1

puts ""
puts "Gate Length: $Lg um \n"

set COLORS  [list green blue red orange magenta violet brown]
set NCOLORS [llength $COLORS]
set color   [lindex  $COLORS [expr $i%$NCOLORS]]

echo "##############################"
echo "plotting Id-Vds curves"
echo "##############################"
if {[lsearch [list_plots] Plot_IdVd] == -1} {
	create_plot -1d -name Plot_IdVd
}
select_plots Plot_IdVd

set IDVDs [lsort [glob IdVd_?_n16_des.plt]]
set i 0
foreach IDVD $IDVDs {
	load_file $IDVD -name PLT($N,$i) 
	set color   [lindex  $COLORS [expr $i%$NCOLORS]]
	set Vg [lindex [get_variable_data "gate OuterVoltage" -dataset PLT($N,$i)] 0]
	set NAME ${Type}_${Vg}_$N
	create_curve -name ${NAME}_tmp -dataset PLT($N,$i) \
		-axisX "drain OuterVoltage" -axisY "drain TotalCurrent"
	create_curve -name $NAME -function "abs(<${NAME}_tmp>)"	
	remove_curves ${NAME}_tmp
	set_curve_prop $NAME -label "IdVd ($Type Lg=$Lg Vg=$Vg)" \
		-color $color -line_style solid -line_width 3

	incr i
}
set i [expr $i-1]

set_plot_prop -title "I<sub>d</sub>-V<sub>ds</sub> Curve" -title_font_size 20 
set_axis_prop -axis x -title {Drain Voltage [V]} \
	-title_font_size 16 -scale_font_size 14 -type linear 
set_axis_prop -axis y -title {Drain Current [A/<greek>m</greek>m]} \
	-title_font_size 16 -scale_font_size 14 -type linear
set_legend_prop -font_size 12 -font_att bold \
-location top_left 

puts "#########################################"
puts "extracting parameters from Id-Vd curve"
puts "#########################################"
set Vds [get_variable_data "drain OuterVoltage" -dataset PLT($N,$i)]
set Ids [get_variable_data "drain TotalCurrent" -dataset PLT($N,$i)]

set SIGN 1.0

ext::ExtractRdiff out= Ron name= "out" v= $Vds i= $Ids vo= [expr 0.8*$SIGN*$Vdd]
echo "Ron is [format %.3f $Ron] Ohm um"

