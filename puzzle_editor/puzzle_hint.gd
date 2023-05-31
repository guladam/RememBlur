extends HBoxContainer

@onready var hint_name: Label = %Name
@onready var helpfulness: SpinBox = %Helpfulness
@onready var type: Label = %Type

var _hint: Hint


func setup(hint: Hint, stored_helpfulness: int = -1) -> void:
	_hint = hint
	if hint.text:
		self.hint_name.text = tr(hint.text)
	else:
		self.hint_name.text = hint.resource_path.get_file().trim_suffix('.tres')
	self.type.text = "(%s)" % hint.get_type_as_string()
	self.helpfulness.value = stored_helpfulness if stored_helpfulness > -1 else 1


func get_hint() -> Hint:
	return _hint


func get_helpfulness() -> int:
	return int(helpfulness.value)
