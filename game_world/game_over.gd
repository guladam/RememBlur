extends PanelContainer

signal new_run_requested
signal main_menu_requested

@onready var message: Label = %Message


func _ready() -> void:
	%Restart.pressed.connect(func(): new_run_requested.emit())
	%MainMenu.pressed.connect(func(): main_menu_requested.emit())
	
	# TODO proper run name
	message.text = tr("UI_GAME_OVER") % "John Doe"
