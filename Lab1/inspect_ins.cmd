#setdep @previous@
set N @node@
proj_load IcVc_@plot@ PLT($N)

cv_createDS IV($N) "PLT($N) anode InnerVoltage" "PLT($N) anode TotalCurrent" y
cv_setCurveAttr IV($N) "ForwardBias" blue solid 4 none 0 defcolor 1 defcolor
cv_abs IV($N) x

gr_setAxisAttr X  {Vanode (V)}    20 {} {} black 2 16 0 5 0
gr_setAxisAttr Y  {Ianode (A/um)} 20 {} {} black 2 16 0 5 0
gr_setTitleAttr  "Forward Characteristics" 20 center
