extends Node2D
class_name HintGiver

signal show_latest_hint_screen(hint: Hint)
signal helpful_hint_unlocked

@export var game_state: GameState
@export var hints: Array[Resource]
@export var player_stats: PlayerStats
var cooldown: Timer
var cooldown_progress: TextureProgressBar
var _puzzle: Puzzle


func setup(p: Puzzle) -> void:
	_puzzle = p


func get_hint(helpfulness := 0) -> Hint:
	if hints.is_empty():
		return null
	
	hints.shuffle()
	var given_hint := -1
	var helpful_by_chance := randf() <= player_stats.helpful_hint_chance + player_stats.get_multiplier(player_stats.helpful_hint_bonus, player_stats.SIGN.POSITIVE)
	var helpful_because_prev := not _puzzle.previous_hint_was_helpful()
	
	if helpful_by_chance or helpful_because_prev:
		given_hint = _puzzle.get_helpful_hint(hints, helpfulness)
	
	return hints.pop_at(given_hint)


func unlock_hint(h: Hint) -> void:
	show_latest_hint_screen.emit(h)
	_puzzle.add_hint_as_seen(h)
	if _puzzle.get_helpfulness_of_hint(h) <= 0:
		Events.time_bonus_picked_up.emit(15)
	else:
		helpful_hint_unlocked.emit()
