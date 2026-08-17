class_name EntityNode extends PhysicsBody2D



@export var entity_def: EntityDef

@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D

@export var body_hurtbox: Hurtbox

@export var combat_hitbox: Hitbox

@export var vision_sensor: Sensor

@export var component_root: Node

@export var state_machine: StateMachine


@export var visuals_flipped:= false:

	set(value):

		visuals_flipped = value

		body_sprite.flip_h = value



var active:= false

var initialized:= false

var inventory: Inventory



func _initialize() -> void:

	assert(!initialized, "Trying to initialize entity more than once: %s" % self)

	if entity_def.initial_inventory:

		inventory = entity_def.initial_inventory

	else:

		inventory = Inventory.new()

	inventory.initialize()

	for component in get_all_components():

		component._initialize(self)

	state_machine.initialize(self)

	if body_hurtbox:

		body_hurtbox.setup(self)

	if combat_hitbox:

		combat_hitbox.setup(self)

	if vision_sensor:

		vision_sensor.setup(self)

	initialized = true








func _reset() -> void:

	initialized = false

	inventory = null

	for component in get_all_components():

		if component.has_method("reset"):

			component.reset()










func receive_damage_package(damage_package: DamagePackage) -> void:

	var health_component = get_component(HealthComponent)

	if health_component:

		health_component.receive_damage_package(damage_package)




func flip_visuals(state: bool) -> void:

	visuals_flipped = state






func is_moving() -> bool:

	var movement_component = get_component(MovementComponent)

	return movement_component.is_moving()











func get_all_components() -> Array[Component]:

	return component_root.get_children() as Array[Component]





func get_component(component_script: Script) -> Component:

	for component in get_all_components():

		if component.get_component_script() == component_script:

			return component

	return null





func get_entity_def() -> EntityDef:

	return entity_def



func get_display_name() -> StringName:

	return entity_def.display_name



func get_entity_id() -> StringName:

	return entity_def.entity_id







func _activate() -> void:

	assert(initialized, "Trying to activate uninitialized entity: %s" % self)

	show()

	active = true

	process_mode = Node.PROCESS_MODE_INHERIT

	for component in get_all_components():

		component._activate()

	if state_machine: state_machine.activate()

	if body_hurtbox: body_hurtbox.activate()

	if combat_hitbox: combat_hitbox.activate()

	if vision_sensor: vision_sensor.activate()








func _deactivate() -> void:

	hide()

	active = false

	process_mode = Node.PROCESS_MODE_DISABLED

	for component in get_all_components():

		component._deactivate()

	if state_machine: state_machine.deactivate()

	if body_hurtbox: body_hurtbox.deactivate()

	if combat_hitbox: combat_hitbox.deactivate()

	if vision_sensor: vision_sensor.deactivate()