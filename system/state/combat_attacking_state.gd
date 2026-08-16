class_name CombatAttackingState extends CombatState












func _update_animation_component() -> void:

	animation_component.travel_playback("combat", "ExecuteAttackState")


