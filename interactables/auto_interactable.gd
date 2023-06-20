extends Area2D

signal interacted(player: Area2D)

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var can_interact := true


func _on_area_entered(area: Area2D) -> void:
	if not can_interact:
		return

	interacted.emit(area)
	can_interact = false


func _on_area_exited(_area: Area2D) -> void:
	can_interact = true
