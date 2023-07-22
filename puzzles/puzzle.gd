extends Resource
class_name Puzzle


signal hint_added_as_seen(hint: Hint)


@export var solution_key: String
@export var hints: Array[Hint] : set = set_hints
@export var category: Categories.CATEGORIES
@export var helpfulness_values: Array[int]

var solution: String
var solution_clean: String
var seen_hints: Array[Hint]
var seen_needed_letters: Array[String]
var unique_letters: Dictionary


func reset() -> void:
	seen_hints.clear()
	seen_needed_letters.clear()
	solution = tr(solution_key)
	solution_clean = solution.replace(" ", "")
	
	for chr in solution_clean:
		unique_letters[chr] = chr


func check_guess(guess: String) -> bool:
	var guess_clean := guess.replace(" ", "")
	
	if solution_clean.length() > 0 and guess_clean.to_lower() == solution_clean.to_lower():
		return true
	
	if guess_clean.length() != solution_clean.length():
		return false
	
	for i in range(solution_clean.length()):
		if solution_clean[i] == guess_clean[i] and not seen_needed_letters.has(guess_clean[i]):
			seen_needed_letters.append(guess_clean[i])
	
	emit_changed()
	
	return seen_needed_letters.size() == unique_letters.size()


# returns true if it's the last letter, false otherwise.
func unlock_unseen_letters(amount: int) -> bool:
	if seen_needed_letters.size() == unique_letters.values().size() - 1:
		return true
	
	for _i in range(amount):
		var new_letter: String = unique_letters.values().pick_random()

		while seen_needed_letters.has(new_letter):
			new_letter = unique_letters.values().pick_random()
		
		seen_needed_letters.append(new_letter)
	
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
	if helpfulness_values.is_empty():
		return -1
	
	for i in range(available_hints.size()):
		var idx := hints.find(available_hints[i])
		var anything_helpful := helpfulness == 0 and helpfulness_values[idx] > 0
		if idx > -1:
			if anything_helpful or helpfulness_values[idx] == helpfulness:
				return i
				
	return -1


func previous_hint_was_helpful() -> bool:
	# if it's the first hint, you have a 50-50 chance
	if seen_hints.size() < 1:
		return randf() > 0.5
	
	return get_helpfulness_of_hint(seen_hints[-1]) > 0
