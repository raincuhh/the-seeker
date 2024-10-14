extends Node2D
class_name HealthComponent

@export var maxHealth : int = 10
var currentHealth : int

func _ready():
	currentHealth = maxHealth
