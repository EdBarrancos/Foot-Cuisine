extends Node2D

###########
#VARIABLES#
###########

onready var controller = false
var controller_last_position = Vector2.ZERO

export(float) var MAXHOLD = 250.0
export(float) var MAXVELOCITY = 300.0
onready var velocity = Vector2.ZERO
onready var holdMove = 0
export(float) var chargeUp = 2.0
onready var chargeUpCharge = 0

var linearVelocitySaved
var angularVelocitySaved
export(float) var slowMo = 3.0

var player

onready var slowMoActive = false

onready var aim = $Aim
export(int) var MIN_AIM_WIDTH = 3
export(int) var MAX_AIM_WIDTH = 8

export(int) var MULTIPLYER = 2
export(int) var MAX_MULTIPLYER = 150

export(float) var FLOOR_IMPULSE_OFFSET = -1.5
export(float) var CEILING_IMPULSE_OFFSET = 1.5

onready var rng = RandomNumberGenerator.new()

signal moved

########
#EVENTS#
########
func _ready():
	aim.add_point(Vector2.ZERO)
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	if Input.get_connected_joypads().size() >= 1:
		SetController()

func Init(Player):
	player = Player
	
	ResetVelocity()

func _process(_delta):
	GetInput()
	
func ActivateSlowMo():
	slowMoActive = true
	angularVelocitySaved = player.get_angular_velocity()
	linearVelocitySaved = player.get_linear_velocity()
	
	player.set_linear_velocity(linearVelocitySaved/slowMo)
	player.set_angular_velocity(angularVelocitySaved/slowMo)

func DeactivateSlowMo():
	slowMoActive = false
	player.set_linear_velocity(linearVelocitySaved)
	player.set_angular_velocity(angularVelocitySaved)

#######
#INPUT#
#######

func GetInput():
	if Input.is_action_pressed("MOVE_NEXT"):
		emit_signal("moved")
		
		holdMove += chargeUp + chargeUpCharge
		chargeUpCharge += chargeUp/2
		if holdMove >= MAXHOLD:
			holdMove = MAXHOLD
		
		SetAim(
			to_local(get_global_mouse_position()),
			holdMove)
		player.spriteManager.Turn(get_global_mouse_position())
		player.spriteManager.StartSquash(holdMove/MAXHOLD)
		
	if Input.is_action_just_released("MOVE_NEXT"):
		velocity = get_global_mouse_position() - global_position
		player.spriteManager.Turn(get_global_mouse_position())
		player.spriteManager.StopSquash()
		player.spriteManager.Stretch()
		Move()
		ResetVelocity()
		ResetHold()
		ResetAim()
		player.audioManager.PlayMove()
	
	var new_controller_last_position = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	if new_controller_last_position != Vector2.ZERO:
		controller_last_position = new_controller_last_position
		
func SetAim(point, current_hold):
	ResetAim()
	aim.add_point(point)
	
	var target_width = (MAX_AIM_WIDTH - MIN_AIM_WIDTH) * current_hold / MAXHOLD
	aim.width = target_width

func ResetAim():
	while aim.get_point_count() > 1:
		aim.remove_point(aim.get_point_count() - 1)

func get_global_mouse_position():
	print(controller)
	if controller:
		return controller_last_position.normalized() * get_parent().controller_raidus + global_position
	else:
		return get_viewport().get_mouse_position()
	
func SetController():
	controller = true

func SetKeyboard():
	controller = false
	
func _on_joy_connection_changed(device_id, connected):
	if connected:
		SetController()
	else:
		SetKeyboard()
		
##########
#VELOCITY#
##########

func Move():
	if holdMove > MAXHOLD:
		holdMove = MAXHOLD
	if slowMoActive:
		linearVelocitySaved = velocity.normalized()*holdMove
		player.set_linear_velocity(velocity.normalized()*holdMove/slowMo)
		return
		
	player.set_linear_velocity(velocity.normalized()*holdMove)
	player.Moved()
	player.level.get_parent().scoreTracker.ResetCombo()
	
func ResetVelocity():
	velocity = Vector2.ZERO
	
func ResetHold():
	holdMove = 0
	chargeUpCharge = 0
	
func MultiplyVelocity(value):
	rng.randomize()
	var rotation_angle = rand_range(FLOOR_IMPULSE_OFFSET, CEILING_IMPULSE_OFFSET)
	var force;
	
	if player.linear_velocity != Vector2.ZERO:
		force = player.linear_velocity.normalized().rotated(rotation_angle)
	else:
		force = Vector2(
			rng.randf_range(-1, 1),
			rng.randf_range(-1, 1)
		).normalized().rotated(rotation_angle)
	var multiplier = pow(value, MULTIPLYER)
	if multiplier >= MAX_MULTIPLYER:
		multiplier = MAX_MULTIPLYER
	player.apply_impulse(Vector2.ZERO, force*multiplier)
