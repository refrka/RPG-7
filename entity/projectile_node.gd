class_name ProjectileNode extends ObjectNode





var projectile_def: ProjectileDef

var source_entity: EntityNode



func set_trajectory(dir: Vector2, speed: float) -> void:

	var movement_component = get_component(MovementComponent)

	movement_component.set_move_dir(dir)

	movement_component.move_speed_override = speed





func load_projectile_def(_projectile_def: ProjectileDef) -> void:

	projectile_def = _projectile_def

	body_sprite.texture = projectile_def.body_sprite_texture

	body_sprite.position = projectile_def.body_sprite_position

	body_collision.shape = projectile_def.body_collision_shape

	body_collision.position = projectile_def.body_collision_position

	combat_hitbox.collision_shape.shape = projectile_def.hitbox_collision_shape

	combat_hitbox.collision_shape.position = projectile_def.hitbox_collision_position








static func new_projectile(item_def: ItemDef) -> ProjectileNode:

	var node = load("res://entity/projectile_node.tscn").instantiate()

	node.load_projectile_def(item_def)

	return node