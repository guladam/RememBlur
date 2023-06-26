extends PanelContainer

signal main_menu_requested

@onready var message: Label = %Message


func _ready() -> void:
	%MainMenu.pressed.connect(func(): main_menu_requested.emit())
	# TODO proper name, genre
	message.text = tr("UI_LAST_LEVEL") % ["John Doe", "mystery"]
