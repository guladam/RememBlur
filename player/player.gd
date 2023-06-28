extends CharacterBody2D

@export var speed := 600
@export var rotation_speed := 0.25
@export var game_state: GameState
@export var player_stats: PlayerStats

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visuals: CanvasGroup = $Visuals
@onready var head: Sprite2D = $Visuals/Head


func _physics_process(_delta: float) -> void:
	if game_state and game_state.state != GameState.State.PLAYING:
		animation_player.play("idle")
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
	if velocity.length() > 0.05:
		head.rotation = lerp_angle(head.rotation, Vector2.ZERO.angle_to_point(velocity), rotation_speed)


func play_animation() -> void:
	if velocity.length() > 0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")
