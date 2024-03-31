// Next level
if (oPlayer.currentState = STATE.REAL)
{
	with (oManager) {
		if (!trans) {
		
			if (levelCurrent < array_length(levelArray) - 1) {
				trans = true;
				transState = MENU_STATE.GAME;
				transRoom = levelArray[++levelCurrent];
				levelUnlocked ++;
				dialogNum = 0;
				oManager.levelStarted = true
				
				var rndWin = choose(homerwin2,homerwin3)
				
			audio_sound_pitch(rndWin,.85)
				audio_play_sound(rndWin,0,0,.3)
				audio_play_sound(drinking,0,0,.3)
				if (random(100) < 5)
				{
					audio_play_sound(booCrowd,0,0)
				}
			}
			else {
				trans = true;
				transState = MENU_STATE.MAIN_MENU;
				transRoom = rmMenu
				dialogNum = 0;
				oManager.levelStarted = true
			}
		}
	}
}
