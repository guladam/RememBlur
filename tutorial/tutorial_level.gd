extends Level

@export var tutorial_message_texts: Array[String]
@export var tutorial_message_button_texts: Array[String]
@onready var tutorial_message := preload("res://tutorial/tutorial_message.tscn")
@onready var obstacles: Node2D = $Obstacles
@onready var markers: Node2D = $Markers
@onready var sight_hint_giver: Node2D = $HintGivers/SightHintGiver
@onready var hearing_hint_giver: Node2D = $HintGivers/HearingHintGiver
@onready var all_hints_screen: PanelContainer = $UI/AllHintsScreen

var _time_bonuses_picked_up := 0
var _step_4 := 0
var _step_5 := 0


func _ready() -> void:
	super._ready()
	Events.time_bonus_picked_up.connect(_on_time_bonus_picked_up)
	Events.tutorial_marker_picked_up.connect(_on_marker_picked_up)
	ui.latest_hint_screen.closed.connect(_step_4_progress)
	
	var message := _show_tutorial_message(-1, 0)
	message.tutorial_message_button_clicked.connect(_step_0_finished)


func _show_tutorial_message(text_idx: int, button_idx: int) -> TutorialMessage:
	assert(text_idx < tutorial_message_texts.size(), "message index out of bounds")
	
	var new_message := tutorial_message.instantiate()
	new_message.message_tr_text = tutorial_message_texts[text_idx]
	new_message.button_tr_text = tutorial_message_button_texts[button_idx]
	new_message.game_state = game_state
	
	ui.add_child(new_message)
	new_message.show_message()
	return new_message


func _on_time_bonus_picked_up(_bonus: int) -> void:
	_time_bonuses_picked_up += 1
	if _time_bonuses_picked_up == 3:
		markers.get_child(0).reveal()


func _on_marker_picked_up(step: int) -> void:
	var current_method := "_step_%s_finished" % step
	if has_method(current_method):
		call(current_method)


func _step_0_finished() -> void:
	_show_tutorial_message(0, 0)


func _step_1_finished() -> void:
	var message := _show_tutorial_message(1, 0)
	message.tutorial_message_button_clicked.connect(_step_1_second_msg)


func _step_1_second_msg() -> void:
		var message := _show_tutorial_message(2, 0)
		message.tutorial_message_button_clicked.connect(
			func():
				obstacles.get_child(0).queue_free()
		)


func _step_2_finished() -> void:
	var message := _show_tutorial_message(3, 0)
	message.tutorial_message_button_clicked.connect(
		func():
			obstacles.get_child(0).queue_free()
	)
	set_time(90)


func _step_3_finished() -> void:
	var message := _show_tutorial_message(4, 0)
	message.tutorial_message_button_clicked.connect(_step_3_second_msg)


func _step_3_second_msg() -> void:
	var message := _show_tutorial_message(5, 0)
	message.tutorial_message_button_clicked.connect(
		func():
			obstacles.get_child(0).queue_free()
	)


func _step_4_progress() -> void:
	if _step_4 >= 2:
		return

	_step_4 += 1
	var message := _show_tutorial_message(6, 0)
	message.tutorial_message_button_clicked.connect(_step_4_progress_2)


func _step_4_progress_2() -> void:
	ui.hints_btn.show()
	all_hints_screen.closed.connect(_step_4_progress_3)


func _step_4_progress_3() -> void:
	if _step_4 < 2:
		_step_4 += 1
		var message := _show_tutorial_message(7, 0)
		message.tutorial_message_button_clicked.connect(
			func(): markers.get_child(0).reveal()
		)


func _step_4_finished() -> void:
	var message := _show_tutorial_message(8, 0)
	message.tutorial_message_button_clicked.connect(_step_4_second_msg)


func _step_4_second_msg() -> void:
	var message := _show_tutorial_message(9, 0)
	message.tutorial_message_button_clicked.connect(
		func():
			obstacles.get_child(0).queue_free()
			ui.latest_hint_screen.closed.connect(_step_5_progress)
	)


func _step_5_progress() -> void:
	if _step_5 != 0:
		return
		
	markers.get_child(0).reveal()
	_step_5 += 1


func _step_5_finished() -> void:
	var message := _show_tutorial_message(10, 0)
	message.tutorial_message_button_clicked.connect(_step_5_second_msg)


func _step_5_second_msg() -> void:
	var message := _show_tutorial_message(11, 0)
	message.tutorial_message_button_clicked.connect(_step_5_third_msg)


func _step_5_third_msg() -> void:
	ui.guess_btn.show()
	var message := _show_tutorial_message(12, 0)
	message.tutorial_message_button_clicked.connect(
		func():
			obstacles.get_child(0).queue_free()
	)


func _step_6_finished() -> void:
	super.level_won()


func level_won() -> void:
	markers.get_child(0).reveal()
