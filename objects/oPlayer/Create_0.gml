#macro TL_SIZE 8

enum STATE
{
	REAL,
	LIMINAL,
	TRANSITION_TO_REAL,
	DEAD
}

deathStateLength = 20

whsp = 0
wvsp = 0
hsp = 0
vsp = 0
acc = .2
groundFrict = .5
airFrict = .93
maxSpd = 1
jumpHeight = 2
grv = .2
upGrvMult = .4
maxWvsp = 2.5
onGround = false

currentState = STATE.REAL
realX = x
realY = y
realwvsp = 0
realwhsp = 0
transitionSpeedDef = .5
transitionSpeedAcc = 1
transitionSpeed = transitionSpeedDef
transitionWaitDef = 20
transitionWait = transitionWaitDef
noclip = false
control = true

currentCollision = oCollisionReal
currentKillTrigger = oKillReal

realLayer = layer_get_id("Real")
tileReal = layer_tilemap_get_id("Real")
layer_set_visible(realLayer,false)
realLayerX = 0
realLayerY = 0
realTransparency = .3
realAlpha = 1
liminalLayer = layer_get_id("Liminal")
tileLiminal = layer_tilemap_get_id("Liminal")
layer_set_visible(liminalLayer,false)
liminalLayerX = 0
liminalLayerY = 0
liminalTransparency = .3
liminalAlpha = liminalTransparency
liminalOffset = 2

realInstancesLayer = layer_get_id("RealInstances")
layer_depth(realInstancesLayer,450)

realSurf = surface_create(room_width,room_height)
liminalSurf = surface_create(room_width,room_height)

liminalEffectLayer = layer_get_id("LiminalEffect1")
layer_set_visible(liminalEffectLayer,true)
liminalEffect = layer_get_fx(liminalEffectLayer)
layer_clear_fx(liminalEffectLayer)


#region Better jump
jumpReady = false

soonJumpTimerDefault = 7
soonJumpTimer = 0
lateJumpTimerDefault = 7
lateJumpTimer = 0
#endregion
