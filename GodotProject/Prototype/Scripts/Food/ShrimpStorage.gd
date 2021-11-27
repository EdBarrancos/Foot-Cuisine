extends RigidBody2D

############
#COMPONENTS#
############

###########
#VARIABLES#
###########

var manager

onready var type = Global.FoodTypes.Shrimp

########
#EVENTS#
########

func Init(manager_):
	manager = manager_


#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############

func Destroy():
	manager.Destroy(self)


func _on_ShrimpStorage_body_entered(body):
	if body.name == "PlayerStorage":
		manager.Caught(self)
