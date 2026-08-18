extends Node




enum DebugState {

	INACTIVE,

	ACTIVE,

}



var state: DebugState

var debug_root: DebugRoot








func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	debug_root = get_tree().get_first_node_in_group("debug_root")

	_deactivate()







func _activate() -> void:

	state = DebugState.ACTIVE

	debug_root._activate()




func _deactivate() -> void:

	state = DebugState.INACTIVE

	debug_root._deactivate()






func _on_1_pressed() -> void:

	pass


func _on_2_pressed() -> void:

	pass


func _on_3_pressed() -> void:

	pass






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("debug"):

		if state == DebugState.ACTIVE:

			_deactivate()

		else:

			_activate()


	if event.is_action_pressed("1"):

		_on_1_pressed()

	if event.is_action_pressed("2"):

		_on_2_pressed()

	if event.is_action_pressed("3"):

		_on_3_pressed()