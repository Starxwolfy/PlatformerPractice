class_name StatusEffect extends Node
enum TYPE {HELPING, HARMING}
const PATH = "res://PARTICLES/%s"
@export var who: BaseChar
@export var time: float
@export var type: TYPE
@export var intesnity: float
var particle: GPUParticles2D

func _ready() -> void:
	self.name = get_script().get_global_name()
	if ResourceLoader.exists(PATH % get_script().get_global_name() + ".tscn"):
		var lol: PackedScene = load("res://PARTICLES/%s.tscn" % get_script().get_global_name())
		particle = lol.instantiate()
		var parent = get_parent() as BaseChar
		particle.position = parent.graphic.offset if parent is not Player else Vector2.ZERO
		get_parent().add_child.call_deferred(particle)
	if who is Player:
		who.face.statuses.append(self)
		who.face.set_idle_based_off_status(str(get_script().get_global_name()).to_pascal_case())
		
func _process(delta: float) -> void:
	if time <= 0:
		queue_free()
	
	time -= 1*delta
		
func _exit_tree() -> void:
	if who is Player:
		who.face.statuses.erase(self)
		who.face.stop_idle_based_off_status()
	if particle:
		particle.queue_free()
