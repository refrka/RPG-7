class_name CombatComponent extends Component




@export var combat_root: Node2D

var combat_hitbox: Hitbox

var movement_component: MovementComponent


var current_attack_config: AttackConfig

var current_attack_dir: Vector2

var current_attack_index:= 0

var current_library_name: String

var current_animation_name: String




var buffered:= false

var buffer_enabled:= false




var attack_animation_node: AnimationNodeAnimation





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	combat_hitbox = entity.combat_hitbox

	movement_component = entity.get_component(MovementComponent)

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.weapon_attack_pressed.connect(_on_weapon_attack_input_pressed)

		input_component.weapon_attack_released.connect(_on_weapon_attack_input_released)

	var animation_component = entity.get_component(AnimationComponent)

	attack_animation_node = animation_component.get_attack_animation_node()

	_load_initial_attack_config()







func reset() -> void:

	_clear_attack_data()





func enable_buffer() -> void:

	buffer_enabled = true



func disable_buffer() -> void:

	buffer_enabled = false





func receive_damage_package(_damage_package: DamagePackage) -> void:

	if _is_attacking():

		_interrupt_attack()





func get_attack_entry(index:= -1) -> AttackEntry:

	if index == -1:

		index = current_attack_index

	if _is_attack_index_valid(index):

		return current_attack_config.attack_set[index]

	return null










func _try_attack() -> void:

	if !_is_in_combat():

		_enter_combat()

	if _is_attack_index_valid(current_attack_index):

		_start_attack()





func _start_attack() -> void:

	current_animation_name = _get_attack_animation_name()

	attack_animation_node.animation = current_animation_name

	_set_attack_dir()

	_execute_attack()




func _start_charge() -> void:

	pass



func _cancel_charge() -> void:

	pass



func _complete_charge() -> void:

	pass




func _execute_attack() -> void:

	entity.state_machine.request_state(CombatAttackingState)





func _finish_attack() -> void:

	buffer_enabled = false

	combat_hitbox.clear_hit_list()

	if buffered:

		buffered = false

		current_attack_index += 1

		_try_attack.call_deferred()

		return

	current_attack_index = 0

	current_animation_name = ""

	current_attack_dir = Vector2.ZERO

	entity.state_machine.request_state(CombatReadyState)




func _interrupt_attack() -> void:

	pass





func _enter_combat() -> void:

	entity.state_machine.request_state(CombatReadyState)





func _deliver_hit(target_entity: EntityNode) -> void:

	target_entity.receive_damage_package(_get_damage_package())






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

	var num_attack_entries = current_attack_config.attack_set.size()

	if index + 1 > num_attack_entries:

		return false

	return true






func _get_attack_animation_name() -> String:

	return "%s/attack_%s" % [current_library_name, current_attack_index]



func _get_damage_package() -> DamagePackage:

	var attack_entry = get_attack_entry()

	var damage_package = DamagePackage.from_attack_entry(attack_entry)

	return damage_package



func _set_attack_dir() -> void:

	current_attack_dir = Game.get_mouse_direction()

	combat_root.rotation = current_attack_dir.angle()

	print("setting attack dir: ", current_attack_dir)

	movement_component.set_face_dir(current_attack_dir)

	





func _handle_weapon_attack_input(pressed: bool) -> void:

	if pressed:

		if !_is_attacking():

			_try_attack()

		elif buffer_enabled:

			var buffered_index = current_attack_index + 1

			if _is_attack_index_valid(buffered_index):

				buffered = true




func _clear_attack_data() -> void:

	current_attack_config = null

	current_attack_dir = Vector2.ZERO

	current_attack_index = 0








func _on_weapon_attack_input_pressed() -> void:

	_handle_weapon_attack_input(true)



func _on_weapon_attack_input_released() -> void:

	_handle_weapon_attack_input(false)




func _on_hit_detected(hit_entity: EntityNode) -> void:

	_deliver_hit(hit_entity)









func _activate() -> void:

	super()

	if combat_hitbox:
		
		combat_hitbox.hit_detected.connect(_on_hit_detected)




func _deactivate() -> void:

	super()

	if combat_hitbox:

		combat_hitbox.hit_detected.disconnect(_on_hit_detected)