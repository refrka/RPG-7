class_name StateMachine extends Node


signal state_changed(new_state: State)



@export var initial_state: State

var active:= true

var current_state: State






func initialize(entity: EntityNode) -> void:

	for state in get_children():

		state._initialize(entity)







func request_state(state_script: Script) -> void:

	for state in get_children():
		
		if state.get_state_script() == state_script:

			_change_state(state)

			break





func get_current_state() -> State:

	return current_state









func activate() -> void:

	active = true

	if initial_state:

		_change_state(initial_state)



func deactivate() -> void:

	active = false

	if current_state:

		current_state._exit()

		current_state = null










func _change_state(new_state: State) -> void:

	if current_state == new_state:

		return

	if current_state:

		current_state._exit()

	current_state = new_state

	current_state._enter()

	state_changed.emit(current_state)




func _process(delta: float) -> void:

	if active and current_state:

		current_state._tick(delta)