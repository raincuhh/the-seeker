extends Node

var STATES = null
var Player = null

func enter_state():
	pass

func exit_state():
	pass

func update(delta):
	return null

func player_movement():
	if Player.movementInput.x > 0:
		handle_acceleration()
		handle_air_acceleration()
		Player.lastDirection = Vector2.RIGHT
		Player.Sprite.flip_h = false
	elif Player.movementInput.x < 0:
		handle_acceleration()
		handle_air_acceleration()
		Player.lastDirection = Vector2.LEFT
		Player.Sprite.flip_h = true
	elif Player.movementInput.x == 0:
		handle_friction()
		handle_air_friction()
		if Player.dashing:
			pass
			#handle_dash_friction()

func handle_acceleration():
	if not Player.is_on_floor(): return
	Player.velocity.x = lerp(Player.velocity.x, Player.dir * Player.SPEED, Player.ACCELERATION)

func handle_air_acceleration():
	if not Player.is_on_floor():
		Player.velocity.x = lerp(Player.velocity.x, Player.dir * Player.SPEED, Player.AIR_ACCELERATION)

func handle_dash_friction():
	Player.velocity.x = move_toward(Player.velocity.x, 0, Player.DASH_FRICTION)

func handle_friction():
	if not Player.is_on_floor(): return
	Player.velocity.x = move_toward(Player.velocity.x, 0, Player.FRICTION)

func handle_air_friction():
	if not Player.is_on_floor():
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.AIR_FRICTION)
