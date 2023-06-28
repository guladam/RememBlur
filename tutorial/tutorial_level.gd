extends Level

@export var tutorial_message_texts: Array[String]
@export var tutorial_message_button_texts: Array[String]
@onready var tutorial_message := preload("res://tutorial/tutorial_message.tscn")
@onready var obstacles: Node2D = $Obstacles
@onready var markers: Node2D = $Markers

var _time_bonuses_picked_up := 0


func _ready() -> void:
	super._ready()
	Events.time_bonus_picked_up.connect(_on_time_bonus_picked_up)
	Events.tutorial_marker_picked_up.connect(_on_marker_picked_up)
	var message := _show_tutorial_message(-1)
	message.tutorial_message_button_clicked.connect(_step_0_finished)
	

func _show_tutorial_message(i: int) -> TutorialMessage:
	assert(i < tutorial_message_texts.size(), "message index out of bounds")
	
	var new_message := tutorial_message.instantiate()
	new_message.message_tr_text = tutorial_message_texts[i]
	new_message.button_tr_text = tutorial_message_button_texts[i]
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
	_show_tutorial_message(0)


func _step_1_finished() -> void:
	var message := _show_tutorial_message(1)
	message.tutorial_message_button_clicked.connect(
		func():
			obstacles.get_child(0).queue_free()
	)

func _step_2_finished() -> void:
	var message := _show_tutorial_message(2)
	message.tutorial_message_button_clicked.connect(
		func():
			obstacles.get_child(0).queue_free()
	)


func _step_3_finished() -> void:
	var message := _show_tutorial_message(3)
	message.tutorial_message_button_clicked.connect(
		func():
			obstacles.get_child(0).queue_free()
	)


func _step_4_finished() -> void:
	#TODO
	pass


func _step_5_finished() -> void:
	#TODO
	pass
