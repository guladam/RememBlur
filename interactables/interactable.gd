extends Area2D

signal interacted(player: Area2D)

@export var has_cooldown := true
@export var cooldown_time := 10.0
@export var popup: InteractionPopup

var _player: Area2D
var can_interact := false


func _input(event: InputEvent) -> void:
	if not can_interact:
		return
	
	if event.is_action_pressed("interact"):
		can_interact = false
		interacted.emit(_player)
		print("interaction")
		# TODO cooldown
		
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
