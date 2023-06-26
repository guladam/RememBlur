extends Label


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func flicker() -> void:
	animation_player.play("flicker")
