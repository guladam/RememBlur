@tool
extends Resource
class_name Upgrade

@export var name_key: String
@export var icon: Texture
@export var one_time := false

var stat_name: String
var type := TYPE_NIL


func _get_property_list() -> Array:
	if type == TYPE_NIL:
		return []
	
	var properties = []
	var stat := PlayerStats.new()
	var prop_strings: PackedStringArray = []
	
	for prop in stat.get_property_list():
		if prop["type"] == type:
			prop_strings.append(prop["name"])
	
	stat = null
	
	if prop_strings.is_empty():
		return []
		
	properties.append({
		"name": "stat_name",
		"type": TYPE_STRING,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(prop_strings)
	})

	return properties


func upgrade(_stats: PlayerStats) -> void:
	pass


func apply(stats: PlayerStats, property: String, value: Variant) -> void:
	stats.set(property, value)


func apply_array(stats: PlayerStats, property: String, value: Variant) -> void:
	stats.get(property).append(value)
