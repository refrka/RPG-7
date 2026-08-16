class_name ItemData extends Resource


signal updated


@export var item_def: ItemDef

@export var count:= 0






func set_data(_item_def: ItemDef, _count: int) -> void:

	item_def = _item_def

	count = _count

	updated.emit()




## Returns the amount unable to be added
func add_amount(amount: int) -> int:

	var remaining = get_remaining_space()

	var new_count = count

	if amount <= remaining:

		new_count += amount

		set_data(item_def, new_count)

		return 0

	else:

		new_count += remaining

		set_data(item_def, new_count)

		return amount - remaining




## Returns the amount unable to be removed
func remove_amount(amount: int) -> int:

	if amount <= count:

		var new_count = count - amount

		set_data(item_def, new_count)

		return 0

	else:

		set_data(item_def, 0)

		return amount - count





func get_remaining_space() -> int:

	var max_stack = item_def.max_stack

	return max_stack - count





func get_item_def() -> ItemDef:

	return item_def


func get_item_id() -> StringName:

	return item_def.item_id


func get_display_name() -> StringName:

	return item_def.display_name






func is_empty() -> bool:

	return count == 0 or !item_def