
;; Defined Parameters:

;; Contact Sets:
(sdegeo:define-contact-set "gate" 4 (color:rgb 1 0 0 )"##" )
(sdegeo:define-contact-set "sub" 4 (color:rgb 1 0 0 )"##" )

;; Work Planes:
(sde:workplanes-init-scm-binding)

;; Defined ACIS Refinements:
(sde:refinement-init-scm-binding)

;; Reference/Evaluation Windows:
(sdedr:define-refeval-window "RW.nregion" "Polygon" (list (position 0 0 0) (position 2.2 0 0) (position 3 0 0) (position 3 1 0) (position 0 1 0)))
(sdedr:define-refeval-window "RW.pregion" "Rectangle" (position 0 0 0) (position 2 1 0))
(sdedr:define-refeval-window "RW.global" "Rectangle" (position 0 0 0) (position 3 3 0))
(sdedr:define-refeval-window "RW.junction" "Rectangle" (position 1.5 0 0) (position 2.5 1 0))

;; Restore GUI session parameters:
(sde:set-window-position 158 54)
(sde:set-window-size 840 688)
(sde:set-window-style "Windows")
(sde:set-background-color 0 127 178 204 204 204)
(sde:scmwin-set-prefs "Liberation Sans" "Normal" 8 100 )
