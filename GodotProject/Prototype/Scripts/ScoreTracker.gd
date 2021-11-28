extends Node2D

############
#COMPONENTS#
############

onready var scoreSoundDefault = $ScoreDefault

###########
#VARIABLES#
###########

onready var score = 0
onready var combo = 1

var MaxScore

var rng = RandomNumberGenerator.new()

signal score

########
#EVENTS#
########

func _ready():
	load_game()
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
	
	get_parent().kitchenInst.player.MultiplyVelocity(1 + (combo*2)/10.0)
	
func EndGame():
	if score > MaxScore:
		MaxScore = score
	save_game()
	
#######
#COMBO#
#######

func GetCombo():
	return combo
	
func _on_Kitchen_moved():
	ResetCombo()
	
func ResetCombo():
	combo = 1
	emit_signal("score")
	
func IncreaseCombo():
	combo += 1
	emit_signal("score")


###############
#LOAD AND SAVE#
###############

func save_dict():
	var save_dict = {
		"MaxScore" : MaxScore,
	}
	return save_dict

func save_game():
	var save_game = File.new()
	save_game.open("user://FootKitchen.save", File.WRITE)
	save_game.store_line(to_json(save_dict()))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://FootKitchen.save"):
		return
	save_game.open("user://FootKitchen.save", File.READ)
	
	var variable_data = parse_json(save_game.get_line())
	for i in variable_data:
		set(i, variable_data[i])
	
	save_game.close()



