extends Node2D

############
#COMPONENTS#
############

onready var highScoreLabel = $MarginContainer/VBoxContainer2/HIGHSCORE
onready var player_name = $MarginContainer/VBoxContainer2/VBoxContainer/Play

###########
#VARIABLES#
###########

signal play

########
#EVENTS#
########

func Init():
	pass # Replace with function body.


#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############


func _on_Play_pressed():
	emit_signal("play")


func _on_EXIT_pressed():
	get_tree().quit()
