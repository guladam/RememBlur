extends PanelContainer

signal guess_entered(guess: String)

@export var game_state: GameState
@export var helpful_letter_color: Color
@export var unhelpful_letter_color: Color

@onready var guess: LineEdit = %Guess
@onready var guess_underline: Label = %GuessUnderline
@onready var former_guesses: RichTextLabel = %FormerGuesses


var _puzzle: Puzzle
var _animating := false
var puzzle_length: int
var typing_enabled := false
var guesses := []


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		close()


func setup(puzzle: Puzzle) -> void:
	_puzzle = puzzle
	puzzle_length = _puzzle.solution.length()
	guesses.clear()
	setup_guesser()


func setup_guesser() -> void:
	guess.max_length = puzzle_length
	
	var words := _puzzle.solution.split(" ")
	var placeholder: PackedStringArray = []
	for word in words:
		placeholder.append("_".repeat(word.length()))
	
	guess_underline.text = " ".join(placeholder)
	former_guesses.text = ""


func add_latest_former_guess(latest_guess: String) -> void:
	if guesses.is_empty():
		former_guesses.text = ""
		return

	latest_guess = latest_guess.replace(" ", "")
	var letter_bb_codes: PackedStringArray = []
	var color_code: String
	for i in range(_puzzle.solution_clean.length()):
		if _puzzle.solution_clean[i] == latest_guess[i]:
			color_code = helpful_letter_color.to_html()
		else:
			color_code = unhelpful_letter_color.to_html()
		letter_bb_codes.append(
			"[color=#%s]%s[/color]" % [color_code, latest_guess[i]]
		)
	
	var space_in_puzzle := _puzzle.solution.find(" ")
	if space_in_puzzle > -1:
		letter_bb_codes.insert(space_in_puzzle, " ")
	
	var extra_chars := ", " if guesses.size() > 1 else ""	
	former_guesses.text = former_guesses.text + extra_chars + "".join(letter_bb_codes)


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
	guesses.append(guess.text)
	add_latest_former_guess(guess.text)


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


func _on_guess_text_changed(new_text: String) -> void:
	var placeholder: PackedStringArray = []
	placeholder.resize(puzzle_length)
	placeholder.fill("_")
	
	for i in range(_puzzle.solution.length()):
		if _puzzle.solution[i] == " ":
			placeholder[i] = " "
		elif i < new_text.length() and new_text[i] != " ":
			placeholder[i] = " "
	
	guess_underline.text = "".join(placeholder)
