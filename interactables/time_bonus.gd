extends Area2D


@export var time_bonus := 15
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_area_entered(_area: Area2D) -> void:
	Events.time_bonus_picked_up.emit(time_bonus)
	set_deferred("monitoring", false)
	animation_player.play("pickup")
