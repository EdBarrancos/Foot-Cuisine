extends Node2D

############
#COMPONENTS#
############

###########
#VARIABLES#
###########

export(float) var MAXHOLD = 250
onready var velocity = Vector2.ZERO
onready var holdFire = 100
export(float) var chargeUp = 2
onready var chargeUpCharge = 0

onready var inAreaOfFood = false
onready var foodInArea = []

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	GetInput()

func GetInput():
	if inAreaOfFood:
		if Input.is_action_pressed("FIRE"):
			#HOLD
			pass
		if Input.is_action_just_released("FIRE"):
			velocity = get_viewport().get_mouse_position() - global_position
			print(velocity)
			Shoot(GetTargetFood())
	
func Shoot(target):
	if target:
		target.SetVelocity(velocity.normalized()*holdFire)
################
#UPDATING FOODS#
################

func GetTargetFood():
	if foodInArea.size() <= 0:
		return null
	return foodInArea[0]

func FoodEntered(food):
	foodInArea.push_back(food)
	inAreaOfFood = true
	
func FoodExited(food):
	foodInArea.remove(foodInArea.find(food))
	if foodInArea.size() <= 0:
		inAreaOfFood = false
	return inAreaOfFood