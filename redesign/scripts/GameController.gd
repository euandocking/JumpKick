extends Node

var menuOpen
var levelComplete

var levelFilenames
var currentLevel
var numLevels

onready var LevelCanvas = get_node("LevelCanvas")
onready var Level = get_node("LevelCanvas/Level")
onready var MainMenuPopup = get_node("MenuCanvas/MainMenuPopup")
onready var LevelCompletePopup = get_node("MenuCanvas/LevelCompletePopup")
onready var activePopup = get_node("MenuCanvas/MainMenuPopup")

func _ready():
	menuOpen = true
	levelComplete = false
	
	currentLevel = 0
	numLevels = 1
	levelFilenames = ["res://redesign/scenes/Level.tscn"]
	
	activePopup.popup()
	get_tree().paused = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if levelComplete:
			if !menuOpen:
				switchLevel(levelFilenames[wrapi(currentLevel+1, 1, numLevels)-1])
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
	else:
		activePopup.hide()
		get_tree().paused = false

func switchLevel(levelFilename):
	levelComplete = false
	activePopup.hide()
	get_tree().paused = false
	Level.queue_free()
	Level = load(levelFilename).instance()
	Level.connect("levelCompleted", self, "_on_Level_levelCompleted")
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
