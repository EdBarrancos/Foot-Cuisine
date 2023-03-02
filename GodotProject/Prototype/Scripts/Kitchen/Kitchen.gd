extends Node2D

############
#COMPONENTS#
############

onready var player = $Player
onready var foodManager = $FoodManager
onready var spawner = $Spawner

###########
#VARIABLES#
###########

onready var tileSize = 18
onready var width = 256
onready var height = 224

export(Vector2) var playerInitialPosition = Vector2(128,112)

########
#EVENTS#
########

func Init():
	player.Init(self)
	foodManager.Init(self)
	spawner.Init(self)
	
func InitiateGame():
	player.SetPos(playerInitialPosition)
	foodManager.DestroyAllFood()
	spawner.ResetValues()
	player.set_angular_velocity(2)
	
	for _i in range(3):
		spawner.Spawn()

func EndGame():
	player.EndGame(playerInitialPosition)
	
#########
#MARGINS#
#########

func GetFirstQuadrant():
	return [Vector2(tileSize,tileSize), Vector2(width/2,height/2)]

func GetSecondQuadrant():
	return [Vector2(width/2, tileSize), Vector2(width-tileSize, height/2)]
	
func GetThirdQuadrant():
	return [Vector2(tileSize, height/2), Vector2(width/2, height-tileSize)]

func GetForthQuadrant():
	return [Vector2(width/2,height/2), Vector2(width-tileSize, height-tileSize)]
	
func IsPlayerInQuadrant(quadrantNumber):
	var pos = player.position
	var edges
	match quadrantNumber:
		1:
			edges = GetFirstQuadrant()
		2:
			edges = GetSecondQuadrant()
		3:
			edges = GetThirdQuadrant()
		4:
			edges = GetForthQuadrant()
		
	return IsPosEqualOrGreater(pos,edges[0]) and not IsPosEqualOrGreater(pos, edges[1]) 
	
func IsPosEqualOrGreater(pos1, pos2):
	return pos1.x >= pos2.x and pos1.y >= pos2.y


##############
#MISCELANIOUS#
##############

func GetCurrentTarget():
	var target = foodManager.GetCurrentFoodItem()
	foodManager.UpdateCurrentFoodItem()
	return target
