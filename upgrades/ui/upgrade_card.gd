extends PanelContainer

signal upgrade_selected(upgrade: Upgrade)

@export var upgrade: Upgrade

@onready var text: Label = %Text
@onready var icon: TextureRect = %Icon
@onready var stars: Control = %Stars
@onready var style := preload("res://upgrades/ui/upgrade_card_stylebox.tres")
@onready var style_hovered := preload("res://upgrades/ui/upgrade_card_stylebox_hover.tres")

@onready var star_full := preload("res://interactables/hint_examiner/assets/star.png")
@onready var star_empty := preload("res://interactables/hint_examiner/assets/star_empty.png")


func _ready() -> void:
	text.text = tr(upgrade.name_key)
	icon.texture = upgrade.icon
	gui_input.connect(_on_gui_input)
	mouse_filter = Control.MOUSE_FILTER_STOP
	
	for i in range(3):
		if i+1 <= upgrade.tier:
			stars.get_child(i).texture = star_full
		else:
			stars.get_child(i).texture = star_empty


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
