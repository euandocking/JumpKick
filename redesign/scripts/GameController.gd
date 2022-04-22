extends Node

var menuOpen
var levelComplete
var gameOver

var levelFilenames
var currentLevel
var numLevels

onready var LevelCanvas = get_node("LevelCanvas")
onready var Level = get_node("LevelCanvas/StreetsLevel")
onready var MainMenuPopup = get_node("MenuCanvas/MainMenuPopup")
onready var LevelCompletePopup = get_node("MenuCanvas/LevelCompletePopup")
onready var GameOverPopup = get_node("MenuCanvas/GameOverPopup")
onready var activePopup = get_node("MenuCanvas/MainMenuPopup")

func _ready():
	menuOpen = true
	levelComplete = false
	gameOver = false
	
	currentLevel = 0
	levelFilenames = ["res://redesign/scenes/levels/StreetsLevel.tscn", "res://redesign/scenes/levels/WarehouseLevel.tscn"]
	numLevels = levelFilenames.size()
	
	activePopup.popup()
	get_tree().paused = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if levelComplete:
			if !menuOpen:
				currentLevel = posmod(currentLevel + 1, numLevels)
				switchLevel(levelFilenames[currentLevel])
	if Input.is_action_just_pressed("exit"):
		if menuOpen:
			resume()
		else:
			menuOpen = true
			switchPopup(MainMenuPopup)
			get_tree().paused = true
	if Input.is_action_just_pressed("restart"):
		restart()

func switchPopup(newPopup):
	activePopup.hide()
	activePopup = newPopup
	activePopup.popup()

func resume():
	menuOpen = false
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
	activePopup.hide()
	get_tree().paused = false
	Level.queue_free()
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
