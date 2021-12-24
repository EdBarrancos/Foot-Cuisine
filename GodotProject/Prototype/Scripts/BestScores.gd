extends MarginContainer

############
#COMPONENTS#
############

onready var names = [$HSplitContainer/VBoxContainer/Label,$HSplitContainer/VBoxContainer/Label2,$HSplitContainer/VBoxContainer/Label3]
onready var scores = [$HSplitContainer/VBoxContainer2/Label,$HSplitContainer/VBoxContainer2/Label2,$HSplitContainer/VBoxContainer2/Label3]

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	yield(SilentWolf.Scores.get_high_scores(3), "sw_scores_received")
	for score in SilentWolf.Scores.scores.size():
		if SilentWolf.Scores.scores[score].player_name:
			names[score].text = SilentWolf.Scores.scores[score].player_name
			scores[score].text = str(SilentWolf.Scores.scores[score].score)
		else:
			names[score].text = ""
			scores[score].text = ""

#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############
