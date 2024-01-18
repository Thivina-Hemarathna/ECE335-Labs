


File {
   * input files:
   Grid=   "n3_msh.tdr"
   Parameter="pp16_des.par"
   * output files:
   Plot=   "n16_des.tdr"
   Current="n16_des.plt"
   Output= "n16_des.log"
}

Electrode {
   { Name="source"    Voltage= 0.0 Resistor= 40 }
   { Name="drain"     Voltage= 0.0 Resistor= 40 }
   { Name="gate"      Voltage= 0.0 }
   { Name="substrate" Voltage= 0.0 }
}

Thermode{
   { Name="substrate" Temperature= 300 } 
}

Physics{
   Hydrodynamic(eTemperature
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
   Coupled { Poisson eQuantumPotential Electron Hole Temperature eTemperature
 }

*- Ramp to gate to Vgmax
   Quasistationary( 
      InitialStep= 1e-5 Increment= 2 
      MinStep= 1e-6 MaxStep= 0.5 
      Goal { Name="gate" Voltage=1.0
} 
   ){ Coupled { Poisson eQuantumPotential Electron Hole Temperature eTemperature
 }  
      Save( FilePrefix="IdVd_n16" NoOverWrite
Time=(0.20;0.40;0.60;0.80;1.00) )

   }

*- Vd sweeps 

    NewCurrentFile="IdVd_0_" 
    Load(FilePrefix="IdVd_n16_0000")
    Quasistationary( 
      DoZero 
      InitialStep=1e-3 Increment=1.5 
      MinStep=1e-5 MaxStep=0.05 
      Goal { Name="drain" Voltage=1.0 }
    ){ Coupled { Poisson eQuantumPotential Electron Hole Temperature eTemperature }
      CurrentPlot( Time=(Range=(0 1) Intervals=20) )
   }

    NewCurrentFile="IdVd_1_" 
    Load(FilePrefix="IdVd_n16_0001")
    Quasistationary( 
      DoZero 
      InitialStep=1e-3 Increment=1.5 
      MinStep=1e-5 MaxStep=0.05 
      Goal { Name="drain" Voltage=1.0 }
    ){ Coupled { Poisson eQuantumPotential Electron Hole Temperature eTemperature }
      CurrentPlot( Time=(Range=(0 1) Intervals=20) )
   }

    NewCurrentFile="IdVd_2_" 
    Load(FilePrefix="IdVd_n16_0002")
    Quasistationary( 
      DoZero 
      InitialStep=1e-3 Increment=1.5 
      MinStep=1e-5 MaxStep=0.05 
      Goal { Name="drain" Voltage=1.0 }
    ){ Coupled { Poisson eQuantumPotential Electron Hole Temperature eTemperature }
      CurrentPlot( Time=(Range=(0 1) Intervals=20) )
   }

    NewCurrentFile="IdVd_3_" 
    Load(FilePrefix="IdVd_n16_0003")
    Quasistationary( 
      DoZero 
      InitialStep=1e-3 Increment=1.5 
      MinStep=1e-5 MaxStep=0.05 
      Goal { Name="drain" Voltage=1.0 }
    ){ Coupled { Poisson eQuantumPotential Electron Hole Temperature eTemperature }
      CurrentPlot( Time=(Range=(0 1) Intervals=20) )
   }

    NewCurrentFile="IdVd_4_" 
    Load(FilePrefix="IdVd_n16_0004")
    Quasistationary( 
      DoZero 
      InitialStep=1e-3 Increment=1.5 
      MinStep=1e-5 MaxStep=0.05 
      Goal { Name="drain" Voltage=1.0 }
    ){ Coupled { Poisson eQuantumPotential Electron Hole Temperature eTemperature }
      CurrentPlot( Time=(Range=(0 1) Intervals=20) )
   }


}




