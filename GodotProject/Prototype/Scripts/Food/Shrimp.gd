extends Food

############
#COMPONENTS#
############

onready var sprite = $SpriteManager

onready var area = $Area2D

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.
	
func Init(manager_):
	.Init(manager_)
	
	area.Init(self)

	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		emit_signal("playerInRange", self)


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		emit_signal("playerOutRange", self)
		
func SetTarget(value):
	if value:
		sprite.ActivateOutline()
	else:
		sprite.DeactivateOutline()
