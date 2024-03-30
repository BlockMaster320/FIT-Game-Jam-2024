draw_self()

if (currentState == STATE.LIMINAL or currentState == STATE.TRANSITION_TO_REAL)
{
	var alpha = .3
	draw_sprite_ext(sPlayer,0,realX,realY,1,1,0,c_white,alpha)
}