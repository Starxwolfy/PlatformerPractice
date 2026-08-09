class_name Enemy_Dead extends BaseEnemyState

@export var area: Area2D
@export var kill_noise: AudioStreamPlayer2D
@export var notifier: VisibleOnScreenNotifier2D

const fakeveldef = 1000
const grav = -2000
const rand = [-1000, 1000]

var vel: Vector2

	
func enter(data: Variant = {}) -> void:
	super()
	notifier.screen_exited.connect(implode)
	actor.velocity = Vector2.ZERO
	vel.y = fakeveldef
	vel.x = rand.pick_random()
	kill_noise.play()
	area.monitorable = false
		
func _update(delta: float) -> void:
	pass
func _physics_update(_delta:float) -> void:
	vel.y += grav*_delta
	actor.graphic.position -= vel*_delta
	if not notifier.is_on_screen():
		actor.queue_free()
		
func implode():
	actor.queue_free()
	
		
	
	
