extends Node2D
class_name Gate

@export var destination_gate: Gate
@export var game_state: GameState
@export var reverse_arrow := false
@export var sound: AudioStream
@onready var front: Polygon2D = $Sprite2D/Front
@onready var back: Polygon2D = $Sprite2D/Back


const  ANIM_SPEED := 0.25


func _ready() -> void:
	if reverse_arrow:
		front.hide()
		back.show()


func arrive(player: Node2D) -> void:
	player.global_position = self.global_position
	var t := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(player, "scale", Vector2.ONE, ANIM_SPEED)
	t.parallel().tween_property(player.visuals, "modulate", Color.WHITE, ANIM_SPEED)
	t.tween_callback(game_state.set.bind("state", GameState.State.PLAYING))
	

func _on_interactable_interacted(player: Node2D) -> void:
	if not destination_gate or not game_state or game_state.state == GameState.State.DIVING:
		return
		
	game_state.state = GameState.State.DIVING
	SfxPlayer.play(sound)
	var t := create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(player.get_player(), "global_position", self.global_position, ANIM_SPEED)
	t.parallel().tween_property(player.get_player(), "scale", Vector2.ZERO, ANIM_SPEED)
	t.parallel().tween_property(player.get_player().visuals, "modulate", Color.TRANSPARENT, ANIM_SPEED)
	t.tween_callback(destination_gate.arrive.bind(player.get_player()))	
