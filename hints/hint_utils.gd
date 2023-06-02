extends RefCounted
class_name HintUtils


static func get_helpful_hint(hints: Array, puzzle: Puzzle, helpfulness: int = 0) -> int:
	for i in range(hints.size()):
		var idx := puzzle.hints.find(hints[i])
		if idx > -1:
			if helpfulness == 0 or puzzle.helpfulness_values[idx] == helpfulness:
				return i
				
	return -1
