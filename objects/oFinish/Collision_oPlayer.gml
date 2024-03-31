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
			}
			else {
				trans = true;
				transState = MENU_STATE.MAIN_MENU;
				transRoom = rmMenu
				dialogNum = 0;
			}
		}
	}
}
