extends CharacterBody2D

@export var speed := 600

@onready var sprites := {
	"front": preload("res://player/roboguy.png"),
	"back": preload("res://player/roboguy_back.png")
}
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


func _physics_process(_delta: float) -> void:
	var h_direction := Input.get_axis("left", "right")
	var v_direction := Input.get_axis("up", "down")
	velocity = Vector2(h_direction, v_direction).normalized() * speed
	update_sprite()
	play_animation()
	move_and_slide()


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
