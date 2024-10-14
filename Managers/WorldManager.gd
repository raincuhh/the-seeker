extends Node2D

@onready var player = $Player
@export var startScene : String

var currentArea : Node2D
var oldArea : Node2D

var currentCamera : Camera2D

@onready var world = $World
@onready var worldCam = $WorldCamera

#signal end_game

func _ready():
	currentArea = load(startScene).instantiate()
	world.add_child(currentArea)
	currentArea.goto_room.connect(_on_goto_room)
	#currentArea.goto_main.connect(_on_goto_main)
	worldCam.is_current()
	currentCamera = worldCam

func _on_goto_room(scene : PackedScene):
	get_tree().paused = true
	SceneTransitionManager.fade_out()
	#await SceneTransitionManager.fadedOut
	#await get_tree().create_timer(.6).timeout
	var newArea = scene.instantiate()
	world.add_child.call_deferred(newArea)
	newArea.goto_room.connect(_on_goto_room)
	oldArea = currentArea
	currentArea = newArea
	SceneTransitionManager.fade_in()
	#await SceneTransitionManager.fadedIn
	#await get_tree().create_timer(.6).timeout
	get_tree().paused = false
	oldArea.queue_free()
	Global.currentRoom = currentArea

