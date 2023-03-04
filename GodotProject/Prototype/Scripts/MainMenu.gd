extends Node2D

############
#COMPONENTS#
############


###########
#VARIABLES#
###########

signal play

########
#EVENTS#
########

func Init():
	pass # Replace with function body.


##############
#MISCELANIOUS#
##############


func _on_Play_pressed():
	emit_signal("play")


func _on_EXIT_pressed():
	get_tree().quit()
