class_name CombatState extends State




var combat_component: CombatComponent




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	combat_component = entity.get_component(CombatComponent)








func _update_animation_component() -> void:

	if animation_component.get_playback_current_node("root") != "CombatState":

		animation_component.travel_playback("root", "CombatState")

	