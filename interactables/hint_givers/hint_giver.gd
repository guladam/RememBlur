extends Node2D
class_name HintGiver

signal show_latest_hint_screen(hint: Hint)

@export var game_state: GameState
@export var hints: Array[Hint]
@export var player_stats: PlayerStats
var cooldown: Timer
var cooldown_progress: TextureProgressBar
var _puzzle: Puzzle


func setup(p: Puzzle) -> void:
	_puzzle = p


func get_hint(helpfulness := 0) -> Hint:
	# TODO do we want a signal for that?
	if hints.is_empty():
		print("keine hints")
		return null
	
	hints.shuffle()
	var given_hint := -1
	# TODO replace with actual logic
	if randf() > 0.4:
		given_hint = _puzzle.get_helpful_hint(hints, helpfulness)
	
	return hints.pop_at(given_hint)


func unlock_hint(h: Hint) -> void:
	show_latest_hint_screen.emit(h)
	_puzzle.add_hint_as_seen(h)
	if _puzzle.get_helpfulness_of_hint(h) <= 0:
		Events.time_bonus_picked_up.emit(10)
