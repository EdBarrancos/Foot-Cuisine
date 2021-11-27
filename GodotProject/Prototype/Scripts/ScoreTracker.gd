extends Node2D

############
#COMPONENTS#
############

onready var scoreSoundDefault = $ScoreDefault

###########
#VARIABLES#
###########

onready var score = 0

var MaxScore

########
#EVENTS#
########

func _ready():
	load_game()
	if MaxScore == null:
		MaxScore = 0


func GetScore():
	return score
	
func FoodScore():
	scoreSoundDefault.play()
	score += 1
	
func EndGame():
	if score > MaxScore:
		MaxScore = score
	save_game()


###############
#LOAD AND SAVE#
###############

func save_dict():
	var save_dict = {
		"Max Score" : MaxScore,
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
