extends "state.gd"

@onready var player_animation = $"../../PlayerAnimation"

func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input && Player.canDash:
		return STATES.DASH
	if Player.jump_input_double && Player.can_double_jump:
		return STATES.DOUBLE_JUMP
	#if PlayerVariables.playerCanMoveCurrently == false:
	#	return STATES.IDLE
	return null
func enter_state():
	player_animation.play("JUMP")
	if Player.prev_state == STATES.SLIDE:
		Player.velocity.y = Player.JUMP_VELOCITY
		if Player.lastDirection == Vector2.RIGHT:
			Player.velocity.x = -Player.JUMP_SLIDE_VELOCITY
			Player.lastDirection = Vector2.LEFT
			Player.Sprite.flip_h = true
		elif Player.lastDirection == Vector2.LEFT:
			Player.velocity.x = Player.JUMP_SLIDE_VELOCITY
			Player.lastDirection = Vector2.RIGHT
			Player.Sprite.flip_h = false
	else:
		Player.velocity.y = Player.JUMP_VELOCITY
	Player.can_double_jump = true


