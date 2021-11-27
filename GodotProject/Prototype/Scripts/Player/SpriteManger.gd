extends Node2D

############
#COMPONENTS#
############

onready var sprite = $MainSprite

###########
#VARIABLES#
###########

onready var squashing = false
export(float) var MAXSQUASH_X = 1.3
export(float) var MAXSQUASH_Y = 0.5
export(float) var squashIncrease = 0.015
var squashFactorX
var squashFactorY

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.

func Turn(pos):
	sprite.look_at(pos)
	
func StartSquash(squashPercentage):
	squashFactorX = squashPercentage * MAXSQUASH_X
	squashFactorY = squashPercentage * (1-MAXSQUASH_Y)
	squashing = true
	
func StopSquash():
	squashing = false
	sprite.set_scale(Vector2(1,1))
	
func Stretch():
	sprite.set_scale(Vector2(1 + squashFactorX,1-squashFactorY))

func StopStretch():
	sprite.set_scale(Vector2(1,1))
	
func _process(delta):
	if squashing:
		if 1 + squashFactorX > MAXSQUASH_X:
			squashFactorX = MAXSQUASH_X - 1
		if 1 - squashFactorY < MAXSQUASH_Y:
			squashFactorY = MAXSQUASH_Y + 1
		var x = 1 + squashFactorX
		var y = 1 - squashFactorY
		sprite.set_scale(Vector2(y,x))



##############
#MISCELANIOUS#
##############
