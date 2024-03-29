(if (string=? "nMOS" "nMOS") 
 (begin
  (define DopSub "BoronActiveConcentration")
  (define DopSD  "ArsenicActiveConcentration")
;   - Substrate doping level
  (define SubDop  5e18 )   ; [1/cm3]
  (define HaloDop 7.5e18 ) ; [1/cm3]
  (define ExtDop 3e19) ; [1/cm3]
 )
 
; (begin 
;  (define DopSub "ArsenicActiveConcentration")
; (define DopSD  "BoronActiveConcentration")
;;   - Substrate doping level
;  (define SubDop  5e18)   ; [1/cm3]
;  (define HaloDop 7.5e18 ) ; [1/cm3]
; )
)
;----------------------------------------------------------------------
; Setting parameters
; - lateral
(define Lg    0.045)               ; [um] Gate length
(define Lsp   0.1)                   ; [um] Spacer length
(define Lreox 0.007)                 ; [um] Reox Spacer length
(define Ltot (+ Lg (* 2 Lsp) 0.8) )  ; [um] Lateral extend total 

; - layers
(define Hsub 1.0)   ; [um] Substrate thickness
(define Tox  3e-3) ; [um] Gate oxide thickness
(define Hpol 0.2)   ; [um] Poly gate thickness

; - other
;   - spacer rounding
(define fillet-radius 0.08) ; [um] Rounding radius

;   - pn junction resolution
(define Gpn 0.002) ; [um]

(define XjHalo 0.07)  ; [um] Halo depth
(define XjExt  0.026) ; [um] Extension depth
(define XjSD   0.12)  ; [um] SD Junction depth

;----------------------------------------------------------------------
; Derived quantities
(define Xmax (/ Ltot 2.0))
(define Xg   (/ Lg   2.0))
(define Xsp  (+ Xg   Lsp))
(define Xrox (+ Xg   Lreox))

(define Ysub Hsub)
(define Ygox (* Tox -1.0))
(define Ypol (- Ygox Hpol))

(define Lcont (- Xmax Xsp))  
;----------------------------------------------------------------------
; Overlap resolution: New replaces Old
(sdegeo:set-default-boolean "ABA")

;----------------------------------------------------------------------
; Creating substrate region
(sdegeo:create-rectangle 
  (position    0.0  Ysub  0.0 ) 
  (position    Xmax 0.0 0.0 ) "Silicon" "R.Substrate" )

; Creating gate oxide
(sdegeo:create-rectangle 
  (position    0.0 0.0  0.0 ) 
  (position    Xsp Ygox 0.0 ) 
  "SiO2" "R.Gateox"
)

; Creating PolyReox
(sdegeo:create-rectangle 
  (position    0.0  Ygox 0.0 ) 
  (position    Xsp  Ypol 0.0 ) 
  "Oxide" "R.PolyReox"
)

; Creating spacers regions
(sdegeo:create-rectangle 
  (position   (+ Xg Lreox)  Ygox 0.0 ) 
  (position    Xsp  Ypol 0.0 ) 
  "Si3N4" "R.Spacer"
)

; Creating PolySi gate
(sdegeo:create-rectangle 
  (position    0.0 Ygox 0.0 ) 
  (position    Xg  Ypol 0.0 ) 
  "PolySi" "R.Polygate"
)

;----------------------------------------------------------------------
; - rounding spacer
(sdegeo:fillet-2d 
 (find-vertex-id (position Xsp Ypol 0.0 ))
 fillet-radius)

;----------------------------------------------------------------------
; Contact declarations
(sdegeo:define-contact-set "drain" 
  4.0  (color:rgb 0.0 1.0 0.0 ) "##")

(sdegeo:define-contact-set "gate" 
  4.0  (color:rgb 0.0 0.0 1.0 ) "##")

(sdegeo:define-contact-set "substrate"
  4.0  (color:rgb 0.0 1.0 1.0 ) "##")

;----------------------------------------------------------------------
; Contact settings
(sdegeo:define-2d-contact 
 (find-edge-id (position (* (+ Xmax Xsp)  0.5) 0.0 0.0))
 "drain")

(sdegeo:define-2d-contact 
 (find-edge-id (position 5e-4 Ypol 0.0))
 "gate")

(sdegeo:define-2d-contact 
 (find-edge-id (position 5e-4  Ysub 0.0))
 "substrate")
 
;----------------------------------------------------------------------
; Separating lumps
(sde:separate-lumps)

; Setting region names
(sde:addmaterial 
  (find-body-id (position  5e-4  (- Ysub 0.1) 0.0)) 
  "Silicon" "R.Substrate")

(sde:addmaterial 
  (find-body-id (position  5e-4  (* 0.5 Ygox) 0.0)) 
  "SiO2"    "R.Gateox")

(sde:addmaterial 
  (find-body-id (position  5e-4  (- Ygox 0.01)  0.0)) 
  "PolySi"  "R.Polygate")

(sde:addmaterial 
  (find-body-id (position (* -0.5 (+ Xsp Xg)) (- Ygox 0.01)  0.0)) 
  "Si3N4"   "R.Spacerleft")

(sde:addmaterial 
  (find-body-id (position (*  0.5 (+ Xsp Xg)) (- Ygox 0.01)  0.0))  
"Si3N4"   "R.Spacerright")

; Profiles:
; - Substrate
(sdedr:define-constant-profile "Const.Substrate" 
 DopSub SubDop )
(sdedr:define-constant-profile-region  "PlaceCD.Substrate" 
 "Const.Substrate" "R.Substrate" )

; - Poly
(sdedr:define-constant-profile "Const.Gate" 
 DopSD 1e20 )
(sdedr:define-constant-profile-region "PlaceCD.Gate" 
 "Const.Gate" "R.Polygate" )

; - Halo 
; -- base line definitions
(sdedr:define-refinement-window "BaseLine.Halo" "Line"  
 (position    Xg        0.0 0.0)  
 (position (* Xmax 2.0) 0.0 0.0) )
; -- implant definition
(sdedr:define-gaussian-profile "Impl.Haloprof"
 DopSub
 "PeakPos" 0  "PeakVal" HaloDop
 "ValueAtDepth" (* 0.1 HaloDop)  "Depth" XjHalo
 "Gauss"  "Factor" 0.8
)
; -- implant placement
(sdedr:define-analytical-profile-placement "Impl.Halo" 
 "Impl.Haloprof" "BaseLine.Halo" "Positive" "NoReplace" "Eval")

; - Source/Drain extensions 
; -- base line definitions
(sdedr:define-refinement-window "BaseLine.Ext" "Line"  
 (position    Xrox      0.0 0.0)  
 (position (* Xmax 2.0) 0.0 0.0) )
;   implant definition
(sdedr:define-gaussian-profile "Impl.Extprof"
 DopSD
 "PeakPos" 0  "PeakVal" ExtDop
 "ValueAtDepth" SubDop "Depth" XjExt
 "Gauss"  "Factor" 0.8
)
; -- implant placement
(sdedr:define-analytical-profile-placement "Impl.Ext" 
 "Impl.Extprof" "BaseLine.Ext" "Positive" "NoReplace" "Eval")

; - Source/Drain implants
; -- base line definitions
(sdedr:define-refinement-window "BaseLine.SD" "Line"  
 (position Xsp 0.0 0.0)  
 (position (* Xmax 2.0) 0.0 0.0) )
; -- implant definition
(sdedr:define-gaussian-profile "Impl.SDprof"
 DopSD 
 "PeakPos" 0  "PeakVal" 1e20
 "ValueAtDepth" SubDop "Depth" XjSD
 "Gauss"  "Factor" 0.8
)
; -- implant placement
(sdedr:define-analytical-profile-placement "Impl.SD" 
 "Impl.SDprof" "BaseLine.SD" "Positive" "NoReplace" "Eval")

;----------------------------------------------------------------------
; Meshing Strategy:
; Substrate
(sdedr:define-refinement-size "Ref.Substrate" 
  (/ Xmax 4.0)  (/ Hsub 8.0) 
  Gpn            Gpn )
(sdedr:define-refinement-function "Ref.Substrate" 
 "DopingConcentration" "MaxTransDiff" 1)
(sdedr:define-refinement-region "RefPlace.Substrate" 
 "Ref.Substrate" "R.Substrate" )

; Active
(sdedr:define-refinement-window "RWin.Act" 
 "Rectangle"  
 (position   0.0  0.0   0.0) 
 (position  Xmax (* XjSD  1.5)    0.0) )
(sdedr:define-refinement-size "Ref.SiAct" 
  (/ Lcont 4.0) (/ XjSD 6.0) 
  Gpn            Gpn )
(sdedr:define-refinement-function "Ref.SiAct" 
 "DopingConcentration" "MaxTransDiff" 1)
(sdedr:define-refinement-placement "RefPlace.SiAct" 
 "Ref.SiAct" "RWin.Act" )

; Po Gate Multibox
(sdedr:define-refinement-window "MBWindow.Gate" 
 "Rectangle"  
 (position 0.0 Ypol  0.0) 
 (position Xg  Ygox  0.0) )
(sdedr:define-multibox-size "MBSize.Gate" 
  (/ Lg  8.0)  (/ Hpol 4.0)
  (/ Lg 10.0)   2e-4 
  1.0         -1.35 )
(sdedr:define-multibox-placement "MBPlace.Gate" 
 "MBSize.Gate"  "MBWindow.Gate" )

; GateOx Multibox
(sdedr:define-refinement-window "MBWindow.GateOx" 
 "Rectangle"  
 (position 0.0        Ygox  0.0) 
 (position (* Xg  1.2) 0.0  0.0) )
(sdedr:define-multibox-size "MBSize.GateOx" 
  (/ Lg  8.0)  (/ Tox 4.0)
  (/ Lg 10.0)   1e-4 
  1.0         -1.35 )
(sdedr:define-multibox-placement "MBPlace.GateOx" 
 "MBSize.GateOx"  "MBWindow.GateOx" )

; GateOx
(sdedr:define-refinement-size "Ref.GOX" 
  (/ Ltot 4.0)  (/ Tox 4.0) 
  Gpn           (/ Tox 8.0) )
(sdedr:define-refinement-region "RefPlace.GOX" 
 "Ref.GOX" "R.Gateox" )

; Channel Multibox
(sdedr:define-refinement-window "MBWindow.Channel" 
 "Rectangle"  
 (position        0.0  0.0   0.0) 
 (position (* Xg  1.2) (* 2.0 XjExt)  0.0) )
(sdedr:define-multibox-size "MBSize.Channel" 
  (/ Lg  8.0)  (/ XjSD 8.0)
  (/ Lg 10.0)   1e-4 
  1.0           1.35 )
(sdedr:define-multibox-placement "MBPlace.Channel" 
 "MBSize.Channel" "MBWindow.Channel" )

; Junctions under the gate
(sdedr:define-refinement-size "Ref.J" 
  (/ XjExt 8.0)  (/ XjExt 8.0) 
  (/ XjExt 10.0) (/ XjExt 10.0))

; Gate-Drain Junction
(sdedr:define-refinement-window "RWin.GD" 
 "Rectangle"  
 (position (- Xrox (* 0.8 XjExt))   0.0   0.0) 
 (position (- Xrox (* 0.1 XjExt))   (* XjExt 0.5)  0.0) )
(sdedr:define-refinement-placement "RefPlace.GJ" 
 "Ref.J" "RWin.GD" )

;----------------------------------------------------------------------
; Build Mesh 
(sde:build-mesh "snmesh" " " "n3_half_msh")

;----------------------------------------------------------------------
; Reflect device

(system:command "tdx -mtt -x -ren drain=source n3_half_msh n3_msh")

