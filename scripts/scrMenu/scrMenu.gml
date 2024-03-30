enum MENU_STATE
{
	MAIN_MENU,
	LEVEL_SELECT,
	SETTINGS,
	GAME,
	PAUSE
}

 function button(_x, _y, _width, _height, _text, _active)
{
	if (oManager.trans) return false;
	
	var _mouseX = window_mouse_get_x();
	var _mouseY = window_mouse_get_y();
	_x -= _width * 0.5;
	
	var _click = false;
	var _hover = false;
	var _alpha = 0.5;
	if (_active)
	{
		_alpha = 1;
		if (point_in_rectangle(_mouseX, _mouseY, _x, _y, _x + _width, _y + _height))
		{
			_hover = true;
			window_set_cursor(cr_handpoint);
			if (mouse_check_button_pressed(mb_left))
			{
				_click = true;
				audio_play_sound(sndClick,0,0)
			}
			
			with (oManager)
			{
				if (buttonHover == false)
					audio_play_sound(sndHover, 10, false);
				buttonHoverControl = true;
			}
		}
	}
	
	var _colour1 = c_black;
	var _colour2 = MENU_BACKGROUND;
	if (_hover)
	{
		_colour1 = c_white;
		_colour2 = c_black;
	}
	var _outlineW = 2;
	draw_set_alpha(_alpha);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	//draw_roundrect_color(_x, _y, _x + _width, _y + _height, c_white, c_white, false);
	draw_roundrect_color(_x + _outlineW, _y + _outlineW, _x + _width - _outlineW, _y + _height - _outlineW,
						 _colour1, _colour1, false);
	draw_text_transformed_color(_x + _width * 0.5, _y + _height * 0.5, _text, 1, 1, 0,
								_colour2, _colour2, _colour2, _colour2, 1);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	return _click;
}

function button_hover(_x, _y, _width, _height, _active)
{
	var _mouseX = window_mouse_get_x();
	var _mouseY = window_mouse_get_y();
	_x -= _width * 0.5;
	
	if (_active && point_in_rectangle(_mouseX, _mouseY, _x, _y, _x + _width, _y + _height))
		return true;
}