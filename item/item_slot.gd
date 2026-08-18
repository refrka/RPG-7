class_name ItemSlot extends Resource


@export var item_data: ItemData

















func is_empty() -> bool:

	if !item_data:

		return true

	return item_data.is_empty()



