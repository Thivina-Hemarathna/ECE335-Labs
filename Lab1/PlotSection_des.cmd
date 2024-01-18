Plot{
*--Density and Currents, etc
   eDensity hDensity
   TotalCurrent/Vector eCurrent/Vector hCurrent/Vector
   eMobility hMobility
   eVelocity hVelocity
   eQuasiFermi hQuasiFermi

*--Temperature 
   eTemperature Temperature hTemperature

*--Fields and charges
   ElectricField/Vector Potential SpaceCharge

*--Doping Profiles
   Doping DonorConcentration AcceptorConcentration

*--Generation/Recombination
   SRH Band2Band  Auger
   AvalancheGeneration eAvalancheGeneration hAvalancheGeneration

*--lifetimes
   eLifeTime hLifeTime

*--bandenergy
   ConductionBandEnergy ValenceBandEnergy BandGap
   BarrierTunneling
   eMobilityAniso hMobilityAniso
   eMobilityAnisoFactor hMobilityAnisoFactor
}
