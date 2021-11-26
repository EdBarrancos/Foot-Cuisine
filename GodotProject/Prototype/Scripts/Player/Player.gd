extends RigidBody2D

############
#COMPONENTS#
############

onready var kitchen_movement = $Kitchen_Movement

var level

###########
#VARIABLES#
###########


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
