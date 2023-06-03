extends CenterContainer


@onready var hints: VBoxContainer = %Hints
@onready var hint_display := preload("res://interactables/hint_examiner/hint_display.tscn")
var _puzzle: Puzzle

func setup(p: Puzzle) -> void:
	_puzzle = p
	_puzzle.hint_added_as_seen.connect(_on_hint_seen)


func show_screen() -> void:
	show()


func _on_close_pressed() -> void:
	hide()


func _on_hint_seen(hint: Hint) -> void:
	var new_hint_display = hint_display.instantiate()
	hints.add_child(new_hint_display)
	hints.move_child(new_hint_display, 0)
	new_hint_display.setup(hint, _puzzle)


func _on_all_pressed() -> void:
	for hint in hints.get_children():
		hint.visible = true


func _on_helpful_pressed() -> void:
	for hint in hints.get_children():
		hint.visible = _puzzle.get_helpfulness_of_hint(hint.hint) > 0


func _on_unhelpful_pressed() -> void:
	for hint in hints.get_children():
		hint.visible = _puzzle.get_helpfulness_of_hint(hint.hint) <= 0
