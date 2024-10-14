extends Node2D

@onready var playerSpawn = $PlayerSpawn


signal goto_room(room)

func _on_room_switcher_body_entered(body : Node2D, targetScenePath : String):
	if body is PhysicsBody2D:
		emit_signal("goto_room", load(targetScenePath))



