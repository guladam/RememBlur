extends ColorRect

@onready var language: Label = %Language
var languages: PackedStringArray
var selected_lang: int


func _ready() -> void:
	languages = TranslationServer.get_loaded_locales()
	selected_lang = languages.find(TranslationServer.get_locale().substr(0, 2))
	language.text = tr(languages[selected_lang])


func _on_left_pressed() -> void:
	_switch_language(-1)


func _on_right_pressed() -> void:
	_switch_language(1)


func _switch_language(direction: int) -> void:
	var idx := wrapi(selected_lang + direction, 0, languages.size())
	TranslationServer.set_locale(languages[idx])
	language.text = tr(languages[idx])
	selected_lang = idx
