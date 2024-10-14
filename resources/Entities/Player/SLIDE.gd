extends "state.gd"

@export var climb_speed = 52.5
@export var slide_friction = .7

@onready var player_animation = $"../../PlayerAnimation"

func update(delta):
	slide_movement(delta)
	if Player.get_next_to_wall() == null: #slide thing
		return STATES.FALL
	if Player.jump_input_actuation:
		return STATES.JUMP
	if Player.is_on_floor():
		return STATES.IDLE
	if PlayerVariables.playerCanMoveCurrently == false:
		return STATES.IDLE
	return null

func slide_movement(delta):
	Player.canDash = true
	player_animation.play("SLIDE")
	player_movement()
	Player.gravity(delta)
	
	Player.velocity.y *= slide_friction

