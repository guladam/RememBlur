extends Sprite2D


@onready var icon: Sprite2D = $Icon
var icons := {
	Hint.Type.TASTE: preload("res://player/box/taste.png"),
	Hint.Type.SMELL: preload("res://player/box/smell.png"),
	Hint.Type.HEARING: preload("res://player/box/ear.png"),
	Hint.Type.TOUCH: preload("res://player/box/hand.png"),
	Hint.Type.SIGHT: preload("res://player/box/eye.png")
}

func set_icon(hint_type: Hint.Type) -> void:
	icon.texture = icons[hint_type]
