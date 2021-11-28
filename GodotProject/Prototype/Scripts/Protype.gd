extends Node2D

############
#COMPONENTS#
############

var kitchen = preload("res://Prototype/Scenes/Kitchen/Kitchen.tscn")
var mainMenu = preload("res://Prototype/Scenes/MainMenu.tscn")

onready var scoreLabel = $CanvasLayer/Score
onready var scoreTracker = $ScoreTracker
onready var comboLabel = $CanvasLayer/Combo

onready var timerLabel = $CanvasLayer/Timer
onready var timer = $Timer

onready var musicPlayer = $MusicManger



###########
#VARIABLES#
###########

var inGame
export(int) var maxComboSize = 18

var kitchenInst
var mainMenuInst

########
#EVENTS#
########

func _ready():
	musicPlayer.Init()
	
	UpdateLabel(scoreLabel)
	UpdateLabel(timerLabel)
	UpdateLabel(comboLabel)
	
	ChangeToMainMenu()
	timer.Stop()
	
func _process(_delta):
	if inGame:
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
		
	if Input.is_action_just_released("ui_cancel"):
		if kitchenInst:
			ChangeToMainMenu()
		elif mainMenuInst:
			End()
			get_tree().quit()
	
func _input(event):
	if event.is_action_pressed("FULL_SCREEN"):
		OS.window_fullscreen = !OS.window_fullscreen
		

func Start():
	scoreTracker.InitiateGame()
	if kitchenInst:
		kitchenInst.InitiateGame()
	timer.InitiateGame()
	inGame = true

func End():
	scoreTracker.EndGame()
	if kitchenInst:
		kitchenInst.EndGame()
	timer.Stop()
	inGame = false

func UpdateLabel(label):
	label.get_font("normal_font").font_data.antialiased = false
	label.get_font("normal_font").use_filter = true
	label.get_font("normal_font").use_filter = false

func _on_Timer_end_timer():
	ChangeToMainMenu()
	
func _on_MainMenu_play():
	ChangeToKitchen()

###############
#SCENE CHANGER#
###############

func ChangeToKitchen():
	scoreLabel.visible = true
	comboLabel.visible = true
	timerLabel.visible = true
	
	if mainMenuInst:
		mainMenuInst.queue_free()
		mainMenuInst = null
	kitchenInst = kitchen.instance()
	add_child(kitchenInst)
	kitchenInst.Init()
	
	kitchenInst.connect("moved", scoreTracker, "_on_Kitchen_moved")
	
	musicPlayer.ChangeMusic(musicPlayer.tracks.g0)
	Start()
	
func ChangeToMainMenu():
	End()
	scoreLabel.visible = false
	comboLabel.visible = false
	timerLabel.visible = false
	
	if kitchenInst:
		kitchenInst.queue_free()
		kitchenInst = null
	mainMenuInst = mainMenu.instance()
	add_child(mainMenuInst)
	
	mainMenuInst.Init()
	
	mainMenuInst.connect("play", self, "_on_MainMenu_play")
	
	mainMenuInst.highScoreLabel.set_text(str("\t\tHIGHSCORE\n\t\t\t\t\t\t",scoreTracker.MaxScore))
	musicPlayer.ChangeMusic(musicPlayer.tracks.menu)



func _on_ScoreTracker_score():
	if scoreTracker.combo == 1:
		musicPlayer.ChangeMusic(musicPlayer.tracks.g0)
	elif scoreTracker.combo > 1 and scoreTracker.combo <=3:
		musicPlayer.ChangeMusic(musicPlayer.tracks.g1)
	elif scoreTracker.combo > 3:
		musicPlayer.ChangeMusic(musicPlayer.tracks.g2)
