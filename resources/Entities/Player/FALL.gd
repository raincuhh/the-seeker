extends "state.gd"

@onready var player_animation = $"../../PlayerAnimation"
@onready var CoyoteTimer = $CoyoteTime
@export var coyote_duration = .25

var can_jump = true
func update(delta):
	Player.gravity(delta)
	player_movement()
	
	# Faster Falling
	#if Player.velocity.y > Player.MAX_FALL_SPEED:
	#	Player.velocity.y = Player.MAX_FALL_SPEED
	
	# Max Falling Speed
	if Player.velocity.y < -Player.MAX_FALL_SPEED:
		Player.velocity.y = -Player.MAX_FALL_SPEED
	
	if Player.is_on_floor():
		return STATES.IDLE
	if Player.jump_input_actuation && can_jump:
		return STATES.JUMP
	if Player.jump_input_double && Player.can_double_jump:
		return STATES.DOUBLE_JUMP
	if Player.dash_input && Player.canDash:
		Player.dash_cooldown_timer = Player.dash_cooldown_duration
		return STATES.DASH
	if Player.get_next_to_wall() != null && PlayerVariables.hasChimeraTalons: #slide thing
		return STATES.SLIDE
	#if PlayerVariables.playerCanMoveCurrently == false:
	#	return STATES.IDLE
	return null

func enter_state():
	player_animation.play("FALL")
	if Player.prev_state == STATES.IDLE or Player.prev_state == STATES.MOVE or Player.prev_state == STATES.SLIDE:
		can_jump = true
		Player.can_double_jump = true
		CoyoteTimer.start(coyote_duration)
	else:
		can_jump = false
	CoyoteTimer.start(coyote_duration)

func _on_coyote_time_timeout():
	can_jump = false
