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
	
	InitAllFood()

func GetPlayer():
	return level.player

###########
#FOOD LIST#
###########

func SpawnFood(foodInstance, pos):
	add_child(foodInstance)
	foodInstance.Init(self)
	foodInstance.position = pos

func DestroyFood(food):
	food.queue_free()

func InitAllFood():
	for food in get_children():
		food.Init(self)
