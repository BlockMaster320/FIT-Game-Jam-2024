

if (oPlayer.currentState = STATE.LIMINAL)
{
	draw_clear(c_black);
	draw_set_alpha(0)
}
else draw_clear(BG_COLOR);

draw_sprite_tiled(sCave2, 0, x * 0.8, y);
draw_sprite_tiled(sCave1, 0, x * 0.6, y);

draw_set_alpha(1)