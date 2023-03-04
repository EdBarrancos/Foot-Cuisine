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

func Stop():
	timer.stop()
	
func GetMinutes():
	if currentTime:
		return int(currentTime / 60)
	else: 
		return 0

func GetSeconds():
	if currentTime:
		return currentTime - (int(currentTime / 60) * 60)
	else:
		return 0

##############
#MISCELANIOUS#
##############

func UpdateTime(value):
	currentTime -= value
	if currentTime <= 0:
		emit_signal("end_timer")


func _on_Timer_timeout():
	UpdateTime(1)


func _on_ScoreTracker_score(previous_combo):
	if previous_combo >= 3:
		UpdateTime(-1)
