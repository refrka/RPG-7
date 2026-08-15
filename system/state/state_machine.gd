class_name StateMachine extends Node




@export var initial_state: State

var active:= true

var current_state: State






func initialize(entity: EntityNode) -> void:

	for state in get_children():

		state._initialize(entity)

	if initial_state:

		_change_state(initial_state)







func request_state(state_script: Script) -> void:

	for state in get_children():
		
		if state.get_state_script() == state_script:

			_change_state(state)

			break





func get_current_state() -> State:

	return current_state







func _change_state(new_state: State) -> void:

	if current_state:

		current_state._exit()

	current_state = new_state

	current_state._enter()







func _process(delta: float) -> void:

	if active and current_state:

		current_state._tick(delta)