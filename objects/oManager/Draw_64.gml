
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
		levelStarted = true
		if (audio_is_playing(soundTrackReal))
		{
			audio_stop_sound(soundTrackReal)
			audio_stop_sound(soundTrackLiminal)
		}
		
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
		draw_set_valign(fa_top);
		draw_set_font(fMenu);
		//draw_set_font(fntMenu);
		
		tutProgress = 0;
		tutOpacity = 0;
	}
	break;
	
	case MENU_STATE.LEVEL_SELECT:
	{
		levelStarted = true
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
						levelCurrent = _level;
						transRoom = levelArray[levelCurrent];
						dialogNum = 0;

						
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
		levelStarted = true
		/*var _showTimerString = (showTimer) ? "ON" : "OFF";
		if (button(_drawX, _drawY, _buttonW * 1.2, _buttonH, "Timer: " + _showTimerString, true))
		{
			showTimer = !showTimer;
			
			var _saveStruct = json_parse(json_string_load(saveFile));
			_saveStruct.settings[0] = showTimer;
			var _saveString = json_stringify(_saveStruct);
			json_string_save(_saveString, saveFile);
		}*/
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_ext_transformed_color(_guiW * 0.5, _guiH * 0.5, "if you need to turn off the sounds", 100, 700, 2, 2, 0, c_black, c_black, c_black, c_black, 1);
		draw_text_ext_transformed_color(_guiW * 0.5, _guiH * 0.5 + 80, "just do it in your sound mixer...", 100, 700, 2, 2, 0, c_black, c_black, c_black, c_black, 1);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
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
			
		if (!fullscreenAknowledged) {
			draw_set_font(fText);
			draw_text_ext_transformed_color(20, 20, "PRESS 'F' FOR FULLSCREEN", 20, 500, 1.5, 1.8, 0, c_white, c_white, c_white, c_white, 1);
			draw_set_font(fMenu);
			if (keyboard_check_pressed(ord("F")))
				fullscreenAknowledged = true;
		}
			
		if (levelStarted and dialogNum < array_length(dialogArray[levelCurrent]) && !trans)
		{
			levelStarted = false
			audio_stop_sound(sndCrowdAmbientLooping)
			crowdSound = audio_play_sound(sndCrowdAmbientLooping,0,1)
			if (dialogArray[levelCurrent][dialogNum][0] == 0)
			{
				var chooseSound = choose(reporter2,reporter1,reporter3,reporter4,reporter5,reporter6)
				dialogSound = audio_play_sound(chooseSound,0,0,.8)
			}
			if (levelCurrent == 0) audio_play_sound(intro,0,0)
			if (!audio_is_playing(soundTrackReal))
			{
				audio_play_sound(soundTrackReal,1,1)
				audio_play_sound(soundTrackLiminal,1,1)
				audio_sound_gain(soundTrackLiminal,0,0)
			}
		}
		
		// Dialog
		if (dialogNum < array_length(dialogArray[levelCurrent]) && !trans)
		{
			var _color = #170f0b; /*#85825f;*/
			var _textColor = c_white;
			var _outlineColor = c_white;
			var _offset = 15;
			var _sep = 16;
			var _w = 500;
			//var _width = string_width(dialogArray[levelCurrent][dialogNum][1]);
			//var _height = string_height(dialogArray[levelCurrent][dialogNum][1]) + _sep;
			//var _numOfRows = _width div _w;
			var _drawX1 = 100;
			var _drawY1 = _guiH - 300;
			var _drawX2 = _guiW - 100;
			var _drawY2 = _guiH - 50;
			var _outlineWidth = 3;
			draw_rectangle_color(_drawX1 - _outlineWidth, _drawY1 - _outlineWidth, _drawX2 + _outlineWidth, _drawY2 + _outlineWidth, _outlineColor, _outlineColor, _outlineColor, _outlineColor, false);
			draw_rectangle_color(_drawX1, _drawY1, _drawX2, _drawY2, _color, _color, _color, _color, false);
			//draw_triangle_color(280, 140, 225, 105 - _offset, 225 - _offset, 105,  _color, _color, _color, false);
	
	
			var _charScale = 8;
			draw_set_valign(fa_top);
			draw_set_halign(fa_left);
			draw_set_font(fText);
			if (dialogArray[levelCurrent][dialogNum][0] == 1) {
				_drawX1 += sprite_get_width(sAlcoholic) * _charScale * 0.7;
			}
			draw_text_ext_transformed_color(_drawX1 + 25, _drawY1 + 25, dialogArray[levelCurrent][dialogNum][1], _sep, _w, 2, 2.5, 0, _textColor, _textColor, _textColor, _textColor, 1);
			draw_text_ext_transformed_color(_drawX1 + 20, _drawY2 - 60, "> ENTER", _sep, _w, 2, 2.5, 0, c_grey, c_grey, c_grey, c_grey, 1);
			draw_set_font(fMenu);
			
			if (dialogArray[levelCurrent][dialogNum][0] == 0) {
				var _charX = _guiW - 40;
				var _charY = _guiH - 20;
				draw_sprite_ext(sPresenter, 0, _charX, _charY, _charScale, _charScale, 0, c_white, 1);
			}
			else {
				var _charX = 40;
				var _charY = _guiH - 20;
				draw_sprite_ext(sAlcoholic, 0, _charX, _charY, _charScale, _charScale, 0, c_white, 1);
			}
	
			if (keyboard_check_pressed(vk_enter))
			{
				/*var snd = choose(sndTalking,sndTalking2,sndTalking3,sndTalking4)
				audio_play_sound(snd,0,0)*/
				dialogNum++;
				if (dialogNum < array_length(dialogArray[levelCurrent]) && !trans)
				{
					
					
					audio_stop_sound(dialogSound)
					if (dialogArray[levelCurrent][dialogNum][0] == 0)
					{
						var chooseSound = choose(reporter2,reporter1,reporter3,reporter4,reporter5,reporter6)
						dialogSound = audio_play_sound(chooseSound,0,0,.8)
					}
					else
					{
						var chooseSound = choose(homerbruh1,homerbruh2,homerbruh3,homerbruh4)
						
						audio_sound_pitch(chooseSound,.85)
						dialogSound = audio_play_sound(chooseSound,0,0,.950)
					}
				}
				else
				{
					audio_sound_gain(crowdSound,0,4000)
				}
			}
		}

	}
	break;
	
	case MENU_STATE.PAUSE:
	{
		_drawY = _guiH * 0.4;
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_text_transformed_colour(_guiW * 0.5, _drawY - _buttonH - 50, "GAME PAUSED", 2, 2, 0, c_white, c_white, c_white, c_white, 1);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		if (buttonSprite(_drawX, _drawY, 0, "Continue", true))
			menuState = MENU_STATE.GAME;
		
		_drawY += _buttonH + _buttonSpacing;
		if (buttonSprite(_drawX, _drawY, 1, "Main Menu", true))
		{
			menuState = MENU_STATE.MAIN_MENU;
			levelCurrent = 0;
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

if (instance_exists(oPlayer)) {
	if (dialogNum < array_length(dialogArray[levelCurrent]) || trans) {
		oPlayer.control = false;
	}
	else
		oPlayer.control = true;
	
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

