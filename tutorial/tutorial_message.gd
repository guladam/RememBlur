extends PanelContainer
class_name TutorialMessage

signal tutorial_message_button_clicked

@export var message_tr_text: String
@export var button_tr_text: String
@export var game_state: GameState

@onready var message: Label = %Message
@onready var button: Button = %Button

var _prev_state: GameState.State


func _ready() -> void:
	message.text = tr(message_tr_text)
	button.text = tr(button_tr_text)
	await get_tree().process_frame
	pivot_offset = size / 2


func show_message() -> void:
	_prev_state = game_state.state
	game_state.state = GameState.State.IN_UI
	
	scale = Vector2.ZERO
	show()
	var _t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	_t.tween_property(self, "scale", Vector2.ONE, 0.2)
	_t.parallel().tween_property(self, "modulate", Color.WHITE, 0.2)


func _on_button_pressed() -> void:
	await close()
	game_state.state = _prev_state
	tutorial_message_button_clicked.emit()


func close() -> void:
	var _t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	_t.tween_property(self, "scale", Vector2(0.5, 0.5), 0.2)
	_t.parallel().tween_property(self, "modulate", Color.TRANSPARENT, 0.2)
	_t.tween_callback(hide)
	
	await _t.finished
