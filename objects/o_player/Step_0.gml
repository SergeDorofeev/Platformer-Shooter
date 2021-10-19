//keyboard inputs
key_right = keyboard_check(ord("D"))
key_left = keyboard_check(ord("A"))
key_jump = keyboard_check_pressed(vk_space)
//calculate movement
var direct = key_right - key_left//returns 1 if right key pressed, returns -1 if left key pressed
hspd = direct * run_sp
//gravity
vspd = vspd + grav
//jump
if(place_meeting(x, y + 1, o_wall) and key_jump and jump_current > 0){
	vspd = jump_pw	
	jump_current -=1
}else{
	//in air 
	if (key_jump and jump_current > 0){
		vspd = jump_pw
		jump_current -=1
	}
}
//horizontal collision
if (place_meeting(x + hspd, y, o_wall)){
	hspd = 0	
}
x = x + hspd
//vertical collision
if (place_meeting(x , y+ vspd, o_wall)){
	vspd = 0	
}
y = y + vspd

//check if player landed on the ground
if(place_meeting(x, y + 1, o_wall)){
jump_current=jump_max	
}
//check id player touches lava
if(place_meeting(x, y, o_lava)){
	room_restart()
}
// if player fell out of the room borders
if(bbox_right < 0 or bbox_left > room_width or bbox_top > room_height or bbox_bottom < 0){
	room_restart()
}
//Animation
if(not place_meeting(x, y + 1,o_wall)){
	//In the air
	sprite_index = s_jump//change sprite
	image_speed = 0 //fps
	if(sign(vspd)>0) image_index = 1;else image_index = 0
}else{
	image_speed=1 
	if (hspd==0){
		//player is not moving
		sprite_index = s_idle
	}else {
		//player is moving
		sprite_index = s_run
	}
}

//change look direction
if(hspd != 0) image_xscale= sign(hspd)