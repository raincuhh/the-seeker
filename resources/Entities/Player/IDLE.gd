extends "state.gd"

@onready var player_animation = $"../../PlayerAnimation"

func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.movementInput.x != 0:
		return STATES.MOVE
	if Player.jump_input == true:
		return STATES.JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input && Player.canDash:
		Player.dash_cooldown_timer = Player.dash_cooldown_duration
		return STATES.DASH
	if Player.jump_input_double && Player.can_double_jump:
		return STATES.DOUBLE_JUMP
	return null
func enter_state():
	player_animation.play("IDLE")
	#Player.velocity.x = 0
	Player.canDash = true
