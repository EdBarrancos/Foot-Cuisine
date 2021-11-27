extends Area2D

############
#COMPONENTS#
############

onready var manager = get_parent()

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.


#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############


func _on_Caldron_area_entered(area):
	manager.Score()
	area.GetParent().Destroy()
