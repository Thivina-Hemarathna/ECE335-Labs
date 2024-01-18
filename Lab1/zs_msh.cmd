Title ""

Controls {
}

Definitions {
	Constant "Const.sub" {
		Species = "ArsenicActiveConcentration"
		Value = 1e+19
	}
	Constant "Const.drift" {
		Species = "ArsenicActiveConcentration"
		Value = 1e+16
	}
	Constant "Const.pbl" {
		Species = "BoronActiveConcentration"
		Value = 5e+18
	}
	Refinement "Ref.drift" {
		MaxElementSize = ( 0.5 0.5 )
		MinElementSize = ( 0.05 0.05 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 0.5)
	}
	Refinement "RefDef.top" {
		MaxElementSize = ( 0.1 0.1 )
		MinElementSize = ( 0.01 0.01 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
		RefineFunction = MaxLenInt(Interface("Silicon","Oxide"), Value=0.2, factor=4)
	}
	Refinement "RefDef.bot" {
		MaxElementSize = ( 0.1 0.1 )
		MinElementSize = ( 0.01 0.01 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
		RefineFunction = MaxLenInt(Interface("Silicon","Oxide"), Value=0.2, factor=4)
	}
}

Placements {
	Constant "PlaceCD.sub" {
		Reference = "Const.sub"
		EvaluateWindow {
			Element = region ["ndope"]
		}
	}
	Constant "PlaceCD.drift" {
		Reference = "Const.drift"
		EvaluateWindow {
			Element = region ["drift"]
		}
	}
	Constant "PlaceCD.pbl" {
		Reference = "Const.pbl"
		EvaluateWindow {
			Element = region ["pdope"]
		}
	}
	Refinement "RefPlace.drift" {
		Reference = "Ref.drift"
		RefineWindow = Rectangle [(0 0) (4 9)]
	}
	Refinement "Place.top" {
		Reference = "RefDef.bot"
		RefineWindow = Rectangle [(0 0) (4 1)]
	}
	Refinement "Place.bot" {
		Reference = "RefDef.bot"
		RefineWindow = Rectangle [(0 6.5) (4 7.5)]
	}
}

