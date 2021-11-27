extends Food

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
	
func Init(manager_):
	.Init(manager_)

	
func _on_Area2D_body_entered(body):
	print("entered")
	emit_signal("playerInRange", self)


func _on_Area2D_body_exited(body):
	emit_signal("playerOutRange", self)
