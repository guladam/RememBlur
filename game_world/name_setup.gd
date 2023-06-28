extends Panel

signal name_given(name: String)

@onready var name_edit: LineEdit = %Name


func _ready() -> void:
	name_edit.grab_focus()


func _on_start_pressed() -> void:
	_submit_name()


func _on_name_text_submitted(_new_text: String) -> void:
	_submit_name()


func _submit_name() -> void:
	if name_edit.text.length() <= 0:
		return

	name_given.emit(name_edit.text.strip_edges())
	hide()
