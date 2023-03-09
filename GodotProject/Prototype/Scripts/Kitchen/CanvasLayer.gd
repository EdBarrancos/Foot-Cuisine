extends CanvasLayer

############
#COMPONENTS#
############

onready var move_tutorial = $MoveTutorial
onready var kick_tutorial = $KickTutorial

export(String) var controller_movement_tutorial
export(String) var keyboard_movement_tutorial
export(String) var controller_shooting_tutorial
export(String) var keyboard_shooting_tutorial

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
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	if Input.get_connected_joypads().size() >= 1:
		SetController()
	else:
		SetKeyboard()


func SetController():
	move_tutorial.clear()
	move_tutorial.append_bbcode("[center]" + controller_movement_tutorial + "[/center]")
	
	kick_tutorial.clear()
	kick_tutorial.append_bbcode("[center]" + controller_shooting_tutorial + "[/center]")

func SetKeyboard():
	move_tutorial.clear()
	move_tutorial.append_bbcode("[center]" + keyboard_movement_tutorial + "[/center]")
	
	kick_tutorial.clear()
	kick_tutorial.append_bbcode("[center]" + keyboard_shooting_tutorial + "[/center]")

func _on_joy_connection_changed(device_id, connected):
	if connected:
		SetController()
	else:
		SetKeyboard()


##############
#MISCELANIOUS#
##############


func _on_Player_kicked():
	kick_tutorial.visible = false


func _on_Player_moved():
	move_tutorial.visible = false
