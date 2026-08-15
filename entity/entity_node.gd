class_name EntityNode extends PhysicsBody2D




@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D

@export var component_root: Node

@export var state_machine: StateMachine



var active:= false

var initialized:= false



var body_sprite_flipped:= false





func _initialize() -> void:

	assert(!initialized, "Trying to initialize entity more than once: %s" % self)

	for component in get_all_components():

		component._initialize(self)

	state_machine.initialize(self)

	initialized = true























func get_all_components() -> Array[Component]:

	return component_root.get_children() as Array[Component]





func get_component(component_script: Script) -> Component:

	for component in get_all_components():

		if component.get_component_script() == component_script:

			return component

	return null






func set_body_sprite_flipped(state: bool) -> void:

	body_sprite_flipped = state

	body_sprite.flip_h = state



func set_body_sprite_up(state: bool) -> void:

	body_sprite.frame = 0 if state == false else 1










func is_sprite_flipped() -> bool:

	return body_sprite_flipped















func _activate() -> void:

	assert(initialized, "Trying to activate uninitialized entity: %s" % self)

	show()

	active = true

	process_mode = Node.PROCESS_MODE_INHERIT

	for component in get_all_components():

		component._activate()






func _deactivate() -> void:

	hide()

	active = false

	process_mode = Node.PROCESS_MODE_DISABLED

	for component in get_all_components():

		component._deactivate()