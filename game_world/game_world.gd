extends Node2D

@export_dir var puzzle_folder: String
@export_file var player_stats_path: String
@export var levels_per_run := 5
@export var game_state: GameState

@onready var current_level: Node = $CurrentLevel
@onready var scene_changer: CanvasLayer = $SceneChanger
@onready var level := preload("res://levels/level.tscn")
@onready var player_stats := preload("res://stats/player_stats.tres")
@onready var ui: CanvasLayer = $UI

var levels: Array[Puzzle] = []
var level_counter := 0


func _ready() -> void:
	ui.game_over.main_menu_requested.connect(scene_changer.transition_to)
	ui.game_over.new_run_requested.connect(get_tree().reload_current_scene)
	ui.level_won.main_menu_requested.connect(scene_changer.transition_to)
	ui.level_won.next_level_requested.connect(load_next_level)
	ui.last_level_won.main_menu_requested.connect(scene_changer.transition_to)
	
	print("new run")
	player_stats.reset()
	print("TODO reset upgrades")
	generate_run()
	load_next_level()


func load_next_level() -> void:
	if level_counter > levels.size() - 1:
		return

	for c in current_level.get_children():
		c.queue_free()
	
	var new_level = level.instantiate()
	new_level.time_limit = 240 # TODO define this on a run basis
	new_level.puzzle = levels[level_counter]
	new_level.player_stats = player_stats
	new_level.game_state = game_state
	current_level.add_child(new_level)
	new_level.won.connect(_on_level_won)
	new_level.lost.connect(_on_level_lost)


func load_all_puzzles() -> Array[Puzzle]:
	var _levels: Array[Puzzle] = []
	var dir := DirAccess.open(puzzle_folder)
	if not dir:
		assert(dir, "no puzzle directory")
		return _levels
	
	for inside_dir in dir.get_directories():
		dir.change_dir(inside_dir)
		for file in dir.get_files():
			var file_path := "%s/%s" % [dir.get_current_dir(), file]
			_levels.append(load(file_path))
		dir.change_dir("../")
	
	return _levels


func generate_run() -> void:
	var all_puzzles: Array[Puzzle] = load_all_puzzles()
	all_puzzles.shuffle()
	levels = all_puzzles.slice(0, levels_per_run)


func _on_level_won() -> void:
	if level_counter == levels.size() - 1:
		ui.last_level_won.show()
	else:
		ui.level_won.show()
		
	level_counter += 1


func _on_level_lost() -> void:
	ui.game_over.show()
