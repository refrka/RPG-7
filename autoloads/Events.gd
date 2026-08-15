extends Node




var subscriptions: Dictionary[Script, Array] = {}





func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS




func subscribe(event_script: Script, callback: Callable) -> void:

	if !subscriptions.has(event_script):

		subscriptions[event_script] = []

	subscriptions[event_script].append(callback)







func fire(event_script: Script, _data:= {}) -> void:

	if !subscriptions.has(event_script):

		return

	var event = event_script.new()

	event.fire(_data)

	for callback in subscriptions[event_script]:

		callback.call(event)