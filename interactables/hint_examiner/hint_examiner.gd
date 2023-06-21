extends Node2D

signal show_latest_hint_screen(hint: Hint)
signal show_all_hints_screen


@export var game_state: GameState
var _puzzle: Puzzle


func setup(p: Puzzle) -> void:
	_puzzle = p


func _on_interactable_interacted(player: Area2D) -> void:
	if not player:
		return
	
	game_state.state = GameState.State.IN_UI
	show_all_hints_screen.emit()
