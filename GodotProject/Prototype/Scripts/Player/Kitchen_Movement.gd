extends Node2D

###########
#VARIABLES#
###########

export(float) var MAXHOLD = 250
onready var velocity = Vector2.ZERO
onready var holdMove = 0
export(float) var chargeUp = 2
onready var chargeUpCharge = 0

var linearVelocitySaved
var angularVelocitySaved
export(float) var slowMo = 3

var player

onready var slowMoActive = false

########
#EVENTS#
########

func Init(Player):
	player = Player
	
	ResetVelocity()


func _process(delta):
	GetInput()
	
	
func ActivateSlowMo():
	slowMoActive = true
	angularVelocitySaved = player.get_angular_velocity()
	linearVelocitySaved = player.get_linear_velocity()
	
	player.set_linear_velocity(linearVelocitySaved/slowMo)
	player.set_angular_velocity(angularVelocitySaved/slowMo)

func DeactivateSlowMo():
	slowMoActive = false
	player.set_linear_velocity(linearVelocitySaved)
	player.set_angular_velocity(angularVelocitySaved)

#######
#INPUT#
#######

func GetInput():
	if Input.is_action_pressed("MOVE_NEXT"):
		holdMove += chargeUp + chargeUpCharge
		chargeUpCharge += chargeUp/2
		player.spriteManager.Turn(get_viewport().get_mouse_position())
		player.spriteManager.StartSquash(holdMove/MAXHOLD)
	if Input.is_action_just_released("MOVE_NEXT"):
		velocity = get_viewport().get_mouse_position() - global_position
		player.spriteManager.Turn(get_viewport().get_mouse_position())
		player.spriteManager.StopSquash()
		player.spriteManager.Stretch()
		Move()
		ResetVelocity()
		ResetHold()
##########
#VELOCITY#
##########

func Move():
	if holdMove > MAXHOLD:
		holdMove = MAXHOLD
	if slowMoActive:
		linearVelocitySaved = velocity.normalized()*holdMove
		player.set_linear_velocity(velocity.normalized()*holdMove/slowMo)
		return
		
	player.set_linear_velocity(velocity.normalized()*holdMove)

func ResetVelocity():
	velocity = Vector2.ZERO
	
func ResetHold():
	holdMove = 0
	chargeUpCharge = 0
