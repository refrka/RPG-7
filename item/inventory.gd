class_name Inventory extends Resource




@export var slots: Array[ItemSlot]

@export var size:= 9



@export var weapon_slot: EquipmentSlot






func initialize() -> void:

	if !weapon_slot:

		weapon_slot = EquipmentSlot.new()

	_resize()




func equip_weapon(weapon_data: WeaponData) -> void:

	weapon_slot.set_data(weapon_data)




func _resize() -> void:

	while slots.size() > size:

		slots.pop_back()

	while slots.size() < size:

		slots.append(ItemSlot.new())