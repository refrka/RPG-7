class_name CombatState extends State




var combat_component: CombatComponent




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	combat_component = entity.get_component(CombatComponent)





func _update_animation_component() -> void:

	pass