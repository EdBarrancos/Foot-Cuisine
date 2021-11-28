extends Node2D

############
#COMPONENTS#
############

onready var timer = $Timer

###########
#VARIABLES#
###########

var manager

export(float) var defaultTime = 0.6
var time

onready var rng = RandomNumberGenerator.new()

var shrimp = preload("res://Prototype/Scenes/Food/Shrimp.tscn")
onready var spawnableFood = [shrimp]

var firstQuadrant
var secondQuadrant
var thirdQuadrant
var forthQuadrant

var quadrants


########
#EVENTS#
########

func Init(manager_):
	manager = manager_
	timer.start()
	
	firstQuadrant = manager.GetFirstQuadrant()
	secondQuadrant = manager.GetSecondQuadrant()
	thirdQuadrant = manager.GetThirdQuadrant()
	forthQuadrant = manager.GetForthQuadrant()
	quadrants = [firstQuadrant, secondQuadrant, thirdQuadrant, forthQuadrant]

#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############

func GetSpawnQuadrant():
	rng.randomize()
	
	var quad = rng.randi_range(0, quadrants.size() - 1)
	while(not manager.IsPlayerInQuadrant(quad + 1)):
		quad = rng.randi_range(0, quadrants.size() - 1)
	return quad
	
func GetSpawnPosition():
	rng.randomize()
	
	var quadrant = GetSpawnQuadrant()
	var x = rng.randi_range(quadrants[quadrant][0].x,quadrants[quadrant][1].x)
	var y = rng.randi_range(quadrants[quadrant][0].y,quadrants[quadrant][1].y)
	return Vector2(x,y)
	
func Spawn():
	manager.foodManager.SpawnFood(spawnableFood[rng.randi_range(0,spawnableFood.size() - 1)].instance(), GetSpawnPosition())
	
func _on_Timer_timeout():
	Spawn()
