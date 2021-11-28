extends Node2D

############
#COMPONENTS#
############

onready var timer = $Timer

###########
#VARIABLES#
###########

export(int) var DEFAULTTIME = 60
var currentTime

signal end_timer

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.


func InitiateGame():
	currentTime = DEFAULTTIME
	timer.start()
	
func GetMinutes():
	return int(currentTime / 60)

func GetSeconds():
	return currentTime - (int(currentTime / 60) * 60)


##############
#MISCELANIOUS#
##############

func UpdateTime(value):
	currentTime -= value
	if currentTime <= 0:
		emit_signal("end_timer")


func _on_Timer_timeout():
	UpdateTime(1)
