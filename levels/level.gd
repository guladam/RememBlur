extends Node2D

@export var puzzle: Puzzle

@onready var ui: CanvasLayer = $UI
@onready var hint_examiner: Node2D = $HintExaminer
@onready var guesser: Node2D = $Guesser


func _ready() -> void:
	puzzle.reset()
	get_tree().call_group("puzzle_receiver", "setup", puzzle)
	
	hint_examiner.show_all_hints_screen.connect(ui.show_all_hints_screen)
	hint_examiner.show_latest_hint_screen.connect(ui.show_latest_hint_screen)
	
	guesser.show_guessing_screen.connect(ui.show_guesser_ui)
	guesser.guessed_correctly.connect(ui.show_solution)
	ui.guess_entered.connect(guesser._on_guess_entered)
