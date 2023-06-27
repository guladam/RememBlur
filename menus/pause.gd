extends Panel


signal resume_game
signal go_to_main_menu


func _ready() -> void:
	%Resume.pressed.connect(func(): resume_game.emit())
	%MainMenu.pressed.connect(func(): go_to_main_menu.emit())


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		resume_game.emit()
		get_viewport().set_input_as_handled()
