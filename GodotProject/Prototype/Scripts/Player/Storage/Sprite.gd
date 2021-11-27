extends Sprite

############
#COMPONENTS#
############

###########
#VARIABLES#
###########

export var movementDegrees = 7

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.


#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############


func _on_PlayerMovement_moving_left():
	set_rotation_degrees(-movementDegrees)


func _on_PlayerMovement_moving_right():
	set_rotation_degrees(movementDegrees)


func _on_PlayerMovement_stopped():
	set_rotation_degrees(0)
