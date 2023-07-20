extends VBoxContainer


@onready var number_label: Label = %Number

var current: int
var _puzzle: Puzzle


func _ready() -> void:
	await get_tree().process_frame
	size = Vector2.ZERO


func setup(p: Puzzle) -> void:
	_puzzle = p
	current = _puzzle.hints.size()
	set_number(current)


func set_number(new_number: int) -> void:
	number_label.text = str(new_number)


func decrease_number(amount: int) -> void:
	current -= amount
	set_number(current)
