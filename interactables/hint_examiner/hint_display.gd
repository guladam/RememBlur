extends PanelContainer


@onready var icon: TextureRect = %Icon
@onready var type: Label = %Type
@onready var hint_text: Label = %HintText
@onready var hint_image: TextureRect = %HintImage
@onready var sound: HBoxContainer = %Sound
@onready var unhelpful: TextureRect = %UnHelpful
@onready var helpful: HBoxContainer = %Helpful
@onready var star_full: Texture = preload("res://interactables/hint_examiner/assets/star.png")
@onready var star_empty: Texture = preload("res://interactables/hint_examiner/assets/star_empty.png")

var hint: Hint

const ICONS_BY_TYPE := {
	Hint.Type.TASTE: preload("res://interactables/hint_examiner/assets/taste_icon.png"),
	Hint.Type.SMELL: preload("res://interactables/hint_examiner/assets/nose_icon.png"),
	Hint.Type.HEARING: preload("res://interactables/hint_examiner/assets/ear_icon.png"),
	Hint.Type.TOUCH: preload("res://interactables/hint_examiner/assets/hand_icon.png"),
	Hint.Type.SIGHT: preload("res://interactables/hint_examiner/assets/eye_icon.png")
}


func setup(_hint: Hint, puzzle: Puzzle) -> void:
	hint = _hint

	_set_type()
	_set_visibilities()
	_show_helpfulness(puzzle)


func _set_type() -> void:
	icon.texture = ICONS_BY_TYPE[hint.type]
	type.text = tr(hint.get_type_as_string().to_upper())


func _set_visibilities() -> void:
	hint_text.text = hint.text
	hint_image.texture = hint.img
	
	sound.visible = hint.type == Hint.Type.HEARING
	hint_text.visible = hint.text != ""
	hint_image.visible = hint.img != null


func _show_helpfulness(puzzle: Puzzle) -> void:
	var helpfulness := puzzle.get_helpfulness_of_hint(hint)
	helpful.visible = helpfulness > 0
	unhelpful.visible = not helpful.visible
	
	if helpful.visible:
		for i in range(helpful.get_child_count()):
			helpful.get_child(i).texture = star_full if i+1 <= helpfulness else star_empty
	

func _on_play_sound_pressed() -> void:
	SfxPlayer.play(hint.sound, true)
