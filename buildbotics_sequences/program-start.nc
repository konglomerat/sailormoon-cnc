(Runs at program start)
G90 (Absolute distance mode)
G17 (Select XY plane)

(if machine is homed, program starts - otherwise homing sequence starts)
o103 if [ [ #<_x_homed>  NE 1] OR [ [ #<_y_homed> NE 1]  OR [ #<_z_homed> NE 1]  ]  ]

M0(MSG,Homing gestartet. Werkzeuglaengensensor freihalten!)

(Tool zurücksetzen)
#5400 = 6

(Unhoming)
G28.2 X0 Y0 Z0

;M0(MSG,Home Z!)
G38.6 P4 Z100 F200 (seek upward until switch 4 active with error and halt, setting Z-min)
G38.8 P4 Z-20 F50 (seek downward until switch 4 inactive with error and halt)

;M0(MSG,Home X!)
G38.6 x-100 F200 (Seek active switch with error and halt)
G38.8 x20 F50 (Seek inactive switch with error and halt)

;M0(MSG,Home Y!)
G38.6 y-100 F200
G38.8 y20 F50

G91 G1 X1 Y1 Z-1 F200 (not sure whats that doing other than adding 1 to each)
G28.3 X0 Y0 Z0 (set abs position to 0 + marks axes homed)

G90 G94 (Absolute distance mode; Feed in units per minute)
G17 (using XY plane)
G21 (Metric Units)

(EDIT HERE: Set coordinates for the "Ursprung")
G92 X-17.1 Y-41.587

G53 G0 Z0 (lift spindle to max)
;G21 (metric units)
;G53 G0 Z0

G91 (put the machine in "incremental distance mode")

;---Probing routing bit----
M0(MSG, Achtung! Wird der Sensor getroffen?)
F300 (search speed)
G38.2 Z-87 (probe down until the plate is touched or until Z has moved by -87mm)
G0 Z5 (retract, used to be 1.5)
F100
G38.2 Z-6 (probe again slower for 4mm)

(EDIT HERE: sets Z = surface table, bigger value = less distance to table)
G92 Z21.7

G90 (Absolute distance mode)
G53 G0 Z0  (lift spindle to max)
G53 G0 X0 Y0 (move to machine 0)
M2

o103 else

(Machine already homed, start program)
M0(MSG,Programm gestartet! Bitte bestaetigen)

o103 endif