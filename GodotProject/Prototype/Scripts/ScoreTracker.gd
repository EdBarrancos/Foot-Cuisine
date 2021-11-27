extends Node2D

############
#COMPONENTS#
############

onready var scoreSoundDefault = $ScoreDefault

###########
#VARIABLES#
###########

onready var score = 0

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.


func GetScore():
	return score
	
func FoodScore():
	scoreSoundDefault.play()
	score += 1


##############
#MISCELANIOUS#
##############
