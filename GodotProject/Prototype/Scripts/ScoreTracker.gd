extends Node2D

############
#COMPONENTS#
############

onready var score = 0

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.


func GetScore():
	return score
	
func FoodScore():
	print(score)
	score += 1


##############
#MISCELANIOUS#
##############
