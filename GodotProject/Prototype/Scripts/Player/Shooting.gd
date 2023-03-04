extends Node2D

############
#COMPONENTS#
############

onready var aim = $Aim
export(int) var MIN_AIM_WIDTH = 3
export(int) var MAX_AIM_WIDTH = 8

signal kicked

###########
#VARIABLES#
###########

export(float) var MAXHOLD = 250.0
onready var velocity = Vector2.ZERO
onready var holdFire = 100
export(float) var chargeUp = 2.0
onready var chargeUpCharge = 0

onready var inAreaOfFood = false
onready var foodInArea = []

var player

########
#EVENTS#
########

func Init(p):
	player = p
	aim.add_point(Vector2.ZERO)
	
func _process(_delta):
	GetInput()

func GetInput():
	if inAreaOfFood:
		if Input.is_action_pressed("FIRE"):
			emit_signal("kicked")
			
			holdFire += chargeUp + chargeUpCharge
			chargeUpCharge += chargeUp/2
			if holdFire > MAXHOLD:
				holdFire = MAXHOLD
			SetAim(
				to_local(get_viewport().get_mouse_position()),
				holdFire)
		if Input.is_action_just_released("FIRE"):
			velocity = get_viewport().get_mouse_position() - global_position
			Shoot(GetTargetFood())
			player.audioManager.PlayFireFood()
			ResetAim()
	else:
		ResetAim()
	
func Shoot(target):
	if target:
		if holdFire > MAXHOLD:
			holdFire = MAXHOLD
		target.SetVelocity(velocity.normalized()*holdFire)
		
func SetAim(point, current_hold):
	ResetAim()
	aim.add_point(point)
	
	var target_width = (MAX_AIM_WIDTH - MIN_AIM_WIDTH) * current_hold / MAXHOLD
	aim.width = target_width

func ResetAim():
	while aim.get_point_count() > 1:
		aim.remove_point(aim.get_point_count() - 1)

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
