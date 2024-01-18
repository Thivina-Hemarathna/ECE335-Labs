(define totalthickness	    6)
(define totalwidth          1)
  


;----------------------------------------------------------------------
; Structure definition
;----------------------------------------------------------------------;
(sdegeo:set-default-boolean "BAB");old replace new
 
(sdegeo:create-rectangle 
  (position 0.0  0.0  0.0)  (position totalwidth 2 0.0 ) "Silicon"  "psub" )

(sdegeo:create-rectangle 
  (position 0.0 2  0.0)  (position totalwidth totalthickness 0.0 ) "Silicon"  "nsub" )


;-----------electrode and contact------------
(sdegeo:define-contact-set "electrode1"   4  (color:rgb 1 0 0 ) "##" ) 
(sdegeo:define-2d-contact (find-edge-id (position 0.2  0.0 0.0)) "electrode1")

(sdegeo:define-contact-set "electrode2"   4  (color:rgb 1 0 0 ) "##" ) 
(sdegeo:define-2d-contact (find-edge-id (position 0.2  totalthickness 0.0)) "electrode2")


;------------profile------------ 
;-----------drift contact doping----------------  

(sdedr:define-refinement-window "win.drift"  "Rectangle" 
	(position 0.0 0.0 0.0)  (position totalwidth totalthickness 0.0)  
)

(define NAME "pA")
(sdedr:define-refinement-window (string-append "RW." NAME) 
	"Rectangle"  
	(position 0.0 2  0.0) 
	(position totalwidth totalthickness 0.0) 
)
(sdedr:define-constant-profile (string-append "DC." NAME)
	"BoronActiveConcentration" 
	7e18
)
(sdedr:define-constant-profile-placement (string-append "CPP." NAME)
	(string-append "DC." NAME) (string-append "RW." NAME)
	0
	"replace"
)

(define NAME "nS")
(sdedr:define-refinement-window (string-append "RW." NAME) 
	"Rectangle"  
	(position 0.0 0 0.0) 
	(position totalwidth 2 0.0) 
)
(sdedr:define-constant-profile (string-append "DC." NAME)
	"ArsenicActiveConcentration" 
	2e15
)
(sdedr:define-constant-profile-placement (string-append "CPP." NAME)
	(string-append "DC." NAME) (string-append "RW." NAME)
	0
	"replace"
)


;(sdedr:define-gaussian-profile "doping.profile.nplusSi" "PhosphorusActiveConcentration"
;"PeakPos" 0 "PeakVal" 2e18 "ValueAtDepth" 1e18 "Depth" 0.5 "Gauss" "Factor" 0.8)
 ;Window Selection
;(sdedr:define-refinement-window "window.nplusSi" "Line" (position 0 0 0) (position 2 0 0))
 ;Doping Placement
;(sdedr:define-analytical-profile-placement "place.nplusSi" "doping.profile.nplusSi" "window.nplusSi" "Positive" "NoReplace")

;---------------------------------------------------------------------------
; Meshing
;---------------------------------------------------------------------------
; Global
(sdedr:define-refinement-window "win.global" "Rectangle"
                (position 0 0 0) (position totalwidth totalthickness 0))
(sdedr:define-refinement-size "RefDef.global" 0.5 0.5 0.1 0.1)
(sdedr:define-refinement-function "RefDef.global" "DopingConcentration" "MaxTransDiff" 1)
(sdedr:define-refinement-function "RefDef.global" "MaxLenInt" "Silicon" "Oxide" 0.1 1.5 "Doubleside")
(sdedr:define-refinement-placement "Place.global" "RefDef.global" "win.global")

;anode region
;(sdedr:define-refinement-window "win.anode" "Rectangle"
;                (position 0 1 0) (position totalwidth totalthickness 0))
;(sdedr:define-refinement-size "RefDef.anode" 0.1 0.05 0.05 0.02)
;(sdedr:define-refinement-function "RefDef.anode" "DopingConcentration" "MaxTransDiff" 1)
;(sdedr:define-refinement-function "RefDef.anode" "MaxLenInt" "Silicon" "Oxide" 0.1 1.5 "Doubleside")
;(sdedr:define-refinement-placement "Place.anode" "RefDef.anode" "win.anode")

;cathode region
;(sdedr:define-refinement-window "win.cathode" "Rectangle"
;                (position 0 0 0) (position totalwidth 1 0))
;(sdedr:define-refinement-size "RefDef.cathode" 0.1 0.05 0.05 0.02)
;(sdedr:define-refinement-function "RefDef.cathode" "DopingConcentration" "MaxTransDiff" 1)
;(sdedr:define-refinement-function "RefDef.cathode" "MaxLenInt" "Silicon" "Oxide" 0.1 1.5 "Doubleside")
;(sdedr:define-refinement-placement "Place.cathode" "RefDef.cathode" "win.cathode")


;---------------------------------------------------------------------------
(sde:build-mesh "snmesh" "" "n4")
;---------------------------------------------------------------------------

