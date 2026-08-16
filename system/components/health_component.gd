class_name HealthComponent extends Component


signal health_depleted




var max_health: float

var current_health: float





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	var entity_def = entity.get_entity_def()

	max_health = entity_def.base_max_health

	current_health = max_health








func receive_damage_package(damage_package: DamagePackage) -> void:

	for damage_entry in damage_package.damage_entries:

		reduce_health(damage_entry.amount)




func reduce_health(amount: float) -> void:

	if is_alive():

		current_health -= amount

		if !is_alive():

			health_depleted.emit()







func is_alive() -> bool:

	return current_health > 0.0