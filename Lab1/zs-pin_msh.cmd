Title ""

Controls {
}

Definitions {
	Constant "DC.pA" {
		Species = "BoronActiveConcentration"
		Value = 1e+19
	}
	Constant "DC.nS" {
		Species = "PhosphorusActiveConcentration"
		Value = 2e+18
	}
	Constant "Impl.drift" {
		Species = "PhosphorusActiveConcentration"
		Value = 5e+15
	}
	Refinement "RefDef.global" {
		MaxElementSize = ( 0.5 0.5 )
		MinElementSize = ( 0.05 0.05 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
		RefineFunction = MaxLenInt(Interface("Silicon","Oxide"), Value=0.1, factor=1.5)
	}
	Refinement "RefDef.anode" {
		MaxElementSize = ( 0.1 0.1 )
		MinElementSize = ( 0.05 0.05 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
		RefineFunction = MaxLenInt(Interface("Silicon","Oxide"), Value=0.1, factor=1.5)
	}
	Refinement "RefDef.cathode" {
		MaxElementSize = ( 0.1 0.1 )
		MinElementSize = ( 0.05 0.05 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
		RefineFunction = MaxLenInt(Interface("Silicon","Oxide"), Value=0.1, factor=1.5)
	}
}

Placements {
	Constant "CPP.pA" {
		Reference = "DC.pA"
		Replace
		EvaluateWindow {
			Element = Rectangle [(0 0) (4 0.5)]
		}
	}
	Constant "CPP.nS" {
		Reference = "DC.nS"
		Replace
		EvaluateWindow {
			Element = Rectangle [(0 5.5) (4 6)]
		}
	}
	Constant "Place.drift" {
		Reference = "Impl.drift"
		EvaluateWindow {
			Element = Rectangle [(0 0.5) (4 5.5)]
		}
	}
	Refinement "Place.global" {
		Reference = "RefDef.global"
		RefineWindow = Rectangle [(0 0) (4 6)]
	}
	Refinement "Place.anode" {
		Reference = "RefDef.anode"
		RefineWindow = Rectangle [(0 0.2) (4 4.5)]
	}
	Refinement "Place.cathode" {
		Reference = "RefDef.cathode"
		RefineWindow = Rectangle [(0 5) (4 6)]
	}
}

