class_name Dead extends Base_State

const fakeveldef = 1000
const grav = 2000
const rand = [-1000, 1000]
@export var OG_pos: Vector2
@export var kill_noise: AudioStreamPlayer2D
@export var face: Dictionary[int, int]

var vel: Vector2

func _handle_input(event: InputEvent) -> void:
	pass

func enter(data: Variant = {}) -> void:
	if char.face:
		char.face._change_idle_face(face, "dude's dead lmao", true)
	CoolUtils.set_doable(char.specials, false)
	char.velocity = Vector2.ZERO
	vel.y = fakeveldef
	vel.x = rand.pick_random()
	kill_noise.play()
	super()
func _physics_update(_delta:float) -> void:
	vel.y -= grav*_delta
	char.graphic.position -= vel*_delta

	
func exit() -> void:
	char.graphic.position = OG_pos
	char.rotation_degrees = 0
