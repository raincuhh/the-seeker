extends CanvasLayer


signal end_game

func _on_continue_pressed():
	pass # Replace with function body.


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_to_menu_pressed():
	emit_signal("end_game")
