class_name wall extends Base_State

const SPEED_MULTI = 1

const SLIDE_SPEED = 400
const FACTOR = 400

@export var raycast: ShapeCast2D


func enter(data: Variant = {}) -> void:
	super()
	CoolUtils.set_doable(char.specials, false)

	
func _physics_update(_delta:float) -> void:
	super(_delta)
	var dir = Input.get_axis("UpP1", "DownP1")
	char.velocity.y = move_toward(char.velocity.y, SLIDE_SPEED*dir, char.stats.acceleration*_delta)
	char.player.speed_scale = char.velocity.y/FACTOR
	
	if Input.is_action_just_pressed("JumpP1") and raycast.is_colliding():
		char.velocity.y = -char.stats.jump_height
		char.dir = sign(char.get_wall_normal().x)
		char.graphic.scale.x = sign(char.get_wall_normal().x)
		var wall_normal = char.get_wall_normal().x
		char.velocity.x = (wall_normal * char.stats.speed) * SPEED_MULTI
	if not raycast.is_colliding() or char.is_on_floor():
		raycast.enabled = false
		finished.emit("Idle")
		
func exit() -> void:
	CoolUtils.set_doable(char.specials, true)
	char.player.speed_scale = 1
	
