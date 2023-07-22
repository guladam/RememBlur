extends VBoxContainer


@onready var letters: HBoxContainer = %Letters
@onready var letter := preload("res://interactables/guesser/letter.tscn")
@onready var category: Label = %Category

var _puzzle: Puzzle
var puzzle_length: int


func setup(puzzle: Puzzle) -> void:
	_puzzle = puzzle
	_puzzle.changed.connect(update_letters)
	puzzle_length = _puzzle.solution.length()
	setup_puzzle()
	category.text = tr(Categories.CATEGORY_NAMES[puzzle.category])


func setup_puzzle() -> void:
	for i in range(puzzle_length):
		var new_letter: Label = letter.instantiate()
		letters.add_child(new_letter)
		new_letter.theme_type_variation = "LetterLabel"
		if _puzzle.solution[i] == " ":
			new_letter.text = " "
			new_letter.theme_type_variation = ""
			new_letter.reveal()


func update_letters() -> void:
	for i in range(puzzle_length):
		if _puzzle.solution[i] == " ":
			continue
		
		var current_letter: Label = letters.get_child(i)
		
		if _puzzle.seen_needed_letters.has(_puzzle.solution[i]):
			current_letter.text = _puzzle.solution[i].to_upper()
			current_letter.theme_type_variation = ""
			current_letter.reveal()
		else:
			current_letter.flash_red()


func show_solution() -> void:
	for i in range(puzzle_length):
		letters.get_child(i).text = _puzzle.solution[i].to_upper()
		letters.get_child(i).theme_type_variation = ""
