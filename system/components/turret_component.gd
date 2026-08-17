class_name TurretComponent extends Component



@export var origin_node: Node2D



@export var projectile_def: ProjectileDef

@export var projectile_speed:= 200.0





func fire_projectile() -> void:

	var projectile_node = ProjectileNode.new_projectile(projectile_def)

	var dir = Vector2.RIGHT.rotated(deg_to_rad(origin_node.rotation_degrees))

	projectile_node.set_trajectory(dir, projectile_speed)

	projectile_node.source_entity = entity

	var location = Game.get_location()

	location.add_entity_node(projectile_node, origin_node.global_position)






func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("dodge"):

		fire_projectile()