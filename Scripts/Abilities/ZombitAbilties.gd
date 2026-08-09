class_name ZombitTheCatZombie extends SpecialAbility
const MEOW_FACE = {
	0:2,
	1:1,
}

@export var custom_area: ZombitChew
@export var cooldown: Timer
@export var max_jabs: int
@export var face: FaceHandler
@export var random_sounds: Array[AudioStream]
@export var meow_cooldown: Timer
var attacking: bool = true
var jabs: int = 0
var can_meow: bool = true

func _ready() -> void:
	cooldown.timeout.connect(hi)
	meow_cooldown.timeout.connect(mow)

		
func input(event: InputEvent) -> void:
	if Input.is_action_pressed("DashP1") and attacking:
		custom_anim.play("Chewing")
		cooldown.start(4)
		attacking = false
	if Input.is_action_pressed("Attack") and attacking:
		jabs += 1
		if jabs > max_jabs:
			jabs = 1
		custom_anim.play("Scratch %d" % jabs)
		cooldown.start(0.4)
		attacking = false
	if Input.is_key_pressed(KEY_M) and can_meow:
		can_meow = false
		if me.find_child("meow"):
			print("meow")
			return
		face._apply_temporary_face(MEOW_FACE, 0.5, 1)
		var hitsound = HitSound.new()
		hitsound.stream = random_sounds.pick_random()
		hitsound.name = "meow"
		me.add_child(hitsound)
		meow_cooldown.start()
		

	
func hi():
	attacking = true
func mow():
	can_meow = true
	
		
		
