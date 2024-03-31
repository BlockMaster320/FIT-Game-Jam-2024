targetX = oPlayer.x + (oPlayer.hsp * 3) - (view_w_def/2)
targetY = oPlayer.y + (oPlayer.vsp * 3) - (view_h_def/2) - 4

targetX = clamp(targetX,0,room_width-view_w_def)
targetY = clamp(targetY,0,room_height-view_h_def)

x = lerp(x,targetX,lerpSpd)
y = lerp(y,targetY,lerpSpd)

x = clamp(x,0,room_width-view_w_def)
y = clamp(y,0,room_height-view_h_def)

camera_set_view_size(cam,view_w_def,view_h_def)
camera_set_view_pos(cam,x,y)
camera_set_view_angle(cam,rot)