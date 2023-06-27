extends ColorRect


@onready var video := %Video
@onready var sound := %Sound
@onready var music := %Music
@onready var vsync := %VSync
@onready var save_btn := %Save
@onready var scene_changer: CanvasLayer = $SceneChanger
@onready var lang_selector: VBoxContainer = $LangSelector

var _settings: ConfigFile


func _ready():
	load_settings()
	setup()
	lang_selector.setup()


func load_settings() -> void:
	_settings = ConfigFile.new()
	var err = _settings.load("user://settings.cfg")

	if err != OK:
		save_default()



func save_default() -> void:
	_settings = ConfigFile.new()

	_settings.set_value("settings", "video", 0)
	_settings.set_value("settings", "sound", 100)
	_settings.set_value("settings", "music", 100)
	_settings.set_value("settings", "vsync", true)
	_settings.set_value("settings", "language", "en")

	_settings.save("user://settings.cfg")


func save() -> void:
	_settings = ConfigFile.new()

	_settings.set_value("settings", "video", video.selected)
	_settings.set_value("settings", "sound", sound.value)
	_settings.set_value("settings", "music", music.value)
	_settings.set_value("settings", "vsync", vsync.button_pressed)
	_settings.set_value("settings", "language", TranslationServer.get_locale().substr(0, 2))

	_settings.save("user://settings.cfg")


func setup() -> void:
	for setting in _settings.get_sections():
		var video_setting = _settings.get_value(setting, "video")
		var sound_setting = _settings.get_value(setting, "sound")
		var music_setting = _settings.get_value(setting, "music")
		var vsync_setting = _settings.get_value(setting, "vsync")

		video.select(video_setting)
		_on_Video_item_selected(video_setting)
		sound.value = sound_setting
		_on_Sound_value_changed(sound_setting)
		music.value = music_setting
		_on_Music_value_changed(music_setting)
		vsync.button_pressed = vsync_setting
		_on_VSync_toggled(vsync_setting)


func _on_Video_item_selected(index: int):
	Utils.set_display_mode(index)


func _on_Sound_value_changed(value: float):
	Utils.set_sound_volume(value)
	

func _on_Music_value_changed(value: float):
	Utils.set_music_volume(value)


func _on_VSync_toggled(button_pressed: bool):
	Utils.set_vsync_mode(button_pressed)


func _on_Save_pressed():
	save()
	scene_changer.transition_to()
