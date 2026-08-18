class_name EntityNode extends PhysicsBody2D



@export var entity_def: EntityDef

@export var body_sprite: Sprite2D

@export var body_collision: CollisionShape2D

@export var body_hurtbox: Hurtbox

@export var combat_hitbox: Hitbox

@export var vision_sensor: Sensor

@export var component_root: Node

@export var state_machine: StateMachine

@export var temp_visual_root: Node2D

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

	var animation_component = get_component(AnimationComponent)

	animation_component.travel_playback("body", "FlinchBlend")



func set_visuals_orientation(dir: Vector2) -> void:

	var state = dir.x < 0.0

	var y_dir:= 0

	y_dir = 1 if dir.y > 0.0 else -1

	flip_visuals(state, y_dir)





func flip_visuals(state: bool, y_dir: int) -> void:

	if temp_visual_root:

		for base_node in temp_visual_root.get_children():

			var temp_entity = base_node.get_child(0)

			temp_entity.flip_visuals(state, y_dir)

	if y_dir == -1:

		body_sprite.frame = 1

	elif y_dir == 1:

		body_sprite.frame = 0

	if visuals_flipped == state:

		return

	visuals_flipped = state 

				





func add_projectile_temp_visual(projectile_node: ProjectileNode) -> void:

	var projectile_base_node = Node2D.new()

	temp_visual_root.add_child(projectile_base_node)

	projectile_base_node.position = Vector2.ZERO

	projectile_node.reparent.call_deferred(projectile_base_node)

	projectile_node.base_node = projectile_base_node

	# projectile_node.set("position", projectile_node.global_position - global_position)

	# if visuals_flipped:

	# 	flip_projectile_visual.call_deferred(projectile_node, visuals_flipped)









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

	await get_tree().process_frame

	body_collision.disabled = false








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

	body_collision.disabled = true