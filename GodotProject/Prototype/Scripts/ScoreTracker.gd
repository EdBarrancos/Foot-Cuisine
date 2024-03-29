extends Node2D

############
#COMPONENTS#
############

onready var scoreSoundDefault = $ScoreDefault
onready var comboReset = $ComboReset

###########
#VARIABLES#
###########

onready var score = 0
onready var combo = 1

var MaxScore

var rng = RandomNumberGenerator.new()

signal score(previous_combo)

########
#EVENTS#
########

func _ready():
	if MaxScore == null:
		MaxScore = 0
		
		
func InitiateGame():
	score = 0
	combo = 1


func GetScore():
	return score
	
func FoodScore():
	rng.randomize()
	var pitch = 1 + ((combo-1)*2)/10.0
	scoreSoundDefault.pitch_scale = pitch
	scoreSoundDefault.play()
	score += 1*combo
	
	IncreaseCombo()
	get_parent().kitchenInst.player.MultiplyVelocity(combo)
	
func EndGame():
	if score > MaxScore:
		MaxScore = score
	comboReset.stop()
	
#######
#COMBO#
#######

func GetCombo():
	return combo
	
func _on_Kitchen_moved():
	ResetCombo()
	
func ResetCombo():
	var previous_combo = combo
	combo = 1
	emit_signal("score", previous_combo)
	
func IncreaseCombo():
	var previous_combo = combo
	combo += 1
	emit_signal("score", previous_combo)
	comboReset.start()


func _on_ComboReset_timeout():
	ResetCombo()
