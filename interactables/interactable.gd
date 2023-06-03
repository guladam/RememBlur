extends Area2D

signal interacted(player: Area2D)

@export var has_cooldown := true
@export var cooldown_time := 10.0
@export var popup: InteractionPopup

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var _player: Area2D
var can_interact := false


func _input(event: InputEvent) -> void:
	if not can_interact or collision_shape_2d.disabled:
		return
	
	if event.is_action_pressed("interact"):
		can_interact = false
		interacted.emit(_player)
		
		if popup:
			popup.disappear()


func _on_area_entered(area: Area2D) -> void:
	if popup:
		popup.appear()
	
	_player = area
	can_interact = true


func _on_area_exited(_area: Area2D) -> void:
	if popup:
		popup.disappear()
	
	_player = null
	can_interact = false


func turn_off() -> void:
	if popup.animation_player.is_playing():
		await popup.animation_player.animation_finished
	collision_shape_2d.set_deferred("disabled", true)


func turn_on() -> void:
	collision_shape_2d.set_deferred("disabled", false)
