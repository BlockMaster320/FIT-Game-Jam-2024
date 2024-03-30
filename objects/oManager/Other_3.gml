// Save progress
var _saveStruct = {
	levelUnlocked : levelUnlocked,
	//bestTimes : array_create(array_length(levelArray), 0),
	settings : [false]
};
var _saveString = json_stringify(_saveStruct);
json_string_save(_saveString, saveFile)