extends Node2D

###########
#VARIABLES#
###########

export(float) var MAXVELOCITY = 50
onready var velocity = Vector2.ZERO
onready var holdMove = 50

var player

########
#EVENTS#
########

func Init(Player):
	player = Player


func _process(delta):
	GetInput()
	


#######
#INPUT#
#######

func GetInput():
	if Input.is_action_pressed("MOVE_NEXT"):
		#HOlDING CHARGE
		pass
	if Input.is_action_just_released("MOVE_NEXT"):
		velocity = get_viewport().get_mouse_position() - global_position
		player.set_linear_velocity(velocity)
	
##########
#VELOCITY#
##########
