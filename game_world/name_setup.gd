extends Panel

signal name_given(name: String)


func _on_start_pressed() -> void:
	_submit_name()


func _on_name_text_submitted(_new_text: String) -> void:
	_submit_name()


func _submit_name() -> void:
	if %Name.text.length() <= 0:
		return

	name_given.emit(%Name.text.strip_edges())
	hide()
