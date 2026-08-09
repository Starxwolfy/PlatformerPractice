class_name KitTheCat extends SpecialAbility
const PROJECTILE = preload("res://Objects/Nail.tscn")
@export var cooldown: Timer
@export var kick_cooldown: Timer

var can_shoot = true
var can_kick = true

func _ready() -> void:
	cooldown.timeout.connect(ok)
	kick_cooldown.timeout.connect(kicker)
	custom_anim.animation_finished.connect(stopper)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("DashP1") and can_kick:
		can_kick = false
		custom_anim.play("Kick")
		kick_cooldown.start(3)
		


func _process(delta: float) -> void:
	super(delta)
	if Input.is_action_pressed("Attack") and can_shoot:
		var init = PROJECTILE.instantiate()
		var proj = init as Nail
		proj.player_who_called = owner as Player
		proj.dir = owner.graphic.scale.x
		proj.position = owner.position
		owner.get_parent().add_child(proj)
		can_shoot = false
		cooldown.start(0.1)
	
func ok():
	can_shoot = true
	
func kicker():
	can_kick = true
	
func stopper(anim):
	custom_anim.stop()
	
