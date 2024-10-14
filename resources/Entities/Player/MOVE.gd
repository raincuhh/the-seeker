extends "state.gd"

@onready var player_animation = $"../../PlayerAnimation"

func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.velocity.x == 0:
		return STATES.IDLE
	if Player.velocity.y > 0:
		return STATES.FALL 
	if Player.jump_input_actuation:
		return STATES.JUMP
	if Player.jump_input_double && Player.can_double_jump:
		return STATES.DOUBLE_JUMP
	if Player.dash_input && Player.canDash:
		Player.dash_cooldown_timer = Player.dash_cooldown_duration
		return STATES.DASH
	#if PlayerVariables.playerCanMoveCurrently == false:
	#	return STATES.IDLE
	return null
func enter_state():
	player_animation.play("RUN")
	Player.canDash = true
