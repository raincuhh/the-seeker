extends "state.gd"

@onready var player_animation = $"../../PlayerAnimation"
@onready var dash_duration_timer = $DashDuration

var dash_direction = Vector2.ZERO
var dash_speed = 225

@export var dash_duration = .2

func update(delta):
	if !Player.dashing:
		return STATES.FALL
	if Player.jump_input_double && Player.can_double_jump:
		return STATES.DOUBLE_JUMP
	#if PlayerVariables.playerCanMoveCurrently == false:
	#	return STATES.IDLE
	return null
func enter_state():
	player_animation.play("DASH")
	Player.canDash = false
	Player.dashing = true
	dash_duration_timer.start(dash_duration)
	if Player.movementInput != Vector2.ZERO:
		dash_direction = Player.movementInput
	else:
		dash_direction = Player.lastDirection
	Player.velocity = dash_direction.normalized() * dash_speed
func exit_state():
	Player.dashing = false

func _on_dash_duration_timeout():
	Player.dashing = false
