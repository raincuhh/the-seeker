extends TextureButton
class_name skillNode


@onready var panel = $Panel
@onready var label = $MarginContainer/Label
@onready var line2D = $Line2D

func _ready():
	if get_parent() is skillNode:
		line2D.add_point(global_position + size / 2)
		line2D.add_point(get_parent().global_position + size / 2)


var level : int = 0:
	set(value):
		level = value
		label.text = str(level) + "/3"

func _on_pressed():
	level = min( level + 1 , 3)
	panel.show_behind_parent = true
	
	line2D.default_color = Color(1, 1, 0.2)
	
	var skills = get_children()
	for skill in skills:
		if skill is skillNode and level == 3:
			skill.disabled = false
