class_name State extends Node




var entity: EntityNode

var animation_component: AnimationComponent

var movement_component: MovementComponent

var allow_reenter:= false




func _initialize(_entity: EntityNode) -> void:

	entity = _entity

	animation_component = entity.get_component(AnimationComponent)

	movement_component = entity.get_component(MovementComponent)




func get_state_script() -> Script:

	return get_script()



func get_state_name() -> String:

	return name.trim_suffix("State")




func transition(state_script: Script) -> void:

	var state_machine = get_parent()

	state_machine.request_state(state_script)




func _enter() -> void:

	_connect_signals()

	if animation_component:

		_update_animation_component()




func _exit() -> void:

	_disconnect_signals()





func _connect_signals() -> void:

	pass




func _disconnect_signals() -> void:

	pass




func _update_animation_component() -> void:

	pass





func _tick(_delta: float) -> void:

	pass