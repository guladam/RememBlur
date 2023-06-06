extends Node2D

signal show_guessing_screen
signal guessed_correctly
signal guessed_incorrectly

@export var game_state: GameState
@export var player_stats: PlayerStats
var _puzzle: Puzzle


func setup(p: Puzzle) -> void:
	_puzzle = p


func _on_interactable_interacted(_player: Area2D) -> void:
	show_guessing_screen.emit()
	game_state.state = GameState.State.IN_UI


func _on_guess_entered(guess: String) -> void:
	var result = _puzzle.check_guess(guess)
	
	if result:
		guessed_correctly.emit()
	else:
		player_stats.health -= 1
		guessed_incorrectly.emit()
