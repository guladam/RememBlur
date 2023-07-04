extends Area2D


@export var time_bonus := 15
@export var sound: AudioStream

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_marker: Marker2D = $LabelMarker
@onready var label := preload("res://levels/bonus_time_label.tscn")


func _on_area_entered(_area: Area2D) -> void:
	Events.time_bonus_picked_up.emit(time_bonus)
	SfxPlayer.play(sound)
	var new_label := label.instantiate()
	get_parent().add_child(new_label)
	new_label.global_position = label_marker.global_position
	new_label.setup(time_bonus)
	new_label.set("theme_override_font_sizes/font_size", 36)
	set_deferred("monitoring", false)
	animation_player.play("pickup")
