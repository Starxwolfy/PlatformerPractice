class_name AutoAdjustSprite2D extends Sprite2D

enum ANCHORS {BOTTOM, TOP}

@export var anchor: ANCHORS = ANCHORS.BOTTOM


func _ready() -> void:
	item_rect_changed.connect(adjust)
	
	
func adjust():
	match anchor:
		ANCHORS.BOTTOM:
			offset.y = CoolUtils.get_bottom_offset(self)
		ANCHORS.TOP:
			offset.y = CoolUtils.get_top_offset(self)
		
