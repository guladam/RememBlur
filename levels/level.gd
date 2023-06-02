extends Node2D


@export var puzzle: Puzzle


func _ready() -> void:
	get_tree().call_group("interactibles", "setup", puzzle)
