extends Node2D

############
#COMPONENTS#
############

onready var kitchen = $Kitchen
onready var scoreLabel = $CanvasLayer/Label
onready var scoreTracker = $ScoreTracker

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	kitchen.Init()
	
func _process(_delta):
	scoreLabel.set_text(str("SCORE: ", scoreTracker.GetScore()))

####################
#SAVE AND LOAD GAME#
####################
