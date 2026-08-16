class_name CombatComponent extends Component







var current_attack_config: AttackConfig

var current_attack_dir: Vector2

var current_attack_index:= 0

var current_library_name: String

var current_animation_name: String




var attack_animation_node: AnimationNodeAnimation





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.weapon_attack_pressed.connect(_on_weapon_attack_input_pressed)

		input_component.weapon_attack_released.connect(_on_weapon_attack_input_released)

	var animation_component = entity.get_component(AnimationComponent)

	attack_animation_node = animation_component.get_attack_animation_node()

	_load_initial_attack_config()







func reset() -> void:

	_clear_attack_data()





func receive_damage_package(damage_package: DamagePackage) -> void:

	if _is_attacking():

		_interrupt_attack()





func get_attack_entry(index:= -1) -> AttackEntry:

	if index == -1:

		index = current_attack_index

	return null










func _try_attack() -> void:

	if !_is_in_combat():

		_enter_combat()

	if _is_attack_index_valid(current_attack_index):

		_start_attack()





func _start_attack() -> void:

	current_animation_name = _get_attack_animation_name()

	attack_animation_node.animation = current_animation_name

	_execute_attack()




func _start_charge() -> void:

	pass



func _cancel_charge() -> void:

	pass



func _complete_charge() -> void:

	pass




func _execute_attack() -> void:

	print("executing")

	entity.state_machine.request_state(CombatAttackingState)





func _finish_attack() -> void:

	current_attack_index = 0

	current_animation_name = ""

	current_attack_dir = Vector2.ZERO

	entity.state_machine.request_state(CombatReadyState)




func _interrupt_attack() -> void:

	pass





func _enter_combat() -> void:

	entity.state_machine.request_state(CombatReadyState)





func _load_initial_attack_config() -> void:

	var equipment_slot = entity.inventory.weapon_slot

	if !equipment_slot.is_empty():

		var item_data = equipment_slot.item_data

		var item_def = item_data.get_item_def()

		current_attack_config = item_def.default_attack_config

		current_library_name = item_data.get_item_id()

	else:

		var entity_def = entity.get_entity_def()

		if entity_def.unarmed_attack_config:

			current_attack_config = entity_def.unarmed_attack_config

			current_library_name = "unarmed"






func _is_attacking() -> bool:

	return entity.state_machine.get_current_state() is CombatAttackingState



func _is_in_combat() -> bool:

	return entity.state_machine.get_current_state() is CombatState




func _is_attack_index_valid(index: int) -> bool:

	if !current_attack_config:

		return false

	return current_attack_config.attack_set.size() - 1 <= index






func _get_attack_animation_name() -> String:

	return "%s/attack_%s" % [current_library_name, current_attack_index]





func _handle_weapon_attack_input(pressed: bool) -> void:

	if pressed and !_is_attacking():

		_try_attack()




func _clear_attack_data() -> void:

	current_attack_config = null

	current_attack_dir = Vector2.ZERO

	current_attack_index = 0








func _on_weapon_attack_input_pressed() -> void:

	_handle_weapon_attack_input(true)



func _on_weapon_attack_input_released() -> void:

	_handle_weapon_attack_input(false)