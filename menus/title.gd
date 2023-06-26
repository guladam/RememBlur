extends HBoxContainer

@export var min_flickering_letters := 2
@export var max_flickering_letters := 6
@export var min_flicker_interval := 2.0
@export var max_flicker_interval := 6.0
@export var min_letter_flicker_delay := 0.15
@export var max_letter_flicker_delay := 0.3
@onready var timer: Timer = $Timer

var _letters := []

func _ready() -> void:
	randomize()
	_letters = range(get_child_count()-1)
	start_timer()


func start_timer() -> void:
	timer.wait_time = randf_range(min_flicker_interval, max_flicker_interval)
	timer.start()


func flicker() -> void:
	_letters.shuffle()
	var to_flicker := _letters.slice(0, randi_range(min_flickering_letters, max_flickering_letters))
	var t := get_tree().create_tween()
	
	for i in to_flicker:
		t.parallel().tween_callback(get_child(i).flicker)
		t.tween_interval(randf_range(min_letter_flicker_delay, max_letter_flicker_delay))
	
	await t.finished


func _on_timer_timeout() -> void:
	await flicker()
	start_timer()
