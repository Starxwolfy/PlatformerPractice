class_name DamageNumber extends Label

@export var notifier: VisibleOnScreenNotifier2D

const fakeveldef = 1000
const grav = -2000
const rand = [-1000, 1000]

var vel: Vector2

var color: Color

func _ready() -> void:
	print('added')
	rotation = [-1, 1].pick_random()
	modulate = color
	vel.y = fakeveldef
	vel.x = randf_range(rand[0], rand[1])
	print(position)
	notifier.screen_exited.connect(queue_free)
	get_tree().create_timer(1.5).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	rotation = move_toward(rotation, 0, 2*delta)
	scale.x -= 1.0*delta
	scale.y += 2.0*delta
	vel.y += grav*delta
	position -= vel*delta
