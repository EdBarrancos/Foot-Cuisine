extends Node2D

############
#COMPONENTS#
############

onready var player = $Player
onready var foodManager = $FoodManager

###########
#VARIABLES#
###########

########
#EVENTS#
########

func Init():
	player.Init(self)
	foodManager.Init(self)


#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############

func GetCurrentTarget():
	var target = foodManager.GetCurrentFoodItem()
	foodManager.UpdateCurrentFoodItem()
	return target
