extends Node2D

@export_dir var puzzle_folder: String
@export var genres: Array[String]
@export var first_level_time := 240
@export var level_time_bonus := 120
@export var levels_per_run := 5
@export var game_state: GameState

@onready var current_level: Node = $CurrentLevel
@onready var scene_changer: CanvasLayer = $SceneChanger
@onready var level := preload("res://levels/level.tscn")
@onready var player_stats := preload("res://stats/player_stats.tres")
@onready var ui: CanvasLayer = $UI

var run_name: String
var run_genre: String
var levels: Array[Puzzle] = []
var level_counter := 0
var _prev_state: GameState.State


func _ready() -> void:
	randomize()
	run_genre = genres.pick_random()
	
	ui.game_over.main_menu_requested.connect(scene_changer.transition_to)
	ui.game_over.new_run_requested.connect(get_tree().reload_current_scene)
	ui.upgrade_selector.upgrade_selected.connect(_on_upgrade_selected)
	ui.level_won.main_menu_requested.connect(scene_changer.transition_to)
	ui.level_won.next_level_requested.connect(load_next_level)
	ui.last_level_won.story_requested.connect(_on_story_requested)
	ui.pause.resume_game.connect(_on_resume_requested)
	ui.pause.go_to_main_menu.connect(_on_main_menu_from_pause)
	ui.story_board.main_menu_requested.connect(scene_changer.transition_to)
	ui.name_setup.name_given.connect(_on_name_given)
	
	player_stats.reset()
	generate_run()


func load_next_level() -> void:
	if level_counter > levels.size() - 1:
		return

	var next_time_limit := _get_time_for_next_level()

	for c in current_level.get_children():
		c.queue_free()
	
	var new_level = level.instantiate()
	new_level.time_limit = next_time_limit
	new_level.puzzle = levels[level_counter]
	new_level.player_stats = player_stats
	new_level.game_state = game_state
	current_level.add_child(new_level)
	new_level.won.connect(_on_level_won)
	new_level.lost.connect(_on_level_lost)
	new_level.pause.connect(_on_pause_requested)


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


func _get_time_for_next_level() -> float:
	if level_counter == 0:
		return first_level_time
	else:
		var time_left: float = current_level.get_child(0).get_time_left()
		var time_total: float = time_left + level_time_bonus + player_stats.time_bonus
		return time_total * player_stats.get_multiplier(player_stats.time_multipliers, player_stats.SIGN.POSITIVE)


func _pause() -> void:
	game_state.state = GameState.State.PAUSED
	get_tree().paused = true
	ui.pause.show()


func _unpause() -> void:
	game_state.state = _prev_state
	get_tree().paused = false
	ui.pause.hide()


func _on_level_won() -> void:
	if level_counter == levels.size() - 1:
		ui.last_level_won.show()
	else:
		ui.upgrade_selector.show_upgrades()
		
	level_counter += 1


func _on_level_lost() -> void:
	ui.game_over.show()


func _on_pause_requested(pause: bool) -> void:
	if game_state.state != GameState.State.PAUSED:
		_prev_state = game_state.state

	if pause:
		_pause()
	else:
		_unpause()


func _on_resume_requested() -> void:
	_on_pause_requested(false)


func _on_main_menu_from_pause() -> void:
	game_state.state = _prev_state
	get_tree().paused = false
	scene_changer.transition_to()


func _on_name_given(_name: String) -> void:
	run_name = _name
	ui.last_level_won.setup(run_name, tr(run_genre))
	ui.game_over.setup(run_name)
	load_next_level()


func _on_upgrade_selected() -> void:
	ui.level_won.show_screen(run_name, levels.size() - level_counter)


func _on_story_requested() -> void:
	var words := levels.map(func(p: Puzzle): return tr(p.solution_key))
	var english_genre := TranslationServer.get_translation_object("en").get_message(run_genre)
	ui.story_board.show_story(words, english_genre, run_name)
