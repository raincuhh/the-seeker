extends CharacterBody2D

class_name SEEKER

#input
var playerCanMove

var movementInput = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var jump_input_double = false
var dash_input = false
var attack_input = false
var climb_input = false

#variables
var SPEED = 120.0
var JUMP_VELOCITY = -300.0
var JUMP_SLIDE_VELOCITY = 200
var MAX_FALL_SPEED = 1000.0
var FALL_ACCELERATION = 1500.0
var ACCELERATION = .3
var AIR_ACCELERATION = .25
var FRICTION = 13
var AIR_FRICTION = 11
var DASH_FRICTION = 100
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var GRAVITY_SCALE : float = 1.0
@export var GRAVITY_FALL_SCALE = 1.1

#var MAX_Y_SPEED

var spriteDirection = "RIGHT"
var dir
var lastDirection = Vector2.RIGHT
var wall_offshoot_direction = Vector2.ZERO


#mechanics
var canDash = true
var dashing = false
var dash_cooldown_timer = 0.0
var dash_cooldown_duration = 0.35

var can_double_jump = false

var jump_buffer_timer = 0.0
var jump_buffer_time = 0.2

#states
var current_state = null
var prev_state = null

@onready var STATES = $STATES
@onready var Sprite = $Sprite
@onready var player_animation = $PlayerAnimation
@onready var Raycasts = $SlideRaycasts

#signal player_created

func _ready():
	#emit_signal("player_created")
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE

func _physics_process(delta):
	playerCanMove = PlayerVariables.playerCanMoveCurrently
	if playerCanMove:
		player_input()
		#change_state(current_state.update(delta))
	else:
		return null
	change_state(current_state.update(delta))
	if dash_cooldown_timer > 0.0:
		dash_cooldown_timer -= delta
	move_and_slide()
	
	PlayerVariables.playerPosX = position.x
	PlayerVariables.playerPosY = position.y
	PlayerVariables.playerVelocityX = velocity.x
	PlayerVariables.playerVelocityY = velocity.y
	PlayerVariables.playerDir = spriteDirection
	PlayerVariables.playerState = current_state.get_name()
	
	
	if jump_buffer_timer > 0.0:
		jump_buffer_timer -= delta

func gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * GRAVITY_SCALE * delta
	elif current_state == STATES.FALL:
		velocity.y += GRAVITY * GRAVITY_FALL_SCALE * delta

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

func get_next_to_wall():
	for raycast in Raycasts.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null

func player_input():
	movementInput = Vector2.ZERO
	if Input.is_action_pressed("right"):
		movementInput.x += 1
		dir = 1
		spriteDirection = "RIGHT" 
	if Input.is_action_pressed("left"):
		movementInput.x -= 1
		dir = -1
		spriteDirection = "LEFT"
	if Input.is_action_pressed("up"):
		spriteDirection = "UP"
	if Input.is_action_pressed("down"):
		spriteDirection = "DOWN"
	
	jump_input = Input.is_action_pressed("jump")
	jump_input_actuation = Input.is_action_just_pressed("jump")
	
	if jump_input_actuation && can_double_jump && PlayerVariables.hasEtherealWings:
		jump_input_double = true
	else:
		jump_input_double = false
	
	if Input.is_action_just_pressed("dash") && canDash && dash_cooldown_timer <= 0.0 && PlayerVariables.hasSeekersCape:
		dash_input = true
	else:
		dash_input = false
