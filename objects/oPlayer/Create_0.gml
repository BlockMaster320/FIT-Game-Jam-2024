#macro TL_SIZE 8

enum STATE
{
	REAL,
	LIMINAL,
	TRANSITION_TO_REAL,
	LENGTH
}
currentState = STATE.REAL
realX = x
realY = y
realwvsp = 0
transitionSpeed = 4
noclip = false
control = true

currentCollision = oCollisionReal

whsp = 0
wvsp = 0
hsp = 0
vsp = 0
walkSp = .8
jumpHeight = 2
grv = .1
onGround = false

#region Better jump
jumpReady = false

soonJumpTimerDefault = 7
soonJumpTimer = 0
lateJumpTimerDefault = 7
lateJumpTimer = 0
#endregion

//layer_depth("Liminal", 350)