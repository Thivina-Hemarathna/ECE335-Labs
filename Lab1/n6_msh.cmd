Title ""

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "DC.pA" {
		Species = "BoronActiveConcentration"
		Value = 7e+18
	}
	Constant "DC.nS" {
		Species = "ArsenicActiveConcentration"
		Value = 1e+15
	}
	Refinement "RefDef.global" {
		MaxElementSize = ( 0.5 0.5 )
		MinElementSize = ( 0.1 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
		RefineFunction = MaxLenInt(Interface("Silicon","Oxide"), Value=0.1, factor=1.5)
	}
}

Placements {
	Constant "CPP.pA" {
		Reference = "DC.pA"
		Replace
		EvaluateWindow {
			Element = Rectangle [(0 2) (1 6)]
		}
	}
	Constant "CPP.nS" {
		Reference = "DC.nS"
		Replace
		EvaluateWindow {
			Element = Rectangle [(0 0) (1 2)]
		}
	}
	Refinement "Place.global" {
		Reference = "RefDef.global"
		RefineWindow = Rectangle [(0 0) (1 6)]
	}
}

