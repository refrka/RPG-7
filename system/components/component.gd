class_name Component extends Node






var active:= false

var entity: EntityNode












func _initialize(_entity: EntityNode) -> void:

	entity = _entity












func get_component_name() -> String:

	return name.to_snake_case()




func get_component_script() -> Script:

	return get_script()













func _activate() -> void:

	active = true




func _deactivate() -> void:

	active = false