extends CanvasLayer

@onready var animationPlayer = $AnimationPlayer

signal fadedOut
signal fadedIn

func fade_out():
	animationPlayer.play("fadeOut")
	await animationPlayer.animation_finished
	emit_signal("fadedOut")

func fade_in():
	animationPlayer.play("fadeIn")
	await animationPlayer.animation_finished
	emit_signal("fadedIn")
