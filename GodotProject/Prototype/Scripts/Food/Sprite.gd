extends Node2D

############
#COMPONENTS#
############

onready var mainSprite = $Sprite

###########
#VARIABLES#
###########

onready var precision = 0.02

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.


func ActivateOutline():
	mainSprite.material.set_shader_param("precision", precision)

func DeactivateOutline():
	mainSprite.material.set_shader_param("precision", 0)


##############
#MISCELANIOUS#
##############
