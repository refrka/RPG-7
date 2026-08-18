class_name ItemSlot extends Resource


signal slot_updated


@export var item_data: ItemData
















func set_data(_item_data: ItemData) -> void:

	item_data = _item_data

	slot_updated.emit()

	




func is_empty() -> bool:

	if !item_data:

		return true

	return item_data.is_empty()



