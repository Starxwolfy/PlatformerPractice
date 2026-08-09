class_name Base_State extends State

const ROTSPEED = 5

var char: Player
@export var animation: String

func enter(data: Variant = {}) -> void:
	char.state = self
		
	char.player.play(animation)

func _ready() -> void:

	char = owner as Player
	char.graphic = char.find_child("Graphic")
		
func _handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("JumpP1") and char.is_on_floor():
		char.velocity.y = -char.stats.jump_height
		char.jump_buffer.start()
	if event.is_action_pressed("Run"):
		char.is_running = !char.is_running

		
func _update(delta: float) -> void:
	if str(char.machine.get_state()) != "Dead" and char.health.health <= 0:
		finished.emit("Dead")
func _physics_update(_delta:float) -> void:
	char.dir = Input.get_axis("LeftP1", "RightP1")
	if char.is_on_floor():
		char.graphic.rotation = move_toward(char.graphic.rotation, char.get_floor_normal().angle() + (PI/2), ROTSPEED*_delta)
	else:
		char.graphic.rotation = move_toward(char.graphic.rotation, 0, ROTSPEED*_delta)
	char.move_and_slide()
	
		
	
	
