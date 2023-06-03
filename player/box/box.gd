extends Sprite2D
class_name Box


@onready var icon: Sprite2D = $Icon

var in_use := false
var hint: Hint

const ICONS := {
	Hint.Type.TASTE: preload("res://player/box/taste.png"),
	Hint.Type.SMELL: preload("res://player/box/smell.png"),
	Hint.Type.HEARING: preload("res://player/box/ear.png"),
	Hint.Type.TOUCH: preload("res://player/box/hand.png"),
	Hint.Type.SIGHT: preload("res://player/box/eye.png")
}


func setup(h: Hint) -> void:
	hint = h
	set_icon(hint.type)
	in_use = true
	show()


func set_icon(hint_type: Hint.Type) -> void:
	icon.texture = ICONS[hint_type]


func use() -> void:
	in_use = false
	hide()
