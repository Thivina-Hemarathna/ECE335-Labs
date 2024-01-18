
;; Defined Parameters:

;; Contact Sets:
(sdegeo:define-contact-set "anode" 4 (color:rgb 1 0 0 )"##" )
(sdegeo:define-contact-set "cathode" 4 (color:rgb 1 0 0 )"##" )

;; Work Planes:
(sde:workplanes-init-scm-binding)

;; Defined ACIS Refinements:
(sde:refinement-init-scm-binding)

;; Reference/Evaluation Windows:
(sdedr:define-refeval-window "RW.pA" "Rectangle" (position 0 0 0) (position 4 0.5 0))
(sdedr:define-refeval-window "RW.nS" "Rectangle" (position 0 5.5 0) (position 4 6 0))
(sdedr:define-refeval-window "win.drift" "Rectangle" (position 0 0.5 0) (position 4 5.5 0))
(sdedr:define-refeval-window "win.global" "Rectangle" (position 0 0 0) (position 4 6 0))
(sdedr:define-refeval-window "win.anode" "Rectangle" (position 0 0.2 0) (position 4 4.5 0))
(sdedr:define-refeval-window "win.cathode" "Rectangle" (position 0 5 0) (position 4 6 0))

;; Restore GUI session parameters:
(sde:set-window-position 0 25)
(sde:set-window-size 840 688)
(sde:set-window-style "Windows")
(sde:set-background-color 0 127 178 204 204 204)
(sde:scmwin-set-prefs "Liberation Sans" "Normal" 8 100 )
