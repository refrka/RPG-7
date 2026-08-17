class_name CombatAttackingState extends CombatState







func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	allow_reenter = true





func _enter() -> void:

	super()

	var attack_entry = combat_component.get_attack_entry()

	if attack_entry.lunge_factor > 0.0:

		var lunge_velocity = attack_entry.lunge_factor * combat_component.current_attack_dir

		var modifier = VelocityModifier.new_impulse(lunge_velocity, 15.0)

		movement_component.add_modifier(modifier)

	else:

		movement_component.halt()

		movement_component.can_move = false

		movement_component.can_turn = false




func _exit() -> void:

	super()

	movement_component.can_move = true

	movement_component.can_turn = true





func _update_animation_component() -> void:

	animation_component.travel_playback("combat", "ExecuteAttackState")

	if movement_component.is_moving():

		animation_component.start_playback("body", "MovingBlend")

	else:

		animation_component.start_playback("body", "IdleBlend")


