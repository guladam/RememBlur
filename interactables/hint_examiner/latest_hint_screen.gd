extends CenterContainer


signal switch_to_all_hints_screen

@onready var hint_display = preload("res://interactables/hint_examiner/hint_display.tscn")
@onready var hint: Control = %Hint

var _puzzle: Puzzle


func setup(p: Puzzle) -> void:
	_puzzle = p


func show_screen(new_hint: Hint) -> void:
	clear_previous_hint()
	var new_hint_display = hint_display.instantiate()
	hint.add_child(new_hint_display)
	new_hint_display.setup(new_hint, _puzzle)
	show()


func clear_previous_hint() -> void:
	for c in hint.get_children():
		c.queue_free()


func _on_close_pressed() -> void:
	hide()


func _on_show_all_pressed() -> void:
	hide()
	switch_to_all_hints_screen.emit()
