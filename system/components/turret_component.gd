class_name TurretComponent extends Component



@export var origin_node: Node2D


@export var turret_config: TurretConfig

var firing_active:= false

var firing_timer:= 0.0







func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	if turret_config.turret_mode == TurretConfig.TurretMode.PROXIMITY:

		entity.vision_sensor.body_entered_sensor.connect(_on_body_entered_vision_sensor)

		entity.vision_sensor.body_exited_sensor.connect(_on_body_exited_vision_sensor)







func _activate() -> void:

	super()

	if firing_active:

		fire_projectile()





func _activate_firing() -> void:

	firing_active = true

	fire_projectile()




func _deactivate_firing() -> void:

	firing_active = false

	firing_timer = 0.0






func fire_projectile() -> void:

	firing_timer = turret_config.firing_rate

	var projectile_node = ProjectileNode.new_projectile(turret_config.projectile_def)

	var dir = Vector2.RIGHT.rotated(deg_to_rad(origin_node.rotation_degrees))

	projectile_node.set_trajectory(dir, turret_config.projectile_speed)

	projectile_node.source_entity = entity

	var location = Game.get_location()

	location.add_entity_node(projectile_node, origin_node.global_position)

	projectile_node._activate()





func _on_body_entered_vision_sensor(body: PhysicsBody2D) -> void:

	_activate_firing()



func _on_body_exited_vision_sensor(body: PhysicsBody2D) -> void:

	if entity.vision_sensor.bodies.is_empty():

		_deactivate_firing()






func _process(delta: float) -> void:

	if !active:

		return

	if !firing_active:

		return

	if turret_config.turret_mode != TurretConfig.TurretMode.TARGET:

		firing_timer -= delta

		if firing_timer <= 0.0:

			fire_projectile()