
if (keyboard_check_pressed(ord("F"))) {
	window_set_fullscreen(!window_get_fullscreen());
	alarm[0] = 10;
}

//MAIN MENU
//Set draw values
var _guiW = display_get_gui_width();
var _guiH = display_get_gui_height();
var _drawY = _guiH * 0.5;
var _drawX = _guiW * 0.5;

var _buttonW = 200;
var _buttonWLong = 300;
var _buttonH = 70;
var _buttonSpacing = 70;

buttonHoverControl = false;

draw_set_font(fMenu);
window_set_cursor(cr_default);

//var _falseTimerTrigger = false;

// Draw background
if (menuState == MENU_STATE.MAIN_MENU || menuState == MENU_STATE.LEVEL_SELECT || menuState == MENU_STATE.SETTINGS)
	draw_clear(MENU_BACKGROUND);

switch (menuState)
{
	case MENU_STATE.MAIN_MENU:
	{
		draw_sprite_ext(sLogo, 0, _drawX + 20, _guiH * 0.25, 0.5, 0.5, 0, c_white, 1);
		
		if (buttonSprite(_drawX, _drawY, 0, "Play", true))
			menuState = MENU_STATE.LEVEL_SELECT;
		
		_drawY += _buttonH + _buttonSpacing;
		if (buttonSprite(_drawX, _drawY, 1, "Settings", true))
			menuState = MENU_STATE.SETTINGS;
		
		_drawY += _buttonH + _buttonSpacing + 10;
		if (buttonSprite(_drawX, _drawY, 2, "Quit", true))
			game_end();
		
		//Draw Game Info
		//draw_set_font(fntMenuCredits);
		draw_set_halign(fa_right);
		draw_set_valign(fa_bottom);
		draw_set_font(fText);
		draw_text_ext_transformed_color(_guiW - 20, _guiH - 20, "A GAME BY:\n\nBloki (coding, graphics)\nMakenbo (coding, sfxs)", 20, 500, 1, 1.2, 0, TEXT, TEXT, TEXT, TEXT, 1);
		draw_set_halign(fa_right);
		
		draw_set_halign(fa_left);
		draw_text_ext_transformed_color(20, _guiH - 20, "Created as a submission for\nthe FIT Game Jam 2024", 20, 500, 1, 1.2, 0, TEXT, TEXT, TEXT, TEXT, 1);
		draw_set_font(fMenu);
		draw_set_halign(fa_top);
		draw_set_valign(fa_left);
		//draw_set_font(fntMenu);
		
		tutProgress = 0;
		tutOpacity = 0;
	}
	break;
	
	case MENU_STATE.LEVEL_SELECT:
	{
		var _levelSelectionY = _guiH * 0.35;
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_text_transformed_colour(_guiW * 0.5, _levelSelectionY - 130, "LEVEL SELECTION", 2, 2, 0, TEXT, TEXT, TEXT, TEXT, 1);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		if (buttonSprite(200, _guiH - 120, 0, "Back to Menu", true))
			menuState = MENU_STATE.MAIN_MENU;
		
		if (buttonSprite(_guiW - 200, _guiH - 120, 0, "Reset Progress", true))
		{
			levelUnlocked = 0;
			
			var _saveString = json_string_load(saveFile);
			var _saveStruct = json_parse(_saveString);
			_saveStruct.levelUnlocked = 0;
			_saveString = json_stringify(_saveStruct);
			json_string_save(_saveString, saveFile);
		}
		
		var _rows = 4;
		var _columns = 4;
		var _levelW = 100;
		var _levelH = 100;
		var _levelSpacing = 25;
		
		var _levelX = _guiW * 0.5 - floor(_columns * 0.5) * (_levelW + _levelSpacing) + (_levelW + _levelSpacing) * 0.5 * (_columns % 2 == 0);
		var _levelY = (_levelSelectionY + _levelH) - floor(_rows * 0.5) * (_levelH + _levelSpacing) + (_levelH + _levelSpacing) * 0.5 * (_rows % 2 == 0);
		for (var _r = 0; _r < _rows; _r ++)
		{
			for (var _c = 0; _c < _columns; _c ++)
			{
				var _level = _r * _columns + _c;
				var _drawX = _levelX + (_levelW + _levelSpacing) * _c;
				var _drawY = _levelY + (_levelH + _levelSpacing) * _r;
				if (_level > array_length(levelArray) - 1)
					break;
				if button(_drawX, _drawY, _levelW, _levelH, _level, (levelUnlocked >= _level))
				{
					if (_level < array_length(levelArray))
					{
						trans = true;
						transState = MENU_STATE.GAME;
						transRoom = levelArray[_level];
						
						levelCurrent = _level;
						
						//_falseTimerTrigger = true;
					}
				}
				
				/*if (button_hover(_drawX, _drawY, _levelW, _levelH, (levelUnlocked >= _level)))
				{
					var _timeBest = bestTimes[_level];
					var _seconds = _timeBest div 1000;
					var _minutes = _seconds div 60;
					var _milliseconds = floor((_timeBest % 1000) / 10);
					var _timeString = (_timeBest == 0) ? "none" : string(_minutes) + ":" + string(_seconds) + "." + string(_milliseconds);
					
					var _timeY = _guiH * 0.35;
					draw_set_halign(fa_center);
					draw_text_transformed_colour(_guiW * 0.83, _timeY, "BEST TIME", 1, 1, 0, c_white, c_white, c_white, c_white, 1);
					draw_text_transformed_colour(_guiW * 0.83, _timeY + 50, _timeString, 2, 2, 0, c_white, c_white, c_white, c_white, 1);
					draw_set_halign(fa_left);
				}*/
			}
		}
		
		/*draw_line_colour(_guiW * 0.5, 0, _guiW * 0.5, _guiH, c_green, c_green);*/
	}
	break;
	
	case MENU_STATE.SETTINGS:
	{
		/*var _showTimerString = (showTimer) ? "ON" : "OFF";
		if (button(_drawX, _drawY, _buttonW * 1.2, _buttonH, "Timer: " + _showTimerString, true))
		{
			showTimer = !showTimer;
			
			var _saveStruct = json_parse(json_string_load(saveFile));
			_saveStruct.settings[0] = showTimer;
			var _saveString = json_stringify(_saveStruct);
			json_string_save(_saveString, saveFile);
		}*/
		
		if (buttonSprite(200, _guiH - 120, 0, "Back to Menu", true))
			menuState = MENU_STATE.MAIN_MENU;
	}
	break;
	
	case MENU_STATE.GAME:
	{
		/*draw_text_transformed_colour(30, 30, "press ESC to pause", 0.5, 0.5, 0,
									 c_white, c_white, c_black, c_black, 1)*/
		if (keyboard_check_pressed(vk_escape))
			menuState = MENU_STATE.PAUSE;
	}
	break;
	
	case MENU_STATE.PAUSE:
	{
		_drawY = _guiH * 0.4;
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_text_transformed_colour(_guiW * 0.5, _drawY - _buttonH - 50, "GAME PAUSED", 2, 2, 0, TEXT, TEXT, TEXT, TEXT, 1);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		if (buttonSprite(_drawX, _drawY, 0, "Continue", true))
			menuState = MENU_STATE.GAME;
		
		_drawY += _buttonH + _buttonSpacing;
		if (buttonSprite(_drawX, _drawY, 1, "Main Menu", true))
		{
			menuState = MENU_STATE.MAIN_MENU;
			levelCurrent = noone;
			room_goto(rmMenu);
			
			tutProgress = 0;
			tutOpacity = 0;
			
			/*timeCurrent = 0;
			timerOn = false;*/
		}
		
		if (keyboard_check_pressed(vk_escape))
			menuState = MENU_STATE.GAME;
	}
	break;
}

//Timers
/*
if (menuState == MENU_STATE.GAME || menuState == MENU_STATE.PAUSE)
{
	//Input(true);
	if (!timerOn)
	{
		if (right || left || up || down || dashPress && !_falseTimerTrigger)
			timerOn = true;
	}
	else
		timeCurrent += floor(delta_time / 1000);
	
	if (showTimer)
	{
		var _seconds = timeCurrent div 1000;
		var _minutes = _seconds div 60;
		var _milliseconds = floor((timeCurrent % 1000) / 10);
		draw_text_transformed_colour(45, 45, string(_minutes) + ":" + string(_seconds) + "." + string(_milliseconds), 2, 2, 0, c_black, c_black, c_black, c_black, 1);
		draw_text_transformed_colour(41, 41, string(_minutes) + ":" + string(_seconds) + "." + string(_milliseconds), 2, 2, 0, c_white, c_white, c_white, c_white, 1);

		var _bestTime = bestTimes[levelCurrent];
		var _timeDifference = _bestTime - timeCurrent;
		var _secondsDifference = abs(_timeDifference) div 1000;
		var _minutesDifference = abs(_secondsDifference) div 60;
		var _millisecondsDifference = abs(floor((_timeDifference % 1000) / 10));
		var _sign = (_timeDifference >= 0) ? "- " : "+ ";
		var _colour = (_timeDifference >= 0) ? GREEN : RED;
	
		if (_bestTime == 0)
		{
			_sign = "";
			_colour = c_white;
		}
		draw_text_transformed_colour(45, 45 + 50, _sign + string(_minutesDifference) + ":" + string(_secondsDifference) + "." + string(_millisecondsDifference), 1, 1, 0, c_black, c_black, c_black, c_black, 1);
		draw_text_transformed_colour(41, 41 + 50, _sign + string(_minutesDifference) + ":" + string(_secondsDifference) + "." + string(_millisecondsDifference), 1, 1, 0, _colour, _colour, _colour, _colour, 1);
	}
}*/

buttonHover = buttonHoverControl;


// Transition
if (trans) {
	transTimer += transTimer * sqrt(TRANS_SPEED) * transSign;
	
	show_debug_message(transTimer);
	if (transTimer < 0.001) {
		room_goto(transRoom);
		menuState = transState;
		transSign = 1;
	}
	
	if (transTimer >= 1) {
		trans = false;
		transTimer = 1;
		transSign = -1;
	}
	
	if (!surface_exists(transSurf)) {
		transSurf = surface_create(display_get_gui_width(), display_get_gui_height());	
	}
	surface_set_target(transSurf);
	draw_clear_alpha(c_black, 0);
	draw_clear(c_black);
	gpu_set_blendmode(bm_subtract);
	draw_set_circle_precision(64);
	draw_circle_color(_guiW / 2, _guiH / 2, _guiW * transTimer, c_white, c_white, false);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	draw_surface(transSurf, 0, 0);
}

