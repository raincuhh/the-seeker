extends CanvasLayer

@onready var player_fps_counter = $CanvasLayer/MarginContainer/general/VBoxContainer/FpsCounter
@onready var player_state = $CanvasLayer/MarginContainer/general/VBoxContainer/PlayerState
@onready var player_direction = $CanvasLayer/MarginContainer/general/VBoxContainer/PlayerDirection
@onready var player_velocity = $CanvasLayer/MarginContainer/general/VBoxContainer/PlayerVelocity
@onready var player_position = $CanvasLayer/MarginContainer/general/VBoxContainer/PlayerPosition
@onready var current_room = $CanvasLayer/MarginContainer/general/VBoxContainer/CurrentRoom

@onready var player_ethereal_wings = $CanvasLayer/MarginContainer/player_abilties/VBoxContainer/etherealWings
@onready var player_chimera_talons = $CanvasLayer/MarginContainer/player_abilties/VBoxContainer/chimeraTalons
@onready var player_seeker_cape = $CanvasLayer/MarginContainer/player_abilties/VBoxContainer/seekerCape
@onready var player_chronostasis = $CanvasLayer/MarginContainer/player_abilties/VBoxContainer/chronostasis
@onready var player_shadow_cloak = $CanvasLayer/MarginContainer/player_abilties/VBoxContainer/shadowCloak
@onready var player_red_key = $CanvasLayer/MarginContainer/player_abilties/VBoxContainer/redKey

func _process(delta):
	var fps = Engine.get_frames_per_second()
	player_fps_counter.text = "FPS: " + str(fps)
	player_velocity.text = "VELOCITY: " + "(" + str(PlayerVariables.playerVelocityX) + ", " + str(PlayerVariables.playerVelocityY) + ")"
	player_position.text = "CORDS: " + "(" + str(PlayerVariables.playerPosX) + ", " + str(PlayerVariables.playerPosY) + ")"
	player_state.text = str(PlayerVariables.playerState)
	player_direction.text = str(PlayerVariables.playerDir)
	current_room.text = "ROOM: " + str(Global.currentRoom)
	
	player_ethereal_wings.text = "etherealWings: " + str(PlayerVariables.hasEtherealWings)
	player_chimera_talons.text = "chimeraTalons: " + str(PlayerVariables.hasChimeraTalons)
	player_seeker_cape.text = "seekercape: " + str(PlayerVariables.hasSeekersCape)
	player_chronostasis.text = "chronostasis: " + str(PlayerVariables.hasChronostasis)
	player_shadow_cloak.text = "shadowCloak: " + str(PlayerVariables.hasShadowCloak)
	player_red_key.text = "redKey: " + str(PlayerVariables.hasRedKey)

