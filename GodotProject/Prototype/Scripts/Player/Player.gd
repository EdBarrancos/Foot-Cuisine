extends RigidBody2D

############
#COMPONENTS#
############

onready var kitchen_movement = $Kitchen_Movement
onready var shooting = $Shooting

onready var spriteManager = $SpriteManger

onready var audioManager = $AudioManager

###########
#VARIABLES#
###########

var level

onready var updatePosition = false
var newPosition

signal moved
signal kicked

########
#EVENTS#
########

func Moved():
	#level.emit_signal("moved")
	pass

func Init(level_):
	level = level_
	kitchen_movement.Init(self)
	shooting.Init(self)

func EndGame(nPos):
	spriteManager.StopSquash()
	spriteManager.StopStretch()
	set_linear_velocity(Vector2.ZERO)
	SetPos(nPos)

func SetPos(newPosition_):
	updatePosition = true
	newPosition = newPosition_

func _integrate_forces(state):
	if updatePosition:
		state.transform = Transform2D(0,newPosition)
		updatePosition = false

##########
#VELOCITY#
##########

func MultiplyVelocity(value):
	print("hello")
	kitchen_movement.MultiplyVelocity(value)

#########
#KITCHEN#
#########

func GetTargetPosition():
	return level.GetCurrentTarget().position
	
func FoodEntered(food):
	if not shooting.FoodEntered(food):
		kitchen_movement.ActivateSlowMo()
	
func FoodExited(food):
	if not shooting.FoodExited(food):
		kitchen_movement.DeactivateSlowMo()


func _on_Player_body_entered(_body):
	spriteManager.StopStretch()
	spriteManager.StartSquash(1)
	
	audioManager.PlayHitWall()
	


func _on_Player_body_exited(_body):
	spriteManager.StopSquash()


func _on_Kitchen_Movement_moved():
	emit_signal("moved")


func _on_Shooting_kicked():
	emit_signal("kicked")
