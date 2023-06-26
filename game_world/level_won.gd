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
	# TODO proper naming, levels remaining
	message.text = tr("UI_LEVEL_WON") % ["John Doe", 99]
