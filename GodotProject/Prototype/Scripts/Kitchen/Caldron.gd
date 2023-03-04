extends Area2D

############
#COMPONENTS#
############

onready var manager = get_parent()
onready var animation_player = $AnimationPlayer

onready var sprite = $Sprite
onready var tween = $Tween

###########
#VARIABLES#
###########

########
#EVENTS#
########

func _ready():
	tween.interpolate_property(
		sprite.get_material(),
		"shader_param/outline_color",
		Vector3(893, 255, 230), Vector3(100, 255, 230), 5, 
		Tween.TRANS_LINEAR, Tween.EASE_OUT)

#func _process(delta):
#   pass

##############
#MISCELANIOUS#
##############

func _on_Caldron_area_entered(area):
	manager.Score()
	self.animation_player.play("Score")
	area.GetParent().Destroy()

func _on_AnimationPlayer_animation_finished(_anim_name):
	animation_player.play("Idle")
