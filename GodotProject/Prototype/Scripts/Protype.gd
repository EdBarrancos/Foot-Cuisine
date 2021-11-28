extends Node2D

############
#COMPONENTS#
############

onready var kitchen = $Kitchen

onready var scoreLabel = $CanvasLayer/Score
onready var scoreTracker = $ScoreTracker
onready var comboLabel = $CanvasLayer/Combo

export(int) var maxComboSize = 18

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
	
	UpdateLabel(scoreLabel)
	UpdateLabel(timerLabel)
	UpdateLabel(comboLabel)
	
	Start()
	
func _process(_delta):
	scoreLabel.set_text(str("score. ", scoreTracker.GetScore()))
	timerLabel.set_text(str(timer.GetMinutes(),".", timer.GetSeconds()))
	comboLabel.set_text(str(scoreTracker.GetCombo()))
	
	var size = scoreTracker.GetCombo()*2
	if size > maxComboSize:
		size = maxComboSize
	comboLabel.get_font("normal_font").size = 10 + size
	
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

func UpdateLabel(label):
	label.get_font("normal_font").font_data.antialiased = false
	label.get_font("normal_font").use_filter = true
	label.get_font("normal_font").use_filter = false


func _on_Timer_end_timer():
	End()
	Start()
