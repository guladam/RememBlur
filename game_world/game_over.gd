extends CenterContainer

signal new_run_requested
signal main_menu_requested


func _ready() -> void:
	%Restart.pressed.connect(func(): new_run_requested.emit())
	%MainMenu.pressed.connect(func(): main_menu_requested.emit())
