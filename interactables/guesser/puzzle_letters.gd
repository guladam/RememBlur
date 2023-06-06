extends Control


@onready var letters: HBoxContainer = %Letters
@onready var letter := preload("res://interactables/guesser/letter.tscn")

var _puzzle: Puzzle
var puzzle_length: int


func setup(puzzle: Puzzle) -> void:
	_puzzle = puzzle
	_puzzle.changed.connect(update_letters)
	puzzle_length = _puzzle.solution.length()
	setup_puzzle()


func setup_puzzle() -> void:
	for i in range(puzzle_length):
		var new_letter: Label = letter.instantiate()
		letters.add_child(new_letter)
		new_letter.text = "_"


func update_letters() -> void:
	for i in range(puzzle_length):
		var current_letter: Label = letters.get_child(i)
		current_letter.text = "_"
		if _puzzle.seen_letters.has(_puzzle.solution[i]):
			current_letter.text = _puzzle.solution[i].to_upper()


func show_solution() -> void:
	for i in range(puzzle_length):
		letters.get_child(i).text = _puzzle.solution[i].to_upper()
