extends Control

@onready var puzzle_name: Label = %PuzzleName
@onready var puzzle_category: Label = %PuzzleCategory
@onready var file_dialog: FileDialog = %PuzzleFileDialog
@onready var hint_file_dialog: FileDialog = %HintFileDialog
@onready var hints: VBoxContainer = %Hints
@onready var editor_hint := preload("res://puzzle_editor/puzzle_hint.tscn")

var puzzle: Puzzle


func add_hint(hint: Hint, helpfulness: int = -1) -> void:
	var new_hint = editor_hint.instantiate()
	hints.add_child(new_hint)
	new_hint.setup(hint, helpfulness)


func refresh_grid() -> void:
	if not puzzle:
		return
	
	print(puzzle.helpfulness_values)
	for i in range(puzzle.hints.size()):
		var helpfulness := -1
		if i < puzzle.helpfulness_values.size():
			helpfulness = puzzle.helpfulness_values[i]

		add_hint(puzzle.hints[i], helpfulness)


func _on_file_dialog_file_selected(path: String) -> void:
	puzzle = load(path)
	puzzle.changed.connect(refresh_grid)
	puzzle_category.text = tr(Categories.CATEGORY_NAMES[puzzle.category])
	puzzle_name.text = path.get_file().trim_suffix('.tres')
	refresh_grid()


func _on_load_pressed() -> void:
	file_dialog.popup_centered()


func _on_save_pressed() -> void:
	puzzle.hints.clear()
	puzzle.helpfulness_values.clear()
	
	for hint in hints.get_children():
		puzzle.hints.append(hint.get_hint())
		puzzle.helpfulness_values.append(hint.get_helpfulness())
		
	ResourceSaver.save(puzzle)


func _on_add_hint_pressed() -> void:
	hint_file_dialog.popup_centered()


func _on_hint_file_dialog_file_selected(path: String) -> void:
	var hint: Hint = load(path)
	
	if hint:
		add_hint(hint)
