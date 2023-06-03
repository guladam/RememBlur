extends Node2D
class_name HintGiver


@export var hints: Array[Hint]
var cooldown: Timer
var _puzzle: Puzzle


func setup(p: Puzzle) -> void:
	_puzzle = p


func get_hint(helpfulness := 0) -> Hint:
	# TODO do we want a signal for that?
	if hints.is_empty():
		return null
	
	hints.shuffle()
	var given_hint := -1
	# TODO replace with actual logic
	if randf() > 0.4:
		given_hint = _puzzle.get_helpful_hint(hints, helpfulness)
	
	return hints.pop_at(given_hint)
