extends VBoxContainer


@onready var label: Label = $Label
var timer: Timer


func setup(_timer: Timer) -> void:
	timer = _timer


func _process(_delta: float) -> void:
	if timer:
		label.text = Utils.seconds_to_mm_ss(timer.time_left)
