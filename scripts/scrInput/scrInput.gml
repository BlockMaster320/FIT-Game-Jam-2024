// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Input()
{
	if (keyboard_check_pressed(ord("R"))) room_restart()
	//if (keyboard_check_pressed(vk_escape)) game_end()

	left = keyboard_check(ord("A")) or keyboard_check(vk_left)
	right = keyboard_check(ord("D")) or keyboard_check(vk_right)
	down = keyboard_check(ord("S")) or keyboard_check(vk_down)
	up = keyboard_check(ord("W")) or keyboard_check(vk_up)

	//Skok
	jump = keyboard_check(vk_space) or keyboard_check(vk_up)
	jumpPressed = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_up)
	jumpReleased = keyboard_check_released(vk_space) or keyboard_check_released(vk_up)
	
	liminalJump = keyboard_check_pressed(vk_shift)
}