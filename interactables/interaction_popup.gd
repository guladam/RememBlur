extends PanelContainer
class_name InteractionPopup


@export var icon_texture: Texture
@export var text: String

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	%Icon.texture = icon_texture
	%Text.text = text
	
	await get_tree().process_frame
	pivot_offset = size / 2
	position.x = 0


func appear() -> void:
	if animation_player.current_animation == "disappear":
		animation_player.queue("appear")
	elif not animation_player.is_playing():
		animation_player.play("appear")


func disappear() -> void:
	if animation_player.current_animation == "appear":
		animation_player.queue("disappear")
	elif not animation_player.is_playing():
		animation_player.play("disappear")
