class_name CharacterButton extends TextureButton
const UNKNOWN = preload("res://Sprites/CharSelect/Characters/Unknown.png")

@export var character: String = "Kit"
var tween: Tween


func _ready() -> void:
	texture_normal = load("res://Sprites/CharSelect/TemplateButton.png")
	var tex:TextureRect = TextureRect.new()
	tex.use_parent_material = true
	if ResourceLoader.exists("res://Sprites/CharSelect/Characters/%s.png" % character):
		tex.texture = load("res://Sprites/CharSelect/Characters/%s.png" % character)
	else:
		tex.texture = UNKNOWN
	print(tex.texture)
	add_child(tex)
	tex.mouse_entered.connect(tweener.bind(1.2))
	tex.mouse_exited.connect(tweener.bind(1))
	pivot_offset = tex.size/2
	print(pivot_offset)

	
	
func tweener(val: float):
	if tween:
		tween.kill()
		
	tween = create_tween()
		
	tween.tween_property(self, "scale", Vector2(val, val), 0.25).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
