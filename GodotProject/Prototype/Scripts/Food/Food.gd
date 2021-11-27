extends RigidBody2D

class_name Food

###########
#VARIABLES#
###########

signal playerInRange(food)
signal playerOutRange(food)

var manager

########
#EVENTS#
########

func _ready():
	pass # Replace with function body.
	
func Init(manager_):
	manager = manager_
	
	connect("playerInRange",manager.GetPlayer(),"FoodEntered")
	connect("playerOutRange", manager.GetPlayer(),"FoodExited")


func SetVelocity(velocity):
	set_linear_velocity(velocity)
	
func Destroy():
	manager.DestroyFood(self)



