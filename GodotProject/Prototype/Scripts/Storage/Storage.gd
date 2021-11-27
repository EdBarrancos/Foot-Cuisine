extends Node2D

############
#COMPONENTS#
############

onready var player = $PlayerStorage

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	player.Init(self)


#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############
