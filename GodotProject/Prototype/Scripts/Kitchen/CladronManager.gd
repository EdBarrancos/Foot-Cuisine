extends Node2D

############
#COMPONENTS#
############

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.


func Score():
	get_parent().get_parent().scoreTracker.FoodScore()


##############
#MISCELANIOUS#
##############
