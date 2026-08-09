class_name ErrorString extends RichTextLabel

@export var errorstrings: Dictionary = {}

func _ready() -> void:
	text = errorstrings.get(Err.err, "what is there to show?")
	await item_rect_changed
	pivot_offset.x = size.x / 2
