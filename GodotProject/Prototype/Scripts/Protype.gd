extends Node2D

############
#COMPONENTS#
############

var kitchen = preload("res://Prototype/Scenes/Kitchen/Kitchen.tscn")
var mainMenu = preload("res://Prototype/Scenes/MainMenu.tscn")
var mainMenu_W_Name = preload("res://Prototype/Scenes/MainMenu_W_Name.tscn")

onready var scoreLabel = $CanvasLayer/Score/Score
onready var scoreTracker = $ScoreTracker
onready var comboLabel = $CanvasLayer/Combo/Combo

onready var timerLabel = $CanvasLayer/Timer
onready var timer = $Timer

onready var musicPlayer = $MusicManger
onready var animPlayer = $AnimationPlayer
onready var animPlayerScore = $AnimPlayerScore

onready var flashShader = $CanvasLayer/Flash

###########
#VARIABLES#
###########

var inGame
export(int) var maxComboSize = 18

var kitchenInst
var mainMenuInst
var mainMenu_W_NameInst

########
#EVENTS#
########

func _ready():
	musicPlayer.Init()
	
	UpdateLabel(scoreLabel)
	UpdateLabel(timerLabel)
	UpdateLabel(comboLabel)
	
	ChangeToMainMenu_W_Name()
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
		elif mainMenu_W_NameInst:
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
	if scoreTracker.GetScore() > 0:
		SilentWolf.Scores.persist_score(Global.pName, scoreTracker.GetScore())
	
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
	if mainMenu_W_NameInst:
		mainMenu_W_NameInst.queue_free()
		mainMenu_W_NameInst = null
	kitchenInst = kitchen.instance()
	add_child(kitchenInst)
	kitchenInst.Init()
	
	#kitchenInst.connect("moved", scoreTracker, "_on_Kitchen_moved")
	
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
	if mainMenu_W_NameInst:
		mainMenu_W_NameInst.queue_free()
		mainMenu_W_NameInst = null
	mainMenuInst = mainMenu.instance()
	print(mainMenuInst)
	print("\nAHSBDASD\n")
	add_child(mainMenuInst)
	
	mainMenuInst.Init()
	
	mainMenuInst.connect("play", self, "_on_MainMenu_play")
	
	#mainMenuInst.highScoreLabel.set_text(str("\t\tHIGHSCORE\n\t\t\t\t\t\t",scoreTracker.MaxScore))
	musicPlayer.ChangeMusic(musicPlayer.tracks.menu)

func ChangeToMainMenu_W_Name():
	End()
	scoreLabel.visible = false
	comboLabel.visible = false
	timerLabel.visible = false
	
	if kitchenInst:
		kitchenInst.queue_free()
		kitchenInst = null
	if mainMenuInst:
		mainMenuInst.queue_free()
		mainMenuInst = null
	mainMenu_W_NameInst = mainMenu_W_Name.instance()
	add_child(mainMenu_W_NameInst)
	
	mainMenu_W_NameInst.Init()
	
	mainMenu_W_NameInst.connect("play", self, "_on_MainMenu_play")
	
	#mainMenu_W_NameInst.highScoreLabel.set_text(str("\t\tHIGHSCORE\n\t\t\t\t\t\t",scoreTracker.MaxScore))
	musicPlayer.ChangeMusic(musicPlayer.tracks.menu)


func _on_ScoreTracker_score(previous_combo):
	if scoreTracker.combo == 1:
		musicPlayer.ChangeMusic(musicPlayer.tracks.g0)
		if previous_combo != 1:
			animPlayer.play("ComboReset")
	elif scoreTracker.combo > 1 and scoreTracker.combo <=4:
		musicPlayer.ChangeMusic(musicPlayer.tracks.g1)
		animPlayer.play("Combo")
		animPlayerScore.play("ScenesScore")
	elif scoreTracker.combo > 4:
		musicPlayer.ChangeMusic(musicPlayer.tracks.g2)
		animPlayer.play("Combo")
		animPlayerScore.play("ScenesScore")
