extends RigidBody2D

############
#COMPONENTS#
############

onready var kitchen_movement = $Kitchen_Movement
onready var shooting = $Shooting

onready var spriteManager = $SpriteManger

###########
#VARIABLES#
###########

var level

########
#EVENTS#
########

func Init(level_):
	level = level_
	kitchen_movement.Init(self)


#func _process(delta):
#   pass


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


func _on_Player_body_entered(body):
	spriteManager.StopStretch()
	spriteManager.StartSquash(1)
	


func _on_Player_body_exited(body):
	spriteManager.StopSquash()
