extends Node2D

###########
#VARIABLES#
###########

var foodList : Array
onready var currentFoodTarget = 0

var level

########
#EVENTS#
########

func Init(level_):
	level = level_
	
	CreateFoodList()


#func _process(delta):
#   pass

###########
#FOOD LIST#
###########


func CreateFoodList():
	for food in get_children():
		foodList.push_back(food)
	return foodList
		
func UpdateFoodList():
	for food in get_children():
		if not foodList.has(food):
			foodList.push_back(food)
	return foodList

func GetCurrentFoodItem():
	return foodList[currentFoodTarget]

func UpdateCurrentFoodItem():
	if currentFoodTarget + 1 >= foodList.size():
		currentFoodTarget = 0
		return currentFoodTarget
	currentFoodTarget += 1
	return currentFoodTarget
