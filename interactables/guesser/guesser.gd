extends Node2D

signal show_guessing_screen
signal guessed_correctly
signal guessed_incorrectly

var _puzzle: Puzzle


func setup(p: Puzzle) -> void:
	_puzzle = p


func _on_interactable_interacted(_player: Area2D) -> void:
	show_guessing_screen.emit()


func _on_guess_entered(guess: String) -> void:
	var result = _puzzle.check_guess(guess)
	
	if result:
		guessed_correctly.emit()
	else:
		guessed_incorrectly.emit()
