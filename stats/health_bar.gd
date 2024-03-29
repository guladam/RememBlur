extends MarginContainer

@export var player_stats: PlayerStats

@onready var lives: GridContainer = %Lives
@onready var health_icon = preload("res://stats/health_icon.tscn")
@onready var icons := {
	"full": preload("res://stats/energy.png"),
	"empty": preload("res://stats/energy_empty.png")
}


func clear_children() -> void:
	for c in lives.get_children():
		c.queue_free()

func show_hearts() -> void:
	clear_children()
	
	for i in range(player_stats.max_health):
		var new_icon := health_icon.instantiate()
		lives.add_child(new_icon)
		new_icon.texture = icons["empty"]


func setup() -> void:
	player_stats.max_health_changed.connect(show_hearts)
	player_stats.health_changed.connect(update_hearts)
	show_hearts()
	update_hearts()


func update_hearts() -> void:
	# wait for the previous hearts to be deleted
	await get_tree().process_frame
	
	for i in range(lives.get_child_count()):
		lives.get_child(i).texture = icons["full"] if i+1 <= player_stats.health else icons["empty"]
