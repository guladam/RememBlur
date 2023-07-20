extends PanelContainer

signal guess_entered(guess: String)

@export var game_state: GameState
@onready var guess: LineEdit = %Guess


var _puzzle: Puzzle
var _animating := false
var puzzle_length: int
var typing_enabled := false


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		close()


func setup(puzzle: Puzzle) -> void:
	_puzzle = puzzle
	puzzle_length = _puzzle.solution.length()
	setup_guesser()


func setup_guesser() -> void:
	guess.max_length = puzzle_length
	
	var words := _puzzle.solution.split(" ")
	var placeholder: PackedStringArray = []
	for word in words:
		placeholder.append("_".repeat(word.length()))
	
	guess.placeholder_text = " ".join(placeholder)


func show_guesser() -> void:
	if _animating:
		return
		
	# Toggled the key press, so we close it
	if visible and game_state.state == GameState.State.IN_UI:
		close()
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
	
	guess.grab_focus()
	guess.clear()
	typing_enabled = true


func submit_guess() -> void:
	if guess.text.length() != puzzle_length and guess.text.length() != _puzzle.solution_clean.length():
		return
	
	close()
	guess_entered.emit(guess.text)


func close() -> void:
	game_state.state = GameState.State.PLAYING
	typing_enabled = false
	_animating = true
	var _t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	_t.tween_property(self, "scale", Vector2(0.5, 0.5), 0.2)
	_t.parallel().tween_property(self, "modulate", Color.TRANSPARENT, 0.2)
	_t.tween_callback(hide)
	_t.tween_callback(set.bind("_animating", false))


func _on_remember_pressed() -> void:
	submit_guess()


func _on_guess_text_submitted(_new_text: String) -> void:
	submit_guess()


func _on_cancel_pressed() -> void:
	close()
