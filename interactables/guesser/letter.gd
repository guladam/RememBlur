extends Label


var revealed := false


func reveal() -> void:
	if revealed:
		return
	
	revealed = true
	var t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(self, "scale", Vector2(1.2, 1.35), 0.35)
	t.parallel().tween_property(self, "modulate", Color.ANTIQUE_WHITE, 0.35)
	t.tween_property(self, "scale", Vector2.ONE, 0.25)
	t.parallel().tween_property(self, "modulate", Color.WHITE, 0.25)


func flash_red() -> void:
	var t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(self, "modulate", Color.RED, 0.35)
	t.tween_property(self, "modulate", Color.WHITE, 0.25)
