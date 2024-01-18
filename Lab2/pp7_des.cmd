


File {
   * input files:
   Grid=   "n3_msh.tdr"
   Parameter="pp7_des.par"
   * output files:
   Plot=   "n7_des.tdr"
   Current="n7_des.plt"
   Output= "n7_des.log"
}

Electrode {
   { Name="source"    Voltage= 0.0 Resistor= 40 }
   { Name="drain"     Voltage= 0.0 Resistor= 40 }
   { Name="gate"      Voltage= 0.0 }
   { Name="substrate" Voltage= 0.0 }
}

Physics{
   Hydrodynamic( eTemperature
 )
   EffectiveIntrinsicDensity(BandGapNarrowing ( OldSlotboom ))    
}

Physics(Material="Silicon"){
   eQuantumPotential

   Mobility(
      PhuMob
	  HighFieldSaturation
      Enormal
   )
   Recombination(
      SRH( DopingDependence )
      Band2Band
   )           
}

Insert= "PlotSection_des.cmd"
Insert= "MathSection_des.cmd"

Solve {
*- Creating initial guess:
   Coupled(Iterations= 100 LineSearchDamping= 1e-4){ Poisson eQuantumPotential
 } 
   Coupled { Poisson eQuantumPotential Electron Hole
 }
   Coupled { Poisson eQuantumPotential Electron Hole eTemperature
 }

*- Ramp to drain to Vd
   Quasistationary( 
      InitialStep= 1e-2 Increment= 1.35 
      MinStep= 1e-5 MaxStep= 0.2 
      Goal { Name="drain" Voltage=0.05
 } 
   ){ Coupled { Poisson eQuantumPotential Electron Hole eTemperature
 } } 

*- Vg sweep 
   NewCurrentFile="IdVg_" 
   Quasistationary( 
      DoZero 
      InitialStep= 1e-3 Increment= 1.5 
      MinStep= 1e-5 MaxStep= 0.04
      Goal { Name="gate" Voltage=1.2
 } 
   ){ Coupled { Poisson eQuantumPotential Electron Hole eTemperature
 } 
      CurrentPlot( Time=(Range=(0 1) Intervals= 30)  )
   }
}



