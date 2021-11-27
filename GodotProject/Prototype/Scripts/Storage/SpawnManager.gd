extends Node2D

############
#COMPONENTS#
############

###########
#VARIABLES#
###########

var level

onready var foodCaught = []

########
#EVENTS#
########

func Init(level_):
	level = level_
	for spawn in get_children():
		spawn.Init(self)
		
func Reset():
	foodCaught = []
	for spawn in get_children():
		spawn.Reset()

func Caught(foodType):
	foodCaught.push_back(foodType)



##############
#MISCELANIOUS#
##############
