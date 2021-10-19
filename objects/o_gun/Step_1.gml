
//attach gun to the player
if (sign(o_player.hspd)==1 or sign( o_player.vspd) !=0)
{
	x = o_player.x+13
	y = o_player.y-4
} else if (sign(o_player.hspd)==-1 or sign( o_player.vspd) !=0 ){
	x = o_player.x-13
	y = o_player.y-4
} 
else if (sign(o_player.hspd==0)) {
	x = o_player.x+7
	y = o_player.y-3 
}
//gun follows the mouse
image_angle = point_direction(x,y, mouse_x,mouse_y)
//rotate with player
if(image_angle > 90) and (image_angle < 270) {
	image_yscale = -1
} else{
	image_yscale = 1
} 
//shooting 
firing_delay -= 1
recoil = max(0,recoil-1)
if(mouse_check_button(mb_left) and firing_delay < 0){
    firing_delay = delay 
	recoil = recoil_delay
	with(instance_create_layer(x, y-5,"Bullets",o_bullet)){
		speed = 25
		direction = other.image_angle + random_range(-other.spread,other.spread)
		image_angle = direction
		
	}
}
//recoil
x = x-lengthdir_x(recoil,image_angle)
y = y-lengthdir_y(recoil,image_angle)