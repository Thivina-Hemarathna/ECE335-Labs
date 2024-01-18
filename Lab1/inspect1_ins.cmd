#setdep @previous@
set N @node@
proj_load IcVc_@plot@ PLT($N)

cv_createDS IV($N) "PLT($N) cathode InnerVoltage" "PLT($N) cathode TotalCurrent" y
cv_setCurveAttr IV($N) "ReverseBias" Red solid 4 none 0 defcolor 1 defcolor
cv_abs IV($N) x

gr_setAxisAttr X  {Vcathode (V)}    20 {} {} black 2 16 0 5 0
gr_setAxisAttr Y  {Icathode (A/um)} 20 {} {} black 2 16 0 5 0
gr_setTitleAttr  "Reverse Characteristics" 20 center

