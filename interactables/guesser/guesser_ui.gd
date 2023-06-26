extends PanelContainer

signal guess_entered(guess: String)

@export var game_state: GameState
@onready var guess: LineEdit = %Guess


var _puzzle: Puzzle
var puzzle_length: int
var typing_enabled := false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and visible:
		close()


func setup(puzzle: Puzzle) -> void:
	_puzzle = puzzle
	puzzle_length = _puzzle.solution.length()
	setup_guesser()


func setup_guesser() -> void:
	guess.max_length = puzzle_length
	guess.placeholder_text = "_".repeat(puzzle_length)


func show_guesser() -> void:
	if game_state.state == GameState.State.IN_UI:
		return

	game_state.state = GameState.State.IN_UI
	
	pivot_offset = size / 2
	scale = Vector2.ZERO
	show()
	var _t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	_t.tween_property(self, "scale", Vector2.ONE, 0.2)
	_t.parallel().tween_property(self, "modulate", Color.WHITE, 0.2)
	
	guess.grab_focus()
	guess.clear()
	typing_enabled = true


func submit_guess() -> void:
	if guess.text.length() != puzzle_length:
		return
	
	close()
	guess_entered.emit(guess.text)


func close() -> void:
	game_state.state = GameState.State.PLAYING
	typing_enabled = false
	var _t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	_t.tween_property(self, "scale", Vector2.ZERO, 0.2)
	_t.parallel().tween_property(self, "modulate", Color.TRANSPARENT, 0.2)
	_t.tween_callback(hide)


func _on_remember_pressed() -> void:
	submit_guess()


func _on_guess_text_submitted(_new_text: String) -> void:
	submit_guess()
