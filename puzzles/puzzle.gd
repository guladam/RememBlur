extends Resource
class_name Puzzle


@export var hints: Array[Hint] : set = set_hints
@export var category: Categories.CATEGORIES
@export var helpfulness_values: Array[int]


func set_hints(new_hints: Array) -> void:
	hints = new_hints
	emit_changed()
