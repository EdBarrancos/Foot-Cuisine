extends Node2D

############
#COMPONENTS#
############

###########
#VARIABLES#
###########

onready var inAreaOfFood = false
onready var foodInArea = []

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.


#func _process(delta):
#   pass


################
#UPDATING FOODS#
################



func FoodEntered(food):
	foodInArea.push_back(food)
	inAreaOfFood = true
	
func FoodExited(food):
	foodInArea.remove(foodInArea.find(food))
	if foodInArea.size() <= 0:
		inAreaOfFood = false
	return inAreaOfFood
