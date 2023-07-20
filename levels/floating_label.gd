extends Label


func setup(_text: String) -> void:
	if not is_inside_tree():
		await self.ready

	text = _text
	animate()


func animate() -> void:
	var _t := get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	_t.tween_property(self, "position", position + Vector2(0, -40), 1.0)
	_t.parallel().tween_property(self, "modulate", Color.TRANSPARENT, 1.0)
	_t.tween_callback(queue_free)
