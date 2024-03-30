if (!surface_exists(realSurf))
{
	realSurf = surface_create(room_width,room_height)
	liminalSurf = surface_create(room_width,room_height)
}

draw_self()

if (currentState == STATE.LIMINAL or currentState == STATE.TRANSITION_TO_REAL)
{
	var alpha = .3
	draw_sprite_ext(sPlayer,0,realX,realY,1,1,0,c_white,alpha)
}

surface_set_target(realSurf)
	draw_clear_alpha(0,0)
	draw_tilemap(tileReal,0,0)
surface_reset_target()

surface_set_target(liminalSurf)
	draw_clear_alpha(0,0)
	draw_tilemap(tileLiminal,liminalLayerX+liminalOffset,liminalLayerY-liminalOffset)
surface_reset_target()

if (currentState == STATE.REAL)
{
	draw_set_alpha(realAlpha)
	draw_surface(realSurf,realLayerX,realLayerY)
}

draw_set_alpha(liminalAlpha)
draw_surface(liminalSurf,0,0)

if (currentState != STATE.REAL)
{
	draw_set_alpha(realAlpha)
	draw_surface(realSurf,realLayerX,realLayerY)
}

draw_set_alpha(1)