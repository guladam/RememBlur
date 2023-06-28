extends PanelContainer

signal next_level_requested
signal main_menu_requested

@onready var message: Label = %Message


func _ready() -> void:
	%NextLevel.pressed.connect(
		func():
			next_level_requested.emit()
			hide()
	)
	
	%MainMenu.pressed.connect(func(): main_menu_requested.emit())


func show_screen(run_name: String, levels_remaining: int) -> void:
	message.text = tr("UI_LEVEL_WON") % [run_name, levels_remaining]
	show()
