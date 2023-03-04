extends CanvasLayer

############
#COMPONENTS#
############

onready var move_tutorial = $MoveTutorial
onready var kick_tutorial = $KickTutorial

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	if Global.played:
		self.visible = false
	Global.played = true


#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############


func _on_Player_kicked():
	kick_tutorial.visible = false


func _on_Player_moved():
	move_tutorial.visible = false
