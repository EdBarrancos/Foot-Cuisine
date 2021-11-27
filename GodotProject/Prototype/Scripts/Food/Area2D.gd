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
