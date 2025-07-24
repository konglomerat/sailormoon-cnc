(Runs on M6, tool change)
o104 if [#<_selected_tool> NE #5400]
G53 G0 Z0 (MSG, Achtung - Maschine faehrt jetzt sehr schnell zum Werkzeuglaengensensor!)
G53 G0 X0 Y0
M0 M6(DEBUG, Werkzeug#<_selected_tool> kann jetzt eingespannt werden)

M70 (save the current machine state. (e.g. feed rate and units)

G21 (metric units)

G90 (set the machine to "absolute distance mode")

G53 G0 Z0(raise the spindle to a height that makes it easy to change the bit)

G91 (put the machine in "incremental distance mode")

F300 (search speed)

G38.2 Z-87 (probe down until the plate is touched or until Z has moved by -87mm)

G0 Z5
F100
G38.2 Z-6


(EDIT HERE: sets Z = surface table)
G92 Z21.7

G90
G53 G0 Z0
M72
o104 endif