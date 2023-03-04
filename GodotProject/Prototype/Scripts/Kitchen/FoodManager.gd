extends Node2D

###########
#VARIABLES#
###########

var foodList : Array
onready var currentFoodTarget = 0

export(int) var maxNumberOfFood = 10
export(int) var lowNumberOfFood = 4
export(int) var minNumberOfFood = 2
 
var level

signal min_food(current, target)
signal low_food
signal good_food

########
#EVENTS#
########

func Init(level_):
	level = level_
	
	InitAllFood()

func GetPlayer():
	return level.player
	
#########################
#REGULATE NUMBER OF FOOD#
#########################

func GetCurrentNumberOfFood():
	var nbr = 0
	for i in get_children():
		nbr += 1
	return nbr
	
func IsMaxFoodReached():
	return GetCurrentNumberOfFood() >= maxNumberOfFood
	
###########
#FOOD LIST#
###########

func DestroyAllFood():
	for food in get_children():
		food.queue_free()

func SpawnFood(foodInstance, pos):
	if not IsMaxFoodReached():
		add_child(foodInstance)
		foodInstance.Init(self)
		foodInstance.position = pos
	if GetCurrentNumberOfFood() > lowNumberOfFood:
		emit_signal("good_food")

func DestroyFood(food):
	food.queue_free()
	if GetCurrentNumberOfFood() < minNumberOfFood:
		emit_signal("min_food",GetCurrentNumberOfFood(), minNumberOfFood)
	elif GetCurrentNumberOfFood() <= lowNumberOfFood:
		emit_signal("low_food")

func InitAllFood():
	for food in get_children():
		food.Init(self)
