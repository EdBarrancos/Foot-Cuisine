extends KinematicBody2D

############
#COMPONENTS#
############

onready var movement = $PlayerMovement

###########
#VARIABLES#
###########

var level

########
#EVENTS#
########

func Init(level_):
	level = level_
	movement.Init(self)


#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############
