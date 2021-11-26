extends Node2D

############
#COMPONENTS#
############

onready var kitchen = $Kitchen

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	kitchen.Init()


#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############
