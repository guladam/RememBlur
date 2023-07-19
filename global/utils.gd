extends RefCounted
class_name Utils


static func seconds_to_mm_ss(time: float) -> String:
	var minutes := time / 60.0
	var seconds := fmod(time, 60.0) 
	return "%02d:%02d" % [minutes, seconds]


static func load_config() -> void:
	var _settings = ConfigFile.new()
	var err = _settings.load("user://settings.cfg")

	if err != OK:
		set_language("en")
		return

	for setting in _settings.get_sections():
		var video_setting = _settings.get_value(setting, "video")
		var sound_setting = _settings.get_value(setting, "sound")
		var music_setting = _settings.get_value(setting, "music")
		var vsync_setting = _settings.get_value(setting, "vsync")
		var language = _settings.get_value(setting, "language")
		
		set_display_mode(video_setting)
		set_sound_volume(sound_setting)
		set_music_volume(music_setting)
		set_vsync_mode(vsync_setting)
		set_language(language)


static func set_display_mode(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_EXTEND_TO_TITLE, false)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_EXTEND_TO_TITLE, true)


static func set_sound_volume(value: float):
	var bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus, linear_to_db(value / 100.0))


static func set_music_volume(value: float):
	var bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus, linear_to_db(value / 100.0))


static func set_vsync_mode(enabled: bool) -> void:
	var mode := DisplayServer.VSYNC_ENABLED if enabled else DisplayServer.VSYNC_DISABLED
	DisplayServer.window_set_vsync_mode(mode)


static func set_language(lang: String) -> void:
	TranslationServer.set_locale(lang)
