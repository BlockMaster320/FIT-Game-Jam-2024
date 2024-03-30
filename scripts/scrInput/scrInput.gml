// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Input()
{
	if (keyboard_check_pressed(ord("R"))) room_restart()
	//if (keyboard_check_pressed(vk_escape)) game_end()

	left = keyboard_check(ord("A")) or keyboard_check(vk_left)
	right = keyboard_check(ord("D")) or keyboard_check(vk_right)

	//Skok
	jump = keyboard_check(vk_space) or keyboard_check(ord("W")) or keyboard_check(vk_up)
	jumpPressed = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"))
	jumpReleased = keyboard_check_released(vk_space) or keyboard_check_released(vk_up) or keyboard_check_released(ord("W"))
	
	liminalJump = keyboard_check_pressed(vk_shift)
}