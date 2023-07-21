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
@onready var helpfulness_sounds := [
	preload("res://interactables/hint_examiner/unhelpful.ogg"),
	preload("res://interactables/hint_examiner/helpful1.ogg"),
	preload("res://interactables/hint_examiner/helpful2.ogg"),
	preload("res://interactables/hint_examiner/helpful3.ogg")
]

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
	_set_hint_text()
	_show_helpfulness(puzzle)
	_set_visibilities()
	
	var helpfulness := puzzle.get_helpfulness_of_hint(hint)
	var idx := helpfulness if helpfulness > 0 else 0
	SfxPlayer.play(helpfulness_sounds[idx])


func _set_type() -> void:
	icon.texture = ICONS_BY_TYPE[hint.type]
	type.text = tr(hint.get_type_as_string().to_upper())


func _set_visibilities() -> void:
	hint_image.texture = hint.img
	
	sound.visible = hint.type == Hint.Type.HEARING
	hint_image.visible = hint.img != null
	
	if hint.type == Hint.Type.HEARING:
		hint_text.visible = false


func _set_hint_text() -> void:
	if hint.type == Hint.Type.HEARING:
		return

	hint_text.text = tr(hint.text)


func _show_helpfulness(puzzle: Puzzle) -> void:
	var helpfulness := puzzle.get_helpfulness_of_hint(hint)
	helpful.visible = helpfulness > 0
	unhelpful.visible = not helpful.visible
	
	if helpful.visible:
		for i in range(helpful.get_child_count()):
			helpful.get_child(i).texture = star_full if i+1 <= helpfulness else star_empty
	

func _on_play_sound_pressed() -> void:
	SfxPlayer.play(hint.sound, true)
