extends Node

var mainMenuOpen
var levelComplete
var gameOver

var currentTime
var bestTime

var levelFilenames
var currentLevelIndex
var numLevels
var Level
var levelSaveFile

var invincibility

var numEnemies
var enemiesBeat
var allEnemiesBeat
var playerInExit

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

func _ready():
	mainMenuOpen = true
	levelComplete = false
	gameOver = false
	
	levelFilenames = ["res://redesign/scenes/levels/StreetsLevel.tscn", "res://redesign/scenes/levels/WarehouseLevel.tscn", "res://redesign/scenes/levels/ApartmentLevel.tscn", "res://redesign/scenes/levels/ClubLevel.tscn"]
	numLevels = levelFilenames.size()
	
	levelSaveFile = "user://levelSave.save"
	
	invincibility = false
	
	loadStartLevel()
	
	activePopup.popup()
	get_tree().paused = true

func _process(delta):
	if !get_tree().paused:
		currentTime += delta
		CurrentTimeLabel.text = "Time: " + String(stepify(currentTime, 0.01))
	
	if Input.is_action_just_pressed("ui_accept"):
		if levelComplete:
			if !mainMenuOpen:
				switchLevel(levelFilenames[posmod(currentLevelIndex + 1, numLevels)])
	
	if Input.is_action_just_pressed("exit"):
		if mainMenuOpen:
			resume()
		else:
			EscapeLabel.text = "Press Esc to play"
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
	loadLevel(levelFilenames[currentLevelIndex])

func switchPopup(newPopup):
	activePopup.hide()
	activePopup = newPopup
	activePopup.popup()

func resume():
	EscapeLabel.text = "Press Esc to pause"
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
	mainMenuOpen = false
	
	currentLevelIndex = levelFilenames.find(levelFilename)
	
	EscapeLabel.text = "Press Esc to pause"
	activePopup.hide()
	get_tree().paused = false
	Level.queue_free()
	loadLevel(levelFilename)
	saveStartLevel()

func loadLevel(levelFilename):
	currentTime = 0
	
	var levelBestTimeFile = File.new()
	var bestTimeFileName = "user://" + String(currentLevelIndex) + "bestTime.save"
	if levelBestTimeFile.file_exists(bestTimeFileName):
		levelBestTimeFile.open(bestTimeFileName, File.READ)
		bestTime = levelBestTimeFile.get_float()
	else:
		bestTime = -1
	
	if bestTime == -1:
		BestTimeLabel.text = "Best Time: -"
	else:
		BestTimeLabel.text = "Best Time: " + String(stepify(bestTime, 0.01))
	
	Level = load(levelFilename).instance()
	Level.connect("gameOver", self, "_on_Level_gameOver")
	Level.connect("enemyDefeated", self, "_on_Level_enemyDefeated")
	Level.connect("playerInExit", self, "_on_Level_playerInExit")
	Level.connect("playerLeftExit", self, "_on_Level_playerLeftExit")
	LevelCanvas.add_child(Level)
	
	playerInExit = false
	enemiesBeat = 0
	allEnemiesBeat = false
	numEnemies = Level.get_node("Enemies").get_children().size()
	EnemiesRemainingLabel.text = "Bad Guys Beat: 0/" + String(numEnemies)

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
	switchPopup(SettingsMenuPopup)
	mainMenuOpen = false
func _on_MainMenuBox_helpPressed():
	switchPopup(HelpMenuPopup)
	mainMenuOpen = false
func _on_MainMenuBox_creditsPressed():
	switchPopup(CreditsMenuPopup)
	mainMenuOpen = false

func levelCompleted():
	if bestTime < 0 or currentTime < bestTime:
		bestTime = currentTime
		var levelBestTimeFile = File.new()
		var bestTimeFileName = "user://" + String(currentLevelIndex) + "bestTime.save"
		levelBestTimeFile.open(bestTimeFileName, File.WRITE)
		levelBestTimeFile.store_float(bestTime)
	levelComplete = true
	get_tree().paused = true
	activePopup = LevelCompletePopup
	activePopup.popup()

func _on_Level_gameOver():
	gameOver = true
	get_tree().paused = true
	activePopup = GameOverPopup
	activePopup.popup()

func _on_Level_playerInExit():
	playerInExit = true
	if allEnemiesBeat:
		levelCompleted()
func _on_Level_playerLeftExit():
	playerInExit = false

func _on_Level_enemyDefeated():
	enemiesBeat += 1
	EnemiesRemainingLabel.text = "Bad Guys Beat: " + String(enemiesBeat) + "/" + String(numEnemies)
	if enemiesBeat == numEnemies:
		allEnemiesBeat = true
		if playerInExit:
			levelCompleted()

func _on_LevelSelectMenuBox_levelSelected(levelPath):
	switchLevel(levelPath)

func _on_SettingsMenuBox_invincibilityToggled():
	invincibility = !invincibility
	InvincibilityLabel.visible = invincibility
	Level.get_node("Player").invincible = invincibility
