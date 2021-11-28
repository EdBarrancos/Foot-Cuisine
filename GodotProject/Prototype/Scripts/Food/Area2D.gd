extends Area2D

############
#COMPONENTS#
############

###########
#VARIABLES#
###########

var parent

########
#EVENTS#
########

func Init(parent_):
	parent = parent_
	
func GetParent():
	return parent


#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############


func _on_Area2D_body_exited(body):
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	pass # Replace with function body.
