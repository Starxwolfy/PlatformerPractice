class_name hurtbox extends Area2D

@export_category("Set Up")
@export var health: HealthContainer
@export var character: BaseChar
@export var original_scale: Vector2
@export_category("Damage Stuff")
@export var color: Color
@export var flash_color: Color
@export_category("Important Stuff")
@export var og_pos: Vector2
var mat: ShaderMaterial
var tween: Tween
var cur_shake: float = 0.0

func _ready() -> void:
	character.material = character.material.duplicate()
	mat = character.material
	print(mat)

func deal_damage(stats: HitboxData, percentage: float = 0, whohit: Node2D = null):
	if stats.shakes:
		cur_shake = clamp(stats.dmg, 0, stats.shake)
	if stats.show_number:
		CoolUtils.display_damage((stats.dmg*CoolUtils.calculate_multi(percentage)), character, color)
	if stats.hitsound:
		CoolUtils.create_hitsound(stats.hitsound, character)
	health.change_health(stats.dmg, "Subtract", true)
	if character.armored:
		pass
	else:
		if stats.stuns:
			character.state.finished.emit("Stun", stats.stun_timer)
		if stats.knockback != Vector2.ZERO:
			if whohit == null:
				character.velocity = stats.knockback
			else:
				print(CoolUtils.calculate_knockback(character, whohit, stats.knockback))
				character.velocity = CoolUtils.calculate_knockback(character, whohit, stats.knockback)
	CoolUtils.hitpause(stats.hitpause)
	CoolUtils.flash(character.full_flash, flash_color, mat, tween)
	
func _process(delta: float) -> void:
	if cur_shake > 0 and character.machine.get_state() != "Dead":
		character.graphic.position = og_pos + CoolUtils.shake(cur_shake, true, true)
		cur_shake = move_toward(cur_shake, 0, (10+cur_shake)*delta)
