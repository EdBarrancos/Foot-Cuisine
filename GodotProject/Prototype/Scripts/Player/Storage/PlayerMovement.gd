extends Node2D

############
#COMPONENTS#
############

###########
#VARIABLES#
###########

var player

onready var velocity = Vector2.ZERO

signal moving_left
signal moving_right
signal stopped

########
#EVENTS#
########

func Init(player_):
	player = player_


func _process(delta):
	GetInput()
	
func _physics_process(delta):
	Move()

func GetInput():
	if Input.is_action_pressed("LEFT"):
		velocity = Vector2(-1,0)
		emit_signal("moving_left")
	elif Input.is_action_pressed("RIGHT"):
		velocity = Vector2(1,0)
		emit_signal("moving_right")
	else:
		velocity = Vector2.ZERO
		emit_signal("stopped")


##########
#MOVEMENT#
##########

func Move():
	player.move_and_slide(velocity*200)
