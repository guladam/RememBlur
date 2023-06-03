extends CenterContainer


var _puzzle: Puzzle


func setup(p: Puzzle) -> void:
	_puzzle = p


func show_screen() -> void:
	show()


func _on_close_pressed() -> void:
	hide()
