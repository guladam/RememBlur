extends CenterContainer

signal guess_entered(guess: String)

@export var game_state: GameState
@onready var guess: LineEdit = %Guess
@onready var letters: HBoxContainer = %Letters
@onready var letter := preload("res://interactables/guesser/letter.tscn")

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
	
	for i in range(puzzle_length):
		var new_letter: Label = letter.instantiate()
		letters.add_child(new_letter)
		new_letter.text = "_"


func show_guesser() -> void:
	var current_letter: Label
	guess.placeholder_text = "_".repeat(puzzle_length)
	
	for i in range(puzzle_length):
		current_letter = letters.get_child(i)
		current_letter.text = "_"
		if _puzzle.seen_letters.has(_puzzle.solution[i]):
			current_letter.text = _puzzle.solution[i]
	
	show()
	guess.grab_focus()
	guess.clear()
	typing_enabled = true


func submit_guess() -> void:
	if guess.text.length() != puzzle_length:
		return
	
	guess_entered.emit(guess.text)
	close()


func close() -> void:
	game_state.state = GameState.State.PLAYING
	hide()
	typing_enabled = false


func _on_remember_pressed() -> void:
	submit_guess()


func _on_guess_text_submitted(_new_text: String) -> void:
	submit_guess()
