class_name State extends Node




var entity: EntityNode

var animation_component: AnimationComponent




func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	animation_component = entity.get_component(AnimationComponent)




func get_state_script() -> Script:

	return get_script()




func _enter() -> void:

	if animation_component:

		_update_animation_component()




func _exit() -> void:

	pass




func _update_animation_component() -> void:

	pass




func _tick(_delta: float) -> void:

	pass