extends Control

@onready var label: Label = $VboxContainer/Label
@onready var bonus_marker: Marker2D = $BonusMarker
@onready var time_label := preload("res://levels/floating_label.tscn")
var timer: Timer


func setup(_timer: Timer) -> void:
	timer = _timer
	Events.time_bonus_picked_up.connect(add_time)


func _process(_delta: float) -> void:
	if timer:
		label.text = Utils.seconds_to_mm_ss(timer.time_left)


func add_time(amount: int) -> void:
	var new_label := time_label.instantiate()
	add_child(new_label)
	new_label.position = bonus_marker.position
	new_label.setup("+%s s" % amount)
