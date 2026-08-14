class_name LanguageHandler extends Node



var cur_lang: String:
	set(val):
		TranslationServer.set_locale(val)
		
func _ready() -> void:
	cur_lang = Settings._get_specific_value("Language")
