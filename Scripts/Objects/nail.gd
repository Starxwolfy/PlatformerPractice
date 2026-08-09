class_name Nail extends Sprite2D

const HITSOUND = preload("res://Sound/SFX/snd_damage.wav") #I LOVE DELTARUNE

@export var stats: HitboxData
@export var damagecol: Area2D
@export var aimer: Area2D
@export var actual_visual: Sprite2D
@export var delte: Timer
@export var coolness_add:float
@export var speed: Vector2

var player_who_called:Player
var dir: int
var velocity: Vector2
var character_to_hit: CharacterBody2D
var steer_force: float = 50


func _ready() -> void:
	aimer.body_entered.connect(_FOUND_YOU)
	damagecol.area_entered.connect(_HURT_YOU)
	damagecol.body_entered.connect(DELETE)
	delte.timeout.connect(BYE)
	delte.start()
	
func move_and_slide(delta:float) -> void:
	position += velocity*delta
	
func _physics_process(delta: float) -> void:

	print(velocity)
	if character_to_hit != null:
		look_at(character_to_hit.global_position)
		actual_visual.position = CoolUtils.shake(10, true, true)
		
		position = position.move_toward(character_to_hit.global_position, (speed.x*5)*delta)
	else:
		position += (speed * dir)*delta
	
func _FOUND_YOU(body):
	character_to_hit = body
	print(character_to_hit)
	
func _HURT_YOU(area: hurtbox):
	if area is hurtbox:
		var hitsoun:HitSound = HitSound.new()
		hitsoun.stream = HITSOUND
		area.add_child(hitsoun)
		area.deal_damage(stats, player_who_called.coolness.coolnesspercent, null)
		player_who_called.coolness.coolnesspercent += coolness_add
		queue_free()
	
func BYE():
	queue_free()
	
func DELETE(body):
	if body is not BaseChar:
		queue_free()
