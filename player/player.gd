extends CharacterBody2D

@export var speed := 600
@export var game_state: GameState
@export var player_stats: PlayerStats

@onready var sprites := {
	"front": preload("res://player/roboguy.png"),
	"back": preload("res://player/roboguy_back.png")
}
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var box: Sprite2D = $Sprite2D/Box


func _physics_process(_delta: float) -> void:
	if game_state and game_state.state != GameState.State.PLAYING:
		return
	
	var h_direction := Input.get_axis("left", "right")
	var v_direction := Input.get_axis("up", "down")
	velocity = Vector2(h_direction, v_direction).normalized() * get_speed()
	update_sprite()
	play_animation()
	move_and_slide()


func get_speed() -> float:
	return (speed + player_stats.move_speed_bonus) * player_stats.get_multiplier(player_stats.move_speed_multipliers, player_stats.SIGN.POSITIVE)


func update_sprite() -> void:
	if velocity.y < -0.05:
		sprite.texture = sprites["back"]
	elif velocity.y > 0.05:
		sprite.texture = sprites["front"]


func play_animation() -> void:
	if velocity.length() > 0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")


func _on_player_interaction_box_requested(hint: Hint) -> void:
	if box.in_use:
		print("you already have a box!")
		return

	box.setup(hint)


func _on_player_interaction_box_used() -> void:
	box.use()
