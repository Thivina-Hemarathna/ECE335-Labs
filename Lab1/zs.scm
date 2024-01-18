
;; Defined Parameters:

;; Contact Sets:
(sdegeo:define-contact-set "anode" 4 (color:rgb 1 0 0 )"##" )
(sdegeo:define-contact-set "cathode" 4 (color:rgb 1 0 0 )"##" )

;; Work Planes:
(sde:workplanes-init-scm-binding)

;; Defined ACIS Refinements:
(sde:refinement-init-scm-binding)

;; Reference/Evaluation Windows:
(sdedr:define-refeval-window "RW.drift" "Rectangle" (position 0 0 0) (position 4 9 0))
(sdedr:define-refeval-window "win.top" "Rectangle" (position 0 0 0) (position 4 1 0))
(sdedr:define-refeval-window "win.bot" "Rectangle" (position 0 6.5 0) (position 4 7.5 0))

;; Restore GUI session parameters:
(sde:set-window-position 0 25)
(sde:set-window-size 840 688)
(sde:set-window-style "Windows")
(sde:set-background-color 0 127 178 204 204 204)
(sde:scmwin-set-prefs "Liberation Sans" "Normal" 8 100 )
