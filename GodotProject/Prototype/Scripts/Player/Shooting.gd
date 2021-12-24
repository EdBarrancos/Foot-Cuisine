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

var player

########
#EVENTS#
########

func Init(p):
	player = p
	
func _process(_delta):
	GetInput()

func GetInput():
	if inAreaOfFood:
		if Input.is_action_pressed("FIRE"):
			holdFire += chargeUp + chargeUpCharge
			chargeUpCharge += chargeUp/2
		if Input.is_action_just_released("FIRE"):
			velocity = get_viewport().get_mouse_position() - global_position
			Shoot(GetTargetFood())
			player.audioManager.PlayFireFood()
	
func Shoot(target):
	if target:
		if holdFire > MAXHOLD:
			holdFire = MAXHOLD
		target.SetVelocity(velocity.normalized()*holdFire)
################
#UPDATING FOODS#
################

func GetTargetFood():
	if foodInArea.size() <= 0:
		return null
	return foodInArea[0]

func FoodEntered(food):
	var before = inAreaOfFood
	foodInArea.push_back(food)
	if not before:
		food.SetTarget(true)
	inAreaOfFood = true
	return before
	
func FoodExited(food):
	if GetTargetFood() == food:
		food.SetTarget(false)
	foodInArea.remove(foodInArea.find(food))
	if foodInArea.size() <= 0:
		inAreaOfFood = false
	return inAreaOfFood
