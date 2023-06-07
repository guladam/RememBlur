extends MarginContainer

signal upgrade_selected(upgrade: Upgrade)

@export var upgrade: Upgrade

@onready var text: Label = %Text
@onready var icon: TextureRect = %Icon


func _ready() -> void:
	text.text = tr(upgrade.name_key)
	icon.texture = upgrade.icon
	gui_input.connect(_on_gui_input)
	mouse_filter = Control.MOUSE_FILTER_STOP


func _on_gui_input(event: InputEvent) -> void:
	var mouse_event = event as InputEventMouseButton
	var selected: bool = (
		mouse_event 
		and mouse_event.button_index == MOUSE_BUTTON_LEFT
		and mouse_event.pressed
	)

	if selected:
		upgrade_selected.emit(upgrade)
		mouse_filter = Control.MOUSE_FILTER_IGNORE
