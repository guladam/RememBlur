extends Area2D


signal box_requested(hint_type: Hint)
signal box_used


@export var player: Node2D
@export var box: Box


func get_player() -> Node2D:
	return player


func get_box() -> Box:
	return box


func has_box() -> bool:
	return box.in_use


func take_box(hint: Hint) -> void:
	box_requested.emit(hint)


func use_box() -> void:
	box_used.emit()
