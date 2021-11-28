extends Node2D

############
#COMPONENTS#
############

onready var kitchen = $Kitchen

onready var scoreLabel = $CanvasLayer/Score
onready var scoreTracker = $ScoreTracker

onready var timerLabel = $CanvasLayer/Timer
onready var timer = $Timer

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	kitchen.Init()
	
	Start()
	
func _process(_delta):
	scoreLabel.set_text(str("SCORE: ", scoreTracker.GetScore()))
	timerLabel.set_text(str(timer.GetMinutes(),":", timer.GetSeconds()))
	
	if Input.is_action_just_pressed("RESTART"):
		End()
		Start()

func Start():
	scoreTracker.InitiateGame()
	kitchen.InitiateGame()
	timer.InitiateGame()

func End():
	scoreTracker.EndGame()
	kitchen.EndGame()

####################
#SAVE AND LOAD GAME#
####################


func _on_Timer_end_timer():
	End()
	Start()
