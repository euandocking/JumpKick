extends Node

#variables
#game condition variables
var mainMenuOpen
var levelComplete
var gameOver
var currentTime
var bestTime

var invincibility

var numEnemies
var enemiesBeat
var allEnemiesBeat
var playerInExit

var currentLevelIndex
var Level
var levelFilenames
var numLevels
var levelSaveFile

#components
onready var LevelCanvas = get_node("LevelCanvas")
onready var MainMenuPopup = get_node("MenuCanvas/MainMenuPopup")
onready var LevelCompletePopup = get_node("MenuCanvas/LevelCompletePopup")
onready var GameOverPopup = get_node("MenuCanvas/GameOverPopup")
onready var LevelSelectPopup = get_node("MenuCanvas/LevelSelectPopup")
onready var activePopup = get_node("MenuCanvas/MainMenuPopup")
onready var CurrentTimeLabel = get_node("MenuCanvas/HUD/CurrentTimeLabel")
onready var BestTimeLabel = get_node("MenuCanvas/HUD/BestTimeLabel")
onready var SettingsMenuPopup = get_node("MenuCanvas/SettingsMenuPopup")
onready var HelpMenuPopup = get_node("MenuCanvas/HelpMenuPopup")
onready var CreditsMenuPopup = get_node("MenuCanvas/CreditsPopup")
onready var InvincibilityLabel = get_node("MenuCanvas/HUD/InvincibilityLabel")
onready var EnemiesRemainingLabel = get_node("MenuCanvas/HUD/EnemiesRemainingLabel")
onready var EscapeLabel = get_node("MenuCanvas/HUD/EscapeLabel")

#on start
func _ready():
	#set initial check values
	mainMenuOpen = true
	levelComplete = false
	gameOver = false
	invincibility = false
	
	#store the level resource paths
	levelFilenames = ["res://scenes/levels/StreetsLevel.tscn", "res://scenes/levels/WarehouseLevel.tscn", "res://scenes/levels/ApartmentLevel.tscn", "res://scenes/levels/ClubLevel.tscn"]
	numLevels = levelFilenames.size()
	
	#store the save file path
	levelSaveFile = "user://levelSave.save"
	
	#load the last played level
	loadStartLevel()
	
	#show the menu
	activePopup.popup()
	#pause the game
	get_tree().paused = true

#update method
func _process(delta):
	#if game not paused
	if !get_tree().paused:
		#update the level timer
		#uses delta - time elapsed since last frame
		currentTime += delta
		CurrentTimeLabel.text = "Time: " + String(stepify(currentTime, 0.01))
	
	#if the continue key is pressed
	if Input.is_action_just_pressed("ui_accept"):
		#if the level is complete
		if levelComplete:
			#if the menu is closed
			if !mainMenuOpen:
				#switch to the next level in order
				switchLevel(levelFilenames[posmod(currentLevelIndex + 1, numLevels)])
	
	#if the exit key is pressed
	if Input.is_action_just_pressed("exit"):
		#if the menu is open
		if mainMenuOpen:
			#resume the game
			resume()
		#otherwise
		else:
			#update the menu hint text
			EscapeLabel.text = "Press Esc to play"
			#set main menu to open
			mainMenuOpen = true
			#switch to the main menu
			switchPopup(MainMenuPopup)
			#pause the game
			get_tree().paused = true
	
	#if the restart key is pressed
	if Input.is_action_just_pressed("restart"):
		#restart the game
		restart()

#saves the current level to file
func saveStartLevel():
	#opens the file
	var saveFile = File.new()
	saveFile.open(levelSaveFile, File.WRITE)
	#write the level index
	saveFile.store_8(currentLevelIndex)
	#close the file
	saveFile.close()

#loads the last played level from file
func loadStartLevel():
	#opens the file if it exists
	var saveFile = File.new()
	if saveFile.file_exists(levelSaveFile):
		saveFile.open(levelSaveFile, File.READ)
		#read the level index from the file
		currentLevelIndex = saveFile.get_8()
		#close the file
		saveFile.close()
	#otherwise set the index to the first level
	else:
		currentLevelIndex = 0
	#load the given level
	loadLevel(levelFilenames[currentLevelIndex])

#switches active UI popup
func switchPopup(newPopup):
	#hide the current popup
	activePopup.hide()
	#store the given popup
	activePopup = newPopup
	#show the new popup
	activePopup.popup()

#resumes the game from paused
func resume():
	#update the pause text
	EscapeLabel.text = "Press Esc to pause"
	#sets the main menu to closed
	mainMenuOpen = false
	#if level is complete, show the level complete popup
	if levelComplete:
		switchPopup(LevelCompletePopup)
	#if level failed
	elif gameOver:
		#show the game over popup
		switchPopup(GameOverPopup)
	#if game in progress
	else:
		#hide the menu
		activePopup.hide()
		#unpause the game
		get_tree().paused = false

#switches to the given level
func switchLevel(levelFilename):
	#sets main menu to closed
	mainMenuOpen = false
	
	#update to the correct level index
	currentLevelIndex = levelFilenames.find(levelFilename)
	
	#upadtes the pause text
	EscapeLabel.text = "Press Esc to pause"
	#hide the menu
	activePopup.hide()
	#unpause the game
	get_tree().paused = false
	#remove the current level
	Level.queue_free()
	#load the new level
	loadLevel(levelFilename)
	#save the new level as the start level in file
	saveStartLevel()

#loads the given level
func loadLevel(levelFilename):
	#loads the current best time for the level
	#open the file if it exists
	var levelBestTimeFile = File.new()
	var bestTimeFileName = "user://" + String(currentLevelIndex) + "bestTime.save"
	if levelBestTimeFile.file_exists(bestTimeFileName):
		levelBestTimeFile.open(bestTimeFileName, File.READ)
		#set the best time to the time from the file
		bestTime = levelBestTimeFile.get_float()
	#if file doesn't exist
	else:
		#set the best time to error value
		bestTime = -1
	
	#if best time is error
	if bestTime == -1:
		#display appropriate text
		BestTimeLabel.text = "Best Time: -"
	else:
		#display best time from file (rounded)
		BestTimeLabel.text = "Best Time: " + String(stepify(bestTime, 0.01))
	
	#load and instance the new level
	Level = load(levelFilename).instance()
	#connect the level signals to the controller functions
	Level.connect("gameOver", self, "_on_Level_gameOver")
	Level.connect("enemyDefeated", self, "_on_Level_enemyDefeated")
	Level.connect("playerInExit", self, "_on_Level_playerInExit")
	Level.connect("playerLeftExit", self, "_on_Level_playerLeftExit")
	#add the chid to the canvas
	LevelCanvas.add_child(Level)
	
	#reset level variables and displays
	levelComplete = false
	gameOver = false
	currentTime = 0
	playerInExit = false
	enemiesBeat = 0
	allEnemiesBeat = false
	numEnemies = Level.get_node("Enemies").get_children().size()
	EnemiesRemainingLabel.text = "Bad Guys Beat: 0/" + String(numEnemies)

#restarts the current level
func restart():
	#switch to level based on current level name
	switchLevel(Level.get_filename())

#level completed function
func levelCompleted():
	#if current time is better than best time, or no best time exists
	if bestTime < 0 or currentTime < bestTime:
		#set best time to current time
		bestTime = currentTime
		#update best time in file
		var levelBestTimeFile = File.new()
		var bestTimeFileName = "user://" + String(currentLevelIndex) + "bestTime.save"
		levelBestTimeFile.open(bestTimeFileName, File.WRITE)
		levelBestTimeFile.store_float(bestTime)
	#mark that current level is completed
	levelComplete = true
	#pause the game
	get_tree().paused = true
	#show the level complete message
	activePopup = LevelCompletePopup
	activePopup.popup()

#Main Menu signals
#resume game
func _on_MainMenuBox_resumePressed():
	resume()
#restart level
func _on_MainMenuBox_restartPressed():
	restart()
#quit game
func _on_MainMenuBox_quitPressed():
	get_tree().quit()
#change to level select menu
func _on_MainMenuBox_levelSelectPressed():
	switchPopup(LevelSelectPopup)
	mainMenuOpen = false
#change to settings menu
func _on_MainMenuBox_settingsPressed():
	switchPopup(SettingsMenuPopup)
	mainMenuOpen = false
#change to help menu
func _on_MainMenuBox_helpPressed():
	switchPopup(HelpMenuPopup)
	mainMenuOpen = false
#change to credits menu
func _on_MainMenuBox_creditsPressed():
	switchPopup(CreditsMenuPopup)
	mainMenuOpen = false

#on game over
func _on_Level_gameOver():
	#mark level as failed
	gameOver = true
	#pause the game
	get_tree().paused = true
	#show game over message
	activePopup = GameOverPopup
	activePopup.popup()

#on player entering the exit
func _on_Level_playerInExit():
	#mark that player in in exit area
	playerInExit = true
	#if all enemies defeated
	if allEnemiesBeat:
		#level complete
		levelCompleted()
#on player leaving the exit
func _on_Level_playerLeftExit():
	#markt that player is no longer in exit are
	playerInExit = false

#on enemy defeated
func _on_Level_enemyDefeated():
	#add 1 to the defeated enemy count
	enemiesBeat += 1
	#update the enemies defeated label
	EnemiesRemainingLabel.text = "Bad Guys Beat: " + String(enemiesBeat) + "/" + String(numEnemies)
	#if all enemies beat
	if enemiesBeat == numEnemies:
		#mark
		allEnemiesBeat = true
		#if player in exit area
		if playerInExit:
			#level complete
			levelCompleted()

#on level select
func _on_LevelSelectMenuBox_levelSelected(levelPath):
	#switch to level
	switchLevel(levelPath)

#on invincibility toggle
func _on_SettingsMenuBox_invincibilityToggled():
	#toggle invincibility
	invincibility = !invincibility
	#display invincible on label
	InvincibilityLabel.visible = invincibility
	#pass down updated invincibility value to the player
	Level.get_node("Player").invincible = invincibility
