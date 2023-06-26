extends PanelContainer

signal main_menu_requested


func _ready() -> void:
	%MainMenu.pressed.connect(func(): main_menu_requested.emit())
