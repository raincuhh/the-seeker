extends "state.gd"

@onready var player_animation = $"../../PlayerAnimation"

var double_jumping = false
func update(delta):
	Player.gravity(delta)
	player_movement()
	if !double_jumping:
		return STATES.JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input && Player.canDash:
		Player.dash_cooldown_timer = Player.dash_cooldown_duration
		return STATES.DASH
	#if PlayerVariables.playerCanMoveCurrently == false:
	#	return STATES.IDLE
	return null
func enter_state():
	player_animation.play("DOUBLE_JUMP")
	Player.can_double_jump = false
	double_jumping = true
	Player.velocity.y = Player.JUMP_VELOCITY
