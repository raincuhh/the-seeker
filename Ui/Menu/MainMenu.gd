extends CanvasLayer

@onready var Play = $Control/MarginContainer/Play
@onready var titleScreen = $Control/MarginContainer/titleScreen
@onready var Options = $Control/MarginContainer/Options
@onready var Continue = $Control/MarginContainer/Continue
@onready var Video = $Control/MarginContainer/Video
@onready var Audio = $Control/MarginContainer/Audio

@onready var fullscreenButton = $Control/MarginContainer/Video/HBoxContainer/Buttons/FullScreen
@onready var borderlessButton = $Control/MarginContainer/Video/HBoxContainer/Buttons/Borderless
@onready var vSyncButton = $"Control/MarginContainer/Video/HBoxContainer/Buttons/V-Sync"
@onready var vignetteButton = $Control/MarginContainer/Video/HBoxContainer/Buttons/Vignette


var fullScreen = false
var borderless = false
var vSync = false
var vignette = true



signal starting
signal Vignette(variable)


func show_hide(first, second):
	first.show()
	second.hide()

#play
func _on_play_pressed():
	show_hide(titleScreen, Play)

#titlescreen
func _on_continue_pressed():
	show_hide(Continue, titleScreen)
func _on_options_pressed():
	show_hide(Options, titleScreen)
func _on_quit_pressed():
	get_tree().quit()

#continue
func startGame():
	emit_signal("starting")
	queue_free()
func _on_start_button_pressed():
	startGame()
func _on_continue_back_pressed():
	show_hide(titleScreen, Continue)

#options
func _on_video_pressed():
	show_hide(Video, Options)
func _on_audio_pressed():
	show_hide(Audio, Options)
func _on_options_back_pressed():
	show_hide(titleScreen, Options)

#video
func _on_full_screen_pressed():
	if fullScreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreenButton.text = "off"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreenButton.text = "on"
	fullScreen = !fullScreen
func _on_borderless_pressed():
	if borderless:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		borderlessButton.text = "off"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		borderlessButton.text = "on"
	borderless = !borderless
func _on_v_sync_pressed():
	if vSync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		vSyncButton.text = "off"
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		vSyncButton.text = "on"
	vSync = !vSync
func _on_vignette_pressed():
	if vignette:
		emit_signal("Vignette", "on")
		vignetteButton.text = "on"
	else:
		emit_signal("Vignette", "off")
		vignetteButton.text = "off"
	vignette = !vignette
func _on_video_back_pressed():
	show_hide(Options, Video)

#audio
func _on_master_volume_value_changed(value):
	volume(0, value)

func _on_sound_volume_value_changed(value):
	volume(1, value)

func _on_music_volume_value_changed(value):
	volume(2, value)

func volume(busIndex, value):
	AudioServer.set_bus_volume_db(busIndex, value)

func _on_volume_back_pressed():
	show_hide(Options, Audio)
