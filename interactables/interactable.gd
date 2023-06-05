extends Area2D

signal interacted(player: Area2D)

@export var popup: InteractionPopup

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var _player: Area2D
var can_interact := false


func _unhandled_input(event: InputEvent) -> void:
	if not can_interact or collision_shape_2d.disabled:
		return
	
	if event.is_action_pressed("interact"):
		interacted.emit(_player)
		get_viewport().set_input_as_handled()


func _on_area_entered(area: Area2D) -> void:
	show_popup()
	_player = area
	can_interact = true


func _on_area_exited(_area: Area2D) -> void:
	hide_popup()
	_player = null
	can_interact = false


func show_popup() -> void:
	if popup:
		popup.appear()


func hide_popup() -> void:
	if popup:
		popup.disappear()


func turn_off() -> void:
	can_interact = false
	collision_shape_2d.set_deferred("disabled", true)


func turn_on() -> void:
	can_interact = true
	collision_shape_2d.set_deferred("disabled", false)
