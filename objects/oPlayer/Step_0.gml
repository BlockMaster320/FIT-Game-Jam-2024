Input()


// Void death
if (y > room_height and currentState != STATE.DEAD)
{
	currentState = STATE.DEAD;
	deathDir = point_direction(x,y,x+hsp,y+vsp)
	var rndYell = choose(homeryell1,homeryell2,homeryell3,homeryell4)
	
	audio_sound_pitch(rndYell,.85)
	audio_play_sound(rndYell,0,0,.850)
	if (random(100) < 8)
	{
		audio_play_sound(laughtrack,0,0)
	}
	audio_play_sound(noise,0,0,1)
}	

switch (currentState)
{	
	case STATE.REAL:
	{
		if (place_meeting(x,y,currentKillTrigger) or place_meeting(x,y,currentCollision))
		{
			currentState = STATE.DEAD
			deathDir = point_direction(x,y,x+hsp,y+vsp)
			var off = 5
			if (hsp == 0 and vsp == 0) off = 180
			part_type_direction(blood,deathDir-off+180,deathDir+off+180,0,15)
			
			part_type_size(blood,2,3,0,0)
			//part_particles_create(bloodSys,x,y,blood,50)
			part_type_size(blood,1,2,0,0)
			
			if (random(100) < 20)
			{
				audio_play_sound(laughtrack,0,0)
			}
			var rndYell = choose(homeryell1,homeryell2,homeryell3,homeryell4)
			audio_sound_pitch(rndYell,.85)
			audio_play_sound(rndYell,0,0,.850)
			audio_play_sound(noise,0,0,1)
		}
		else break
	}
	
	case STATE.DEAD:
	{
		//alp *= .92
		if (deathStateLength == 0) room_restart()
		noclip = true
		maxSpd = .5
		deathStateLength--
		
		if (hsp != 0 or vsp != 0)
		{
			x += lengthdir_x(.1,deathDir)
			y += lengthdir_y(.1,deathDir)
		}
		
			var off = 5
			if (hsp == 0 and vsp == 0) off = 180
			part_type_direction(blood,deathDir-off+180,deathDir+off+180,0,15)
		part_particles_create(bloodSys,x+random_range(-1,1),y-5+random_range(-1,1),blood,5)
		
		//part_particles_create(impactDustSys,x,y,impactDust,5)	
		
		break
	}
	
	case STATE.LIMINAL:
	{
		
		part_type_subimage(shift,floor(frame))
		var spawn = random(30) < 1
		part_type_direction(shift,0,360,0,70)
		
		part_type_color1(shift,c_black)
		part_particles_create(shiftSys,x,y,shift,spawn)
		
		if (place_meeting(x,y,currentKillTrigger))
		{
			liminalJump = true
			currentState = STATE.TRANSITION_TO_REAL
			currentKillTrigger = oKillReal
		}
		else break
	}
	
	case STATE.TRANSITION_TO_REAL:
	{
		transitionSpeed += transitionSpeedAcc
		
		layer_depth("Liminal", 450)
		
		if (point_distance(x,y,realX,realY) < transitionSpeed)
		{
			x = realX
			y = realY
			
			if (transitionWait <= 0)
			{
				audio_stop_sound(bass)
				var sndSwitch = choose(switch1,switch2,switch3,switch4)
				audio_play_sound(sndSwitch,0,0,1.8)
				//wvsp = realwvsp
				//whsp = realwhsp
				wvsp = -1
				whsp = 0
				noclip = false
				control = true
				currentState = STATE.REAL
				currentCollision = oCollisionReal
				currentKillTrigger = oKillReal
				oCamera.lerpSpd = oCamera.lerpSpdDef
				transitionWait = transitionWaitDef
				
				audio_sound_gain(oManager.soundTrackReal,oManager.maxGain,1000)
				audio_sound_gain(oManager.soundTrackLiminal,0,1000)
				
				break
			}
			
			transitionWait--
		}
		else
		{
			var spawn = 1
			part_type_subimage(shift,floor(frame))
		
			part_type_color1(shift,c_white)
			part_type_alpha2(shift,random_range(.2,.8),0)
			part_particles_create(shiftSys,x,y,shift,spawn)
			x += lengthdir_x(transitionSpeed,point_direction(x,y,realX,realY))
			y += lengthdir_y(transitionSpeed,point_direction(x,y,realX,realY))
		}
		break
	}
}

if (random(100) < .1)
{
	var chooseSound = choose(homerbruh1,homerbruh2,homerbruh3,homerbruh4)
	
			audio_sound_pitch(chooseSound,.85)
	audio_play_sound(chooseSound,0,0,.950)
}

if (control and liminalJump)
{
	if (currentState == STATE.REAL and !place_meeting(x,y,oCollisionLiminal))
	{
		currentState = STATE.LIMINAL
		var sndSwitch = choose(switch1,switch2,switch3,switch4)
		audio_play_sound(sndSwitch,0,0,1.5)
		audio_play_sound(bulletClear,0,0,.3)
	}
	else if (currentState == STATE.LIMINAL) currentState = STATE.TRANSITION_TO_REAL
	switch (currentState)
	{	
		case STATE.LIMINAL:
		{
			realX = x
			realY = y
			currentCollision = oCollisionLiminal
			currentKillTrigger = oKillLiminal
			layer_depth("Liminal", 350)
			liminalAlpha = 1
			realAlpha = realTransparency
			realwvsp = wvsp
			realwhsp = whsp
			
			layer_set_fx("Vignette_1",liminalEffect)
			
			audio_sound_gain(oManager.soundTrackReal,0,1000)
			audio_sound_gain(oManager.soundTrackLiminal,.25,1000)
			
			break
		}
		
		case STATE.TRANSITION_TO_REAL:
		{
			
			
			if (random(100) < 20)
			{
				
				var rndYell = choose(homeryell1,homeryell2,homeryell3,homeryell4)
				audio_sound_pitch(rndYell,.85)
				audio_play_sound(rndYell,0,0,.850)
			}
			
			audio_play_sound(bass,0,1)
			
			shiftX = frac(realLayerX)
			shiftY = frac(realLayerY)
			realLayerX = round(realLayerX)
			realLayerY = round(realLayerY)
			//layer_x(realInstancesLayer, realLayerX)
			//layer_y(realInstancesLayer, realLayerY)
			
			with (opReal)
			{
				//x -= other.shiftX
				//y -= other.shiftY
				x = round(x)
				y = round(y)
			}
			
			transitionSpeed = transitionSpeedDef
			oCamera.lerpSpd = oCamera.lerpSpdShifting
			noclip = true
			control = false
			liminalAlpha = liminalTransparency
			realAlpha = 1
			
			layer_clear_fx("Vignette_1")
			break
		}
	}
}

if (control)
{
	//Movement and jump
	var dir = right - left
	whsp += dir * acc
	
	
	if (dir == -sign(whsp)) whsp *= .5
	
	whsp = clamp(whsp,-maxSpd,maxSpd)
	wvsp = clamp(wvsp,-maxWvsp,maxWvsp)
	
	var onGroundPrev = onGround
	onGround = place_meeting(x,y+1,currentCollision)
	if (onGround and onGroundPrev != onGround)
	{
		audio_play_sound(choose(impact1,impact2,impact3,impact4),0,0,.3)
		part_type_direction(impactDust,175,190,0,0)
		part_particles_create(impactDustSys,x,y,impactDust,5)
		part_type_direction(impactDust,-5,5,0,0)
		part_particles_create(impactDustSys,x,y,impactDust,5)	
	}
	
	if (walkTimer <= 0 and onGround and dir != 0)
	{
		walkTimer = walkTimerDef
		var walkSnd = choose(walk1,walk2,walk3,walk4,walk5,walk6)
		audio_sound_pitch(walkSnd,random_range(1.8,2.2))
		audio_play_sound(walkSnd,0,0,1)
	}
	walkTimer--
	
	if (dir = 0)
	{
		if (onGround) whsp *= groundFrict
		else whsp *= airFrict
	}

	#region Better jump
	soonJumpTimer = max(soonJumpTimer-1,0)
	lateJumpTimer = max(lateJumpTimer-1,0)

	if (jumpPressed) soonJumpTimer = soonJumpTimerDefault
	if (onGround) lateJumpTimer = lateJumpTimerDefault

	if (onGround and soonJumpTimer > 0) jumpReady = true
	if (!onGround and lateJumpTimer > 0 and jumpPressed) jumpReady = true

	#endregion

	if (!onGround)
	{
		if (wvsp <= 0 and jump) wvsp += grv * upGrvMult
		else wvsp += grv
	}
	if (jumpReady)
	{
		jumpReady = false
		
		var jmpSnd = choose(jump1,jump2,jump3,jump4)
		audio_play_sound(jmpSnd,0,0,.6)
		
		if (soonJumpTimer < soonJumpTimerDefault and jump) wvsp = 0
		wvsp -= jumpHeight
		soonJumpTimer = 0
		lateJumpTimer = 0
	}
	if (jumpReleased and vsp < -jumpHeight/4) wvsp = -jumpHeight/4
}

// Animation
if (rightPressed || leftPressed)
	side = rightPressed - leftPressed;
if (right || left) {
	frame = (frame + 0.1) % 4;
}
else frame = 4;
if (jumpPressed and onGround) {
	jumpTimer = 12;
}
if (jumpTimer > 0) {
	frame = 6;
	if (jumpTimer > 8)
		frame = 5;
	jumpTimer--;
}

// Momentum calculations before collision
hsp = whsp
vsp = wvsp

if (!noclip)
{
	#region Kolize
	//horizontal
	if (place_meeting(x + hsp,y,currentCollision) or place_meeting(x + sign(hsp),y,currentCollision))
	{
		while (!place_meeting(x + sign(hsp),y,currentCollision)) x = x + sign(hsp);
		x = round(x)
		whsp *= .5
		hsp = 0;
	}
	x += hsp


	//vertical
	if (place_meeting(x,y + vsp,currentCollision) or place_meeting(x,y + sign(vsp),currentCollision))
	{
		while (!place_meeting(x,y + sign(vsp),currentCollision)) y = y + sign(vsp);
		y = round(y)
		wvsp *= .5
		vsp = 0;
		y = round(y)
	}
	y += vsp
	#endregion
}

// Update liminal image
switch (currentState)
{	
	case STATE.LIMINAL:
	{
		with (opReal)
		{
			x += other.hsp
			y += other.vsp
		}
		realLayerX += hsp
		realLayerY += vsp
		//layer_x(realInstancesLayer, realLayerX)
		//layer_y(realInstancesLayer, realLayerY)
		break
	}
}

//show_debug_message("Wall" + string(oCollisionReal.x) + "  " + string(oCollisionReal.y))
//show_debug_message("Tiles" + string(realLayerX) + "  " + string(realLayerY))

show_debug_message("Tiles: " + string(currentKillTrigger))

