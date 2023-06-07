extends CenterContainer

signal next_level_requested
signal main_menu_requested


func _ready() -> void:
	%NextLevel.pressed.connect(
		func():
			next_level_requested.emit()
			hide()
	)
	
	%MainMenu.pressed.connect(func(): main_menu_requested.emit())
