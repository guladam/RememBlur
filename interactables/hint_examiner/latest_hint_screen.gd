extends CenterContainer


signal closed
signal switch_to_all_hints_screen


@export var show_all_hints_button := true
@export var game_state: GameState
@onready var hint_display = preload("res://interactables/hint_examiner/hint_display.tscn")
@onready var hint := %Hint

var _puzzle: Puzzle


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		_on_close_pressed()


func setup(p: Puzzle) -> void:
	_puzzle = p
	%ShowAll.visible = show_all_hints_button


func show_screen(new_hint: Hint) -> void:
	if game_state.state == GameState.State.IN_UI:
		return

	game_state.state = GameState.State.IN_UI
	clear_previous_hint()
	var new_hint_display = hint_display.instantiate()
	hint.add_child(new_hint_display)
	new_hint_display.setup(new_hint, _puzzle)
	
	await get_tree().process_frame
	pivot_offset = size / 2
	scale = Vector2.ZERO
	show()
	var _t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	_t.tween_property(self, "scale", Vector2.ONE, 0.2)
	_t.parallel().tween_property(self, "modulate", Color.WHITE, 0.2)


func clear_previous_hint() -> void:
	for c in hint.get_children():
		c.queue_free()


func _on_close_pressed() -> void:
	game_state.state = GameState.State.PLAYING
	close()


func _on_show_all_pressed() -> void:
	await close()
	game_state.state = GameState.State.PLAYING
	switch_to_all_hints_screen.emit()


func close() -> void:
	var _t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	_t.tween_property(self, "scale", Vector2(0.5, 0.5), 0.2)
	_t.parallel().tween_property(self, "modulate", Color.TRANSPARENT, 0.2)
	_t.tween_callback(hide)
	
	await _t.finished
	closed.emit()
