extends Node2D

############
#COMPONENTS#
############

onready var menu = $MainMenu
onready var game0 = $Game0
onready var game1 = $Game1
onready var game2 = $Game2

###########
#VARIABLES#
###########

var currentTrack

enum tracks{menu,g0,g1,g2}

########
#EVENTS#
########

func Init():
	menu.play()
	currentTrack = menu
	
func GetCurrentTrackPos():
	return currentTrack.get_playback_position()

func GetTrack(track):
	match(track):
		tracks.menu:
			return menu
		tracks.g0:
			return game0
		tracks.g1:
			return game1
		tracks.g2:
			return game2
	
func ChangeMusic(track):
	var newTrack =  GetTrack(track)
	if newTrack == currentTrack:
		return
	newTrack.play(GetCurrentTrackPos())
	currentTrack.stop()
	currentTrack = newTrack
	
	



#func _process(delta):
#   pass


##############
#MISCELANIOUS#
##############
