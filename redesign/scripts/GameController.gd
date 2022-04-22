extends Node

var mainMenuOpen
var levelComplete
var gameOver

var levelFilenames
var currentLevelIndex
var numLevels
var Level
var levelSaveFile

onready var LevelCanvas = get_node("LevelCanvas")
onready var MainMenuPopup = get_node("MenuCanvas/MainMenuPopup")
onready var LevelCompletePopup = get_node("MenuCanvas/LevelCompletePopup")
onready var GameOverPopup = get_node("MenuCanvas/GameOverPopup")
onready var LevelSelectPopup = get_node("MenuCanvas/LevelSelectPopup")
onready var activePopup = get_node("MenuCanvas/MainMenuPopup")

func _ready():
	mainMenuOpen = true
	levelComplete = false
	gameOver = false
	
	levelFilenames = ["res://redesign/scenes/levels/StreetsLevel.tscn", "res://redesign/scenes/levels/WarehouseLevel.tscn"]
	numLevels = levelFilenames.size()
	
	levelSaveFile = "user://levelSave.save"
	
	loadStartLevel()
	loadLevel(levelFilenames[currentLevelIndex])
	
	activePopup.popup()
	get_tree().paused = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if levelComplete:
			if !mainMenuOpen:
				switchLevel(levelFilenames[posmod(currentLevelIndex + 1, numLevels)])
	
	if Input.is_action_just_pressed("exit"):
		if mainMenuOpen:
			resume()
		else:
			mainMenuOpen = true
			switchPopup(MainMenuPopup)
			get_tree().paused = true
	if Input.is_action_just_pressed("restart"):
		restart()

func saveStartLevel():
	var saveFile = File.new()
	saveFile.open(levelSaveFile, File.WRITE)
	saveFile.store_8(currentLevelIndex)
	saveFile.close()

func loadStartLevel():
	var saveFile = File.new()
	if saveFile.file_exists(levelSaveFile):
		saveFile.open(levelSaveFile, File.READ)
		currentLevelIndex = saveFile.get_8()
		saveFile.close()
	else:
		currentLevelIndex = 0

func switchPopup(newPopup):
	activePopup.hide()
	activePopup = newPopup
	activePopup.popup()

func resume():
	mainMenuOpen = false
	if levelComplete:
		switchPopup(LevelCompletePopup)
	elif gameOver:
		switchPopup(GameOverPopup)
	else:
		activePopup.hide()
		get_tree().paused = false

func switchLevel(levelFilename):
	levelComplete = false
	gameOver = false
	
	currentLevelIndex = levelFilenames.find(levelFilename)
	
	activePopup.hide()
	get_tree().paused = false
	Level.queue_free()
	loadLevel(levelFilename)
	saveStartLevel()

func loadLevel(levelFilename):
	Level = load(levelFilename).instance()
	Level.connect("levelCompleted", self, "_on_Level_levelCompleted")
	Level.connect("gameOver", self, "_on_Level_gameOver")
	LevelCanvas.add_child(Level)

func restart():
	switchLevel(Level.get_filename())

func _on_MainMenuBox_resumePressed():
	resume()
func _on_MainMenuBox_restartPressed():
	restart()
func _on_MainMenuBox_quitPressed():
	get_tree().quit()
func _on_MainMenuBox_levelSelectPressed():
	switchPopup(LevelSelectPopup)
	mainMenuOpen = false
func _on_MainMenuBox_settingsPressed():
	pass # Replace with function body.
func _on_MainMenuBox_helpPressed():
	pass # Replace with function body.

func _on_Level_levelCompleted():
	levelComplete = true
	get_tree().paused = true
	activePopup = LevelCompletePopup
	activePopup.popup()

func _on_Level_gameOver():
	gameOver = true
	get_tree().paused = true
	activePopup = GameOverPopup
	activePopup.popup()

func _on_LevelSelectMenuBox_levelSelected(levelPath):
	switchLevel(levelPath)
