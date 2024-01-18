Title ""

Controls {
}

Definitions {
	Constant "DC.sub" {
		Species = "BoronActiveConcentration"
		Value = 1e+17
	}
	Constant "DC.nregion" {
		Species = "PhosphorusActiveConcentration"
		Value = 1e+19
	}
	Constant "DC.pregion" {
		Species = "BoronActiveConcentration"
		Value = 1e+19
	}
	Refinement "RS.global" {
		MaxElementSize = ( 0.1 0.01 )
		MinElementSize = ( 0.05 0.005 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Refinement "RS.junction" {
		MaxElementSize = ( 0.05 0.01 )
		MinElementSize = ( 0.01 0.005 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
}

Placements {
	Constant "CPM.sub" {
		Reference = "DC.sub"
		EvaluateWindow {
			Element = region ["R.sub"]
		}
	}
	Constant "CPP.nregion" {
		Reference = "DC.nregion"
		EvaluateWindow {
			Element = Polygon [ (0 0) (2.2 0) (3 0) (3 1) (0 1)]
		}
	}
	Constant "CPP.pregion" {
		Reference = "DC.pregion"
		EvaluateWindow {
			Element = Rectangle [(0 0) (2 1)]
		}
	}
	Refinement "RP.global" {
		Reference = "RS.global"
		RefineWindow = Rectangle [(0 0) (3 3)]
	}
	Refinement "RP.junction" {
		Reference = "RS.junction"
		RefineWindow = Rectangle [(1.5 0) (2.5 1)]
	}
}

