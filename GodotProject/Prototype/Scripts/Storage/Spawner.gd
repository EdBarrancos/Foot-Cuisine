extends Node2D

############
#COMPONENTS#
############

onready var timer = $Timer

###########
#VARIABLES#
###########

var rng = RandomNumberGenerator.new()

var shrimp = preload("res://Prototype/Scenes/Food/ShrimpStorage.tscn")
onready var spawnableFood = [shrimp]

export var initialVelocity = 50
export var MAXVELOCITY = 150
var velocity
export(float) var velocityIncreaseThres = 7

export var initialWaitTime = 1.3
export var MAXWAITTIME = 0.3
var waitTime
export(float) var waitTImeIncreaseThres = 0.1

var manager

########
#EVENTS#
########

func Init(manager_):
	manager = manager_
	Reset()
	
func Reset():
	rng.randomize()
	
	waitTime = initialWaitTime
	velocity = initialVelocity
	
	timer.set_wait_time(waitTime)
	
func UpdateValues():
	velocity += rng.randf_range(0,velocityIncreaseThres)
	waitTime -= rng.randf_range(0,waitTImeIncreaseThres)
	if velocity > MAXVELOCITY:
		velocity = MAXVELOCITY
	if waitTime < MAXWAITTIME:
		waitTime = MAXWAITTIME
	timer.set_wait_time(waitTime)

##############
#MISCELANIOUS#
##############

func Destroy(food):
	food.queue_free()

func Caught(food):
	manager.Caught(food.type)
	food.queue_free()


func _on_Timer_timeout():
	var food = spawnableFood[rng.randi_range(0,spawnableFood.size() - 1)].instance()
	food.set_linear_velocity(Vector2(0,velocity))
	food.set_angular_velocity(rng.randf_range(0,velocity) - rng.randf_range(0,velocity))
	food.Init(self)
	add_child(food)
	
	UpdateValues()
