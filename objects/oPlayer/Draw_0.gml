if (!surface_exists(realSurf))
{
	realSurf = surface_create(room_width,room_height)
	liminalSurf = surface_create(room_width,room_height)
}

if (currentState == STATE.LIMINAL or currentState == STATE.TRANSITION_TO_REAL)
{
	var alpha = 1
	draw_sprite_ext(sPlayer,4,realX,realY,1,1,0,c_white,alpha)
}

surface_set_target(realSurf)
	draw_clear_alpha(0,0)
	draw_tilemap(tileReal,0,0)
	//draw_tilemap(tileSpikeReal,0,0)
surface_reset_target()

surface_set_target(liminalSurf)
	draw_clear_alpha(0,0)
	draw_tilemap(tileLiminal,liminalLayerX+liminalOffset,liminalLayerY-liminalOffset)
	//draw_tilemap(tileSpikeLiminal,liminalLayerX+liminalOffset,liminalLayerY-liminalOffset)
surface_reset_target()

if (currentState != STATE.LIMINAL)
{
	draw_set_alpha(realAlpha)
	draw_surface(realSurf,realLayerX,realLayerY)
}

draw_set_alpha(liminalAlpha)
draw_surface(liminalSurf,0,0)

if (currentState == STATE.LIMINAL)
{
	draw_set_alpha(realAlpha)
	draw_surface(realSurf,realLayerX,realLayerY)
}

draw_set_alpha(1)

if (currentState = STATE.LIMINAL)
{
	gpu_set_fog(true,c_white,0,0)
}

var col
if (currentState = STATE.DEAD) col = #BE29E5
else col = c_white

draw_sprite_ext(sPlayer, frame, x, y, side, 1, 0, col, alp);

gpu_set_fog(false,c_white,0,0)