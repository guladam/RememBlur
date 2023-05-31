extends Resource
class_name Puzzle


@export var hints: Array[Sense] : set = set_hints
@export var category: String
@export var helpfulness_values: Array[int]


func set_hints(new_hints: Array) -> void:
	hints = new_hints
	emit_changed()
