extends Area2D

############
#COMPONENTS#
############

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


func _on_Death_body_entered(body):
	body.Destroy()
