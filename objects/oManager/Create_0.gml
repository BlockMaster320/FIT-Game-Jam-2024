#macro VISUAL_OFFSET_X 2
#macro VISUAL_OFFSET_Y -2

level = 0;
menuState = MENU_STATE.MAIN_MENU;

buttonHoverControl = false;
buttonHover = false;

// Colors
#macro MENU_BACKGROUND #e6d83a
#macro TEXT c_black

//Levels
levelUnlocked = 0;
levelCurrent = noone;
levelArray = [rmLevel1]

//Transitions
#macro TRANS_SPEED 0.03
transSurf = surface_create(display_get_gui_width(), display_get_gui_height());
trans = false;
transTimer = 1;
transSign = -1;
transState = MENU_STATE.MAIN_MENU;
transRoom = rmMenu;

//Tutorial
tutProgress = 0;
tutOpacity = 0;
/*tutAnimation = 0;
tutAnimationSign = 1;*/

//Timers
/*
showTimer = false;
bestTimes = noone;
bestTimes[1] = 5000
timerOn = false;
timeCurrent = 0;*/

//Saving && Loading
saveFile = "savefile.sav";
if (!file_exists(saveFile))
{
	var _saveStruct = {
		levelUnlocked : 0,
		//bestTimes : array_create(array_length(levelArray), 0),
		settings : [false]
	};
	var _saveString = json_stringify(_saveStruct);
	json_string_save(_saveString, saveFile)
}
else
{
	var _saveString = json_string_load(saveFile);
	var _saveStruct = json_parse(_saveString);
	levelUnlocked = _saveStruct.levelUnlocked;
	//bestTimes = _saveStruct.bestTimes;
	//showTimer = _saveStruct.settings[0];
}
