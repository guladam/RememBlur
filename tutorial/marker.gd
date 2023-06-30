extends Area2D


@export var step := 1
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("marker_loop")


func reveal() -> void:
	show()
	monitoring = true
	

func _on_area_entered(_area: Area2D) -> void:
	set_deferred("monitoring", false)
	animation_player.play("pickup")
	await get_tree().create_timer(0.3).timeout
	Events.tutorial_marker_picked_up.emit(step)
