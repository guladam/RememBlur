extends Node2D


@export var puzzle: Puzzle

@onready var ui: CanvasLayer = $UI


func _ready() -> void:
	puzzle.reset()
	get_tree().call_group("puzzle_receiver", "setup", puzzle)


func _on_hint_examiner_show_latest_hint_screen(hint: Hint) -> void:
	ui.show_latest_hint_screen(hint)


func _on_hint_examiner_show_all_hints_screen() -> void:
	ui.show_all_hints_screen()
