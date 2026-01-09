# sailormoon-cnc
documents all code that came up while using our buildbotics based cnc

## `buildbotics sequences/`
these are used to insert command sequences at the beginning and ends of each program, as well as every time a tool change is triggered.

More Information in the [manual](https://buildbotics.com/manual-v2-0-0/#generaltab)

| File             | Description                                                       |
|------------------|-------------------------------------------------------------------|
| [`program-start.nc`](buildbotics_sequences/program-start.nc) | Checks whether the machine is homed. If not, performs a full homing sequence using probing on all axes. Then sets the work origin (G92) and probes the Z-height using a touch plate. |
| [`tool-change.nc`](buildbotics_sequences/tool-change.nc.nc) | Runs when a new tool is selected (M6). Moves to a safe location, prompts the user to change the tool, then automatically probes the new tool length using a touch plate and sets Z accordingly. |
| [`program-end.nc`](buildbotics_sequences/program-end.nc) | Currently contains only M2, which marks the end of the program. No additional motions or state resets are defined. Could be used to move the spindle to another parking position |

## `macros/`
we created a couple macros, mainly for ease of use.

All macros assume a Buildbotics controller and LinuxCNC compatibility.

| File             | Description                                                       |
|------------------|-------------------------------------------------------------------|
| [`Initialisieren.ngc`](macros/Initialisieren.ngc) | Used as basic initialization: performs unhoming (`G28.2`) and triggers the program-start sequence |
| [`MovetoOffset.nc`](macros/MovetoOffset.nc)    | Moves the spindle to `X0 Y0` in the currently active work coordinate system (e.g. `G54`). Does not affect Z. Useful for returning to user-defined part origin. |
| [`Pos1_Corner.ngc.ngc`](macros/Pos1_Corner.ngc)| Moves to a predefined **machine** corner (`G53 X19.667 Y37.44`) and sets that point as temporary work origin using `G52`. Useful for one-off setups or aligning to a fixture. |
| [`Tool1.ngc`](macros/Tool1.ngc) | Used for triggering the tool change sequence without doint the whole homing sequence. |
| [`Tool2.ngc`](macros/Tool1.ngc) | Same as Tool1.ngc, used when Tool1 is already loaded |

## `tool_libaries/`
For Autodesk Fusion we have a bunch of tool libaries containing some of our machining tools and their cutting data presets:

| File             | Description                                                       |
|------------------|-------------------------------------------------------------------|
| [`Konglomeratfräser-Holz.tools`](tool_libaries/Fusion/Konglomeratfräser-Holz.tools) | square-profile end mills for wood  |
| [`Konglomeratfräser-Spezial.tools`](tool_libaries/Fusion/Konglomeratfräser-Spezial.tools) | non-square end mills for wood (Ball nose, corner radius, etc)  |
| [`Konglomeratfräser-Acryl.tools`](tool_libaries/Fusion/Konglomeratfräser-Acryl.tools) | end mills for acrylic and similar materials |

We also used to maintain tool libaries for VCarve, however theyve become obsolete since most of us have been using Fusion for a while now. You can find them [here](tool_libaries/VCarve(old)/)

The single source of truth for our current machining tools is a [google sheet](https://docs.google.com/spreadsheets/d/1YzTxPmGvQnlsPaC_oG6TcLyzMM7FZfQhtsJZIe4CL_E/edit?usp=sharing)

## Config File 
- [`bbctrl-20250723-213945.json`](config/bbctrl-20250723-213945.json) – this is just a backup of the latest Buildbotics configuration exported via the web-ui

## Buildbotics Stuff
- Buildbotics Firmware can be found here: https://github.com/buildbotics
- Lates Postprocessor we use for Fusion: https://github.com/buildbotics/bbctrl-posts/tree/master/fusion360



# Todo / Ideas for improvements

- [ ] create macro for parking/unparking based on this idea from the [forum](https://forum.buildbotics.com/viewtopic.php?f=17&t=309)
- [ ] improve the `MovetoOffset.nc` by making it more safe and setting G54 and lifting Z to 0 before moving
- [ ] improve the initialization routine by removing unnecessary code from the macro
- [ ] improve the manual tool length measuring by making it more clever and resetting the tool #5400
- [ ] set default tool in program-start.nc to -1 instead of 6 and check if this works as expected

