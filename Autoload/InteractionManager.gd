extends Node

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const basetext = "[F] to"

var activeareas = []
var canInteract = true

func register_area(area: InteractionArea):
	activeareas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = activeareas.find(area)
	if index != -1:
		activeareas.remove_at(index)

func _process(delta):
	label.z_index = 20
	if activeareas.size() > 0 && canInteract:
		activeareas.sort_custom(_sort_by_distance_to_player)
#		label.text = basetext + activeareas[0].action_name
		label.global_position = activeareas[0].global_position
		label.global_position.y -= 32
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

func _sort_by_distance_to_player(area1, area2):
	var area1ToPlayer = player.global_position.distance_squared_to(area1.global_position)
	var area2ToPlayer = player.global_position.distance_squared_to(area2.global_position)
	return area1ToPlayer < area2ToPlayer

func _input(event):
	if event.is_action_pressed("interact") && canInteract:
		if activeareas.size() > 0:
			canInteract = false
			label.hide()
			
			await activeareas[0].interact.call()
			
			canInteract = true
