#macro VISUAL_OFFSET_X 2
#macro VISUAL_OFFSET_Y -2

menuState = MENU_STATE.MAIN_MENU;

buttonHoverControl = false;
buttonHover = false;

// Colors
#macro MENU_BACKGROUND #e6d83a
#macro TEXT c_black

//Levels
levelUnlocked = 0;
levelCurrent = 0;
levelArray = [rmLevel0, rmLevel1, rmLevel2, rmLevel3, rmLevel4, rmLevel5, rmLevel6, rmLevel7/*, rmLevel8, rmLevel9*/];

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

fullscreenAknowledged = false;

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

dialogSound = 0
levelStarted = true
crowdSound = sndCrowdAmbientLooping

soundTrackReal = sounstrack_real
soundTrackLiminal = sounstrack_liminal
maxGain = .1

// Dialog
dialogNum = 0;
dialogArray = [[[0, "Weeeeelcome to LIMINAL!!!"], [0, "The reality show made by alcoholics for alcoholics."], [0, "Each episode, a poor individual is VOLUNTARILY (TM) brought to our dungeon-like television set..."], [0, "...to show its worth by overcoming a series of intricate puzzles."], [0, "A great price awaits those who are able to conquer the challenge - a chance for a new life."], [0, "Those who aren't? Well, let's just say you don't want to go near these pink puddles laying around."], [0, "Enough of boring talking, are you ready?"], [1, "..."], [0, "The task is simple."], [0, "Overcome the obstacles, get your bottle of beer."], [0, "Use \"WASD\" to move around."], [1, "???"]],
			   [[0, "Feeling a little dizzy already?"], [0, "Don't worry, with each beer, it actually gets easier! (unlike driving :DD)"], [0, "You might start experiencing some DOUBLE VISION due to the increasing level of alcohol in your blood."], [0, "Try to use this to your advantage."], [0, "By pressing the SHIFT key, you can materilize the perceived reality of your double vision."], [1, "..."]],
			   [[0, "Heard of pink water?"], [0, "Now get reedy fooor... um..."], [0, "BLACK WATER... yeah."], [1, "..."], [0, "Not as deadly as the pink one - it only snaps you back to reality when touching it."]],
			   [[0, "On this stage, there is absolutely no danger at all!"],[0, "Going one step backwards might bring you two steps forward!"],[0,"Just try not to end up on the other side of the arena! xD"],[1,"...?"]],
			   [[0,"Another stage, another beer!"],[0,"In a way, every beer only comes after going through an acid maze"],[1,"..."]],
			   [[0,"Bottoms down cuz we're falling up!"],[1,"..."]],
			   [],
			   [[0,"Got right to make yourself bright!"],[0,"Or more drunk I guess.."],[1,"..."]],
			   [],
			   []];
