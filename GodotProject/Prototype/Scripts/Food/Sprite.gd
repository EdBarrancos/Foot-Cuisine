extends Node2D

############
#COMPONENTS#
############

onready var mainSprite = $Sprite
onready var rangeSprite = $Range

###########
#VARIABLES#
###########

onready var precision = 0.02
onready var alphaRange = 0.4

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.


func ActivateOutline():
	mainSprite.material.set_shader_param("precision", precision)
	rangeSprite.material.set_shader_param("inner_alpha", 0)

func DeactivateOutline():
	mainSprite.material.set_shader_param("precision", 0)
	rangeSprite.material.set_shader_param("inner_alpha", alphaRange)


##############
#MISCELANIOUS#
##############
