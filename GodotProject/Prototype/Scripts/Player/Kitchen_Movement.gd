extends Node2D

###########
#VARIABLES#
###########

export(float) var MAXHOLD = 250
onready var velocity = Vector2.ZERO
onready var holdMove = 0
export(float) var chargeUp = 2
onready var chargeUpCharge = 0

var player

########
#EVENTS#
########

func Init(Player):
	player = Player
	
	ResetVelocity()


func _process(delta):
	GetInput()
	


#######
#INPUT#
#######

func GetInput():
	if Input.is_action_pressed("MOVE_NEXT"):
		holdMove += chargeUp + chargeUpCharge
		chargeUpCharge += chargeUp/2
		print(holdMove)
	if Input.is_action_just_released("MOVE_NEXT"):
		velocity = get_viewport().get_mouse_position() - global_position
		Move()
		ResetVelocity()
		ResetHold()
##########
#VELOCITY#
##########

func Move():
	if holdMove > MAXHOLD:
		holdMove = MAXHOLD
	player.set_linear_velocity(velocity.normalized()*holdMove)

func ResetVelocity():
	velocity = Vector2.ZERO
	
func ResetHold():
	holdMove = 0
	chargeUpCharge = 0
