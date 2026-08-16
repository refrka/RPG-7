class_name CombatAttackingState extends CombatState







func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	allow_reenter = true





func _enter() -> void:

	super()

	movement_component.halt()

	movement_component.can_move = false

	movement_component.can_turn = false




func _exit() -> void:

	super()

	movement_component.can_move = true

	movement_component.can_turn = true





func _update_animation_component() -> void:

	animation_component.travel_playback("combat", "ExecuteAttackState")


