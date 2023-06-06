extends Node2D

signal show_latest_hint_screen(hint: Hint)
signal show_all_hints_screen


@export var game_state: GameState
var _puzzle: Puzzle


func setup(p: Puzzle) -> void:
	_puzzle = p


func _on_interactable_interacted(player: Area2D) -> void:
	if not player or not player.has_method("has_box") or not player.has_method("get_box") or not player.has_method("use_box"):
		return
	
	game_state.state = GameState.State.IN_UI
	
	if player.has_box():
		var box: Box = player.get_box()
		_puzzle.add_hint_as_seen(box.hint)
		player.use_box()
		show_latest_hint_screen.emit(box.hint)
	else:
		show_all_hints_screen.emit()
