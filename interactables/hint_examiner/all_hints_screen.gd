extends PanelContainer

@export var game_state: GameState
@onready var hints: VBoxContainer = %Hints
@onready var hint_display := preload("res://interactables/hint_examiner/hint_display_horizontal.tscn")

var _puzzle: Puzzle
var _animating := false


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		_on_close_pressed()


func setup(p: Puzzle) -> void:
	_puzzle = p
	_puzzle.hint_added_as_seen.connect(_on_hint_seen)


func show_screen() -> void:
	if _animating:
		return
		
	if visible and game_state.state == GameState.State.IN_UI:
		_on_close_pressed()
		return
	
	if game_state.state != GameState.State.PLAYING:
		return
	
	game_state.state = GameState.State.IN_UI
	_animating = true
	pivot_offset = size / 2
	scale = Vector2.ZERO
	show()
	var _t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	_t.tween_property(self, "scale", Vector2.ONE, 0.2)
	_t.parallel().tween_property(self, "modulate", Color.WHITE, 0.2)
	_t.tween_callback(set.bind("_animating", false))
	

func _on_close_pressed() -> void:
	game_state.state = GameState.State.PLAYING
	_animating = true
	var _t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	_t.tween_property(self, "scale", Vector2(0.5, 0.5), 0.2)
	_t.parallel().tween_property(self, "modulate", Color.TRANSPARENT, 0.2)
	_t.tween_callback(hide)
	_t.tween_callback(set.bind("_animating", false))


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
