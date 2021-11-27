extends Node2D

############
#COMPONENTS#
############

###########
#VARIABLES#
###########

var player

onready var velocity = Vector2.ZERO


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
	elif Input.is_action_pressed("RIGHT"):
		velocity = Vector2(1,0)
	else:
		velocity = Vector2.ZERO


##########
#MOVEMENT#
##########

func Move():
	player.move_and_slide(velocity*200)
