class_name StickingToEntityState extends State




var initial_entity_dir: Vector2






func _enter() -> void:

	if entity.stuck_entity.visuals_flipped:

		entity.invert_visuals = true



