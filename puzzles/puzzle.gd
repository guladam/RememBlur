extends Resource
class_name Puzzle


signal hint_added_as_seen(hint: Hint)


@export var solution_key: String
@export var hints: Array[Hint] : set = set_hints
@export var category: Categories.CATEGORIES
@export var helpfulness_values: Array[int]

var solution: String
var seen_hints: Array[Hint]
var seen_letters: Array[String]


func reset() -> void:
	seen_hints.clear()
	seen_letters.clear()
	solution = tr(solution_key)


func check_guess(guess: String) -> bool:
	if solution.length() > 0 and guess.to_lower() == solution.to_lower():
		return true
	
	if guess.length() != solution.length():
		return false
	
	var has_new_letter := false
	
	for i in range(solution.length()):
		if solution[i] == guess[i] and not seen_letters.has(guess[i]):
			seen_letters.append(guess[i])
			has_new_letter = true
	
	if has_new_letter:
		emit_changed()
	
	return false

func set_hints(new_hints: Array) -> void:
	hints = new_hints
	emit_changed()


func add_hint_as_seen(hint: Hint) -> void:
	seen_hints.append(hint)
	hint_added_as_seen.emit(hint)


func get_helpfulness_of_hint(hint: Hint) -> int:
	var idx := hints.find(hint)
	var helpfulness := -1
	
	if idx > -1:
		helpfulness = helpfulness_values[idx]
		
	return helpfulness


func get_helpful_hint(available_hints: Array, helpfulness: int = 0) -> int:
	for i in range(available_hints.size()):
		var idx := hints.find(available_hints[i])
		if idx > -1:
			if helpfulness == 0 or helpfulness_values[idx] == helpfulness:
				return i
				
	return -1
