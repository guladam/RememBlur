extends VBoxContainer

signal back_to_main_menu


func _ready() -> void:
	%MainMenu.pressed.connect(func(): back_to_main_menu.emit())
