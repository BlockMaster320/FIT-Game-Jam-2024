#macro TL_SIZE 8

enum STATE
{
	REAL,
	LIMINAL,
	TRANSITION_TO_REAL,
	DEAD
}

deathStateLength = 25

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
transitionWaitDef = 15
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
realTransparency = .5
realAlpha = 1
liminalLayer = layer_get_id("Liminal")
tileLiminal = layer_tilemap_get_id("Liminal")
layer_set_visible(liminalLayer,false)
liminalLayerX = 0
liminalLayerY = 0
liminalTransparency = .2
liminalAlpha = liminalTransparency
liminalOffset = 2

tileSpikeReal = layer_tilemap_get_id("SpikeReal")
tileSpikeLiminal = layer_tilemap_get_id("SpikeLiminal")
tileSpikeEffect = layer_get_fx("SpikeReal")

realInstancesLayer = layer_get_id("RealInstances")
//layer_depth(realInstancesLayer,450)

alp = 1

realSurf = surface_create(room_width,room_height)
liminalSurf = surface_create(room_width,room_height)

liminalEffect = fx_create("_filter_underwater")
fx_set_parameter(liminalEffect,"g_Distort1Speed",.012)
fx_set_parameter(liminalEffect,"g_Distort2Speed",.005)
fx_set_parameter(liminalEffect,"g_Distort2Scale",[100,37])
fx_set_parameter(liminalEffect,"g_Distort1Amount",0)
fx_set_parameter(liminalEffect,"g_Distort2Amount",1.25)
fx_set_parameter(liminalEffect,"g_ChromaSpreadAmount",10)
fx_set_parameter(liminalEffect,"g_CamOffsetScale",3.25)
fx_set_parameter(liminalEffect,"g_GlintCol",[0,0,0])
fx_set_parameter(liminalEffect,"g_TintCol",[1,1,1])
fx_set_parameter(liminalEffect,"g_AddCol",[0,0,0])
layer_clear_fx("Vignette_1")


impactDustSys = part_system_create()
impactDust = part_type_create()
part_type_size(impactDust,.5,2,0,0)
part_type_life(impactDust,30,60)
part_type_speed(impactDust,.2,.5,-.005,0)
part_type_gravity(impactDust,.002,90)
part_type_sprite(impactDust,sDust,false,false,true)

bloodSys = part_system_create()
blood = part_type_create()
part_type_life(blood,10,60)
part_type_speed(blood,2,4,0,0)
part_type_color2(blood, #E51414, #66220F)
part_type_gravity(blood,.08,270)

shiftSys = part_system_create()
shift = part_type_create()
part_type_life(shift,20,25)
part_type_speed(shift,.05,.1,0,0)
part_type_sprite(shift,sPlayer,0,false,false)
part_type_alpha2(shift,.5,0)

deathDir = 0

onGround = true

#region Better jump
jumpReady = false

soonJumpTimerDefault = 7
soonJumpTimer = 0
lateJumpTimerDefault = 7
lateJumpTimer = 0
#endregion

// Animation
side = 1;
frame = 0;
jumpTimer = 0;
