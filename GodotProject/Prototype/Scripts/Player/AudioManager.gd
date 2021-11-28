extends Node2D

############
#COMPONENTS#
############

onready var hitWall = $HitWallSound
onready var move = $MoveSound
onready var fireFood = $FireFoodSound

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.


func PlayHitWall():
	hitWall.play()
	
func PlayMove():
	move.play()
	
func PlayFireFood():
	fireFood.play()

##############
#MISCELANIOUS#
##############
