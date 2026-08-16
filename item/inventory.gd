class_name Inventory extends Resource




@export var slots: Array[InventorySlot]

@export var size:= 9



@export var weapon_slot: EquipmentSlot






func initialize() -> void:

	if !weapon_slot:

		weapon_slot = EquipmentSlot.new()

	_resize()




func _resize() -> void:

	while slots.size() > size:

		slots.pop_back()

	while slots.size() < size:

		slots.append(InventorySlot.new())