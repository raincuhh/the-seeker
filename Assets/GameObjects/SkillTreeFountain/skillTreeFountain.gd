extends Node2D


@onready var interactionAreaComponent = $InteractionAreaComponent
@export var skillTree : String

var inWindow = false
var skillTreeInstance = null

func _ready():
	interactionAreaComponent.interact = Callable(self, "_on_interact")

func _on_interact():
	if !inWindow:
		PlayerVariables.playerCanMoveCurrently = false
		skillTreeInstance = load(skillTree).instantiate()
		add_child(skillTreeInstance)
	else:
		PlayerVariables.playerCanMoveCurrently = true
		if skillTreeInstance:
			skillTreeInstance.queue_free()
	inWindow = !inWindow

