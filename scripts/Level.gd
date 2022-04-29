extends Node

#variable for storing the enemies
var enemies

#component references
onready var LevelCamera = get_node("LevelCamera")
onready var Player = get_node("Player")
onready var Enemies = get_node("Enemies")

#signals
signal playerInExit
signal playerLeftExit
signal gameOver
#signal for enemy being defeated
signal enemyDefeated

#start function
func _ready():
	#create the enemy references
	enemies = Enemies.get_children()
	#assign the player to each enemy
	for enemy in enemies:
		enemy.connect("defeated", self, "_on_Enemy_defeated")
		enemy.Player = Player

#update
func _process(_delta):
	#smooth transition the camera to inbetween where the player is and 
	#where the player will be next frame based on their current velocity
	LevelCamera.set_position(LevelCamera.get_position().linear_interpolate(Player.get_position()+Player.velocity*0.1, 0.1))

#keep track of if player enters/leaves the exit area
func _on_Exit_playerEnteredExit():
	emit_signal("playerInExit")
func _on_Exit_playerLeftExit():
	emit_signal("playerLeftExit")

#pass up game over signal
func _on_Player_died():
	emit_signal("gameOver")

#enemy defeated signal
func _on_Enemy_defeated():
	#emit the signal further up
	emit_signal("enemyDefeated")
