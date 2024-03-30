cam = view_camera[0]

view_w_def = 160
view_h_def = 90

targetX = oPlayer.x - (view_w_def/2)
targetY = oPlayer.y - (view_h_def/2)

x = targetX
y = targetY

lerpSpdDef = .2
lerpSpdShifting = .7
lerpSpd = lerpSpdDef

screenshake = 0
offX = 0
offY = 0
rot = 0

#macro BG_COLOR #342821