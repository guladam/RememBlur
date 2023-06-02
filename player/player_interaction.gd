extends Area2D


signal box_requested(hint_type: Hint.Type)
signal box_used


func request_box(hint_type: Hint.Type) -> void:
	box_requested.emit(hint_type)


func use_box() -> void:
	box_used.emit()
