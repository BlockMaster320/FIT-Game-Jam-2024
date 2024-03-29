Input()

switch (currentState)
{
	case STATE.TRANSITION_TO_REAL:
	{
		if (point_distance(x,y,realX,realY) < transitionSpeed)
		{
			x = realX
			y = realY
			wvsp = realwvsp
			noclip = false
			control = true
			currentState = STATE.REAL
			currentCollision = oCollisionReal
			break
		}
		x += lengthdir_x(transitionSpeed,point_direction(x,y,realX,realY))
		y += lengthdir_y(transitionSpeed,point_direction(x,y,realX,realY))
		break
	}
}


if (liminalJump)
{
	if (currentState == STATE.REAL or currentState == STATE.LIMINAL) currentState++
	switch (currentState)
	{
		case STATE.REAL:
		{
			currentCollision = oCollisionReal
			realwvsp = wvsp
			break
		}
		
		case STATE.LIMINAL:
		{
			realX = x
			realY = y
			currentCollision = oCollisionLiminal
			break
		}
		
		case STATE.TRANSITION_TO_REAL:
		{
			currentCollision = oEmpty
			noclip = true
			control = false
			break
		}
	}
}

whsp = 0
if (control)
{
	//Movement and jump
	whsp = (right - left) * walkSp

	#region Better jump
	soonJumpTimer = max(soonJumpTimer-1,0)
	lateJumpTimer = max(lateJumpTimer-1,0)

	if (jumpPressed) soonJumpTimer = soonJumpTimerDefault
	if (place_meeting(x,y+1,currentCollision)) lateJumpTimer = lateJumpTimerDefault

	if (place_meeting(x,y+1,currentCollision) and soonJumpTimer > 0) jumpReady = true
	if (!place_meeting(x,y+1,currentCollision) and lateJumpTimer > 0 and jumpPressed) jumpReady = true

	#endregion

	if (!place_meeting(x,y+1,currentCollision)) wvsp += grv
	if (jumpReady)
	{
		jumpReady = false
		if (soonJumpTimer < soonJumpTimerDefault and !jump) wvsp -= jumpHeight / 4
		else wvsp -= jumpHeight
		soonJumpTimer = 0
		lateJumpTimer = 0
	}
	if (jumpReleased and vsp < -jumpHeight/4) wvsp = -jumpHeight/4
}

// Momentum calculations before collision
hsp = whsp
vsp = wvsp

if (!noclip)
{
	#region Kolize
	//horizontal
	if (place_meeting(x + hsp,y,currentCollision))
	{
		while (!place_meeting(x + sign(hsp),y,currentCollision)) x = x + sign(hsp);
		hsp = 0;
	}
	x += hsp


	//vertical
	if (place_meeting(x,y + vsp,currentCollision))
	{
		while (!place_meeting(x,y + sign(vsp),currentCollision)) y = y + sign(vsp);
		wvsp = 0
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
		realX -= hsp
		realY -= vsp
		break
	}
}