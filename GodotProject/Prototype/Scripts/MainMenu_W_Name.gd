extends Node2D

############
#COMPONENTS#
############

onready var highScoreLabel = $MarginContainer/VBoxContainer2/HIGHSCORE
onready var player_name = $MarginContainer/VBoxContainer2/VBoxContainer/Play
onready var pName = "DEF"

###########
#VARIABLES#
###########

signal play

########
#EVENTS#
########

func Init():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if player_name.text != "":
			pName = player_name.text.to_upper()
		Global.pName = pName
		emit_signal("play")


##############
#MISCELANIOUS#
##############

func _on_EXIT_pressed():
	get_tree().quit()

