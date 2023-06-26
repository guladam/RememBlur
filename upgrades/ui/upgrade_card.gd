extends PanelContainer

signal upgrade_selected(upgrade: Upgrade)

@export var upgrade: Upgrade

@onready var text: Label = %Text
@onready var icon: TextureRect = %Icon
@onready var style := preload("res://upgrades/ui/upgrade_card_stylebox.tres")
@onready var style_hovered := preload("res://upgrades/ui/upgrade_card_stylebox_hover.tres")

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


func _on_mouse_entered() -> void:
	set("theme_override_styles/panel", style_hovered)


func _on_mouse_exited() -> void:
	set("theme_override_styles/panel", style)
