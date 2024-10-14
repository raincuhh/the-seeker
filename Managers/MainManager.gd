extends Node

@export var worldManager : String

var gameWorld : Node2D
var paused = false
var inMainMenu = true

@onready var debugConsole = $DebugConsole
@onready var pauseMenu = $PauseMenu
@onready var vignette = $Vignette



func _ready():
	print("worldManager ready")
	hide_debug_overlay()
	hide_pause_menu()
	hide_vignette()
	open_main_menu()

func _on_game_initiate():
	gameWorld = load(worldManager).instantiate()
	add_child(gameWorld)
	#add_child(load(worldManager).instantiate())
	vignette.show()
	inMainMenu = !inMainMenu
	
	#pauseMenu.end_game.connect(open_main_menu)

func open_main_menu():
	
	var mainMenu = load("res://Ui/Menu/MainMenu.tscn").instantiate()
	add_child(mainMenu)
	mainMenu.starting.connect(_on_game_initiate)

func _process(delta):
	gameInputs()

func gameInputs():
	if Input.is_action_just_pressed("debug"):
		toggle_debug_overlay()
	if Input.is_action_just_pressed("pause"):
		toggle_pause_menu()
func hide_debug_overlay():
	#var debugPanel = debugManager.get_child(0)
	#debugPanel.hide()
	debugConsole.hide()
func toggle_debug_overlay():
	#var debugPanel = debugManager.get_child(0)
	#debugPanel.visible = not debugPanel.visible
	debugConsole.visible = !debugConsole.visible
func hide_pause_menu():
	pauseMenu.hide()
func toggle_pause_menu():
	if inMainMenu: 
		return null
	elif !inMainMenu:
		pauseMenu.visible = !pauseMenu.visible
		if paused:
			Engine.time_scale = 1
		else:
			Engine.time_scale = 0
		paused = !paused
func hide_vignette():
	vignette.hide()
