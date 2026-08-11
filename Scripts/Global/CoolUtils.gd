extends Node


var _tweener: Tween




#region Functions


func parse_json(json: Variant) -> Variant:
	var jsoner: JSON = JSON.new()
	var returner = JSON.stringify(json.data)
	var data: Error = jsoner.parse(returner)
	if data != OK:
		CoolUtils.handle_error(data)
	return jsoner.data
	
func parse_settings(json: Variant) -> Variant:
	var jsoner: JSON = JSON.new()
	var data: Error = jsoner.parse(json)
	if data != OK:
		CoolUtils.handle_error(data)
	return jsoner.data
	
func apply_movement(delta:float, char: BaseChar):
	var move = ((char.stats.speed + (char.stats.run_bonus if char.is_running else 0.0))*char.dir) if char.dir != 0 else 0.0 
	char.velocity.x = move_toward(char.velocity.x, move, (char.stats.acceleration * (2 if char.is_running else 1))*delta)
	if char.dir != 0:
		char.graphic.scale.x = sign(char.dir)
		
func get_closest_value(val: float, dict: Dictionary) -> Variant:
	if dict.is_empty():
		return null
	var closest_key: Variant = null
	var min_difference: float = INF
	for key in dict.keys():
		if not (key is int or key is float):
			continue
		var difference: float = abs(key - val)
		if difference < min_difference:
			min_difference = difference
			closest_key = key
	return dict[closest_key]
	
func sine_wave(num: float, time: float, amp: float, speed: float):
	return num + sin(time*speed)*amp
	
			
func gravity(delta:float, char:BaseChar):
	if not char.is_on_floor():
		char.velocity.y += char.get_gravity().y * delta
	
	
func set_doable(special: SpecialAbility, value: bool):
	special.is_doable = value
	if special.custom_anim.is_playing():
		special.stop()
		
func create_hitsound(sound: AudioStream, caller: Node2D):
	var hitsound: HitSound = HitSound.new()
	hitsound.stream = sound
	caller.add_child(hitsound)

func get_dominant_color(tex: Texture2D) -> Color:
	#NOTE: the CPU is doing too much, anyone who works on this please DO NOT CALL this every frame
	var count_by_color: Dictionary= {}
	
	var image = tex.get_image()
	var size: Vector2i = image.get_size()
	for y in range(size.y):
		for x in range(size.x):
			var c = image.get_pixel(x, y)
			if c.a > 0.5:
				c = Color(c)
				var key = Color.from_rgba8(c.r8, c.g8, c.b8, c.a8)
				count_by_color[key] = count_by_color.get(key, 0) + 1
				
	var max_count = 0
	var max_key:Color
	for color in count_by_color.keys():
		var count = count_by_color[color]
		if count >= max_count:
			max_count = count_by_color[color]
			max_key = color
	count_by_color = {}
	print(max_key)
	return max_key
	
func calculate_multi(percentage:float) -> float:
	return 1.0 + (percentage/100.0)

		
func calculate_knockback(me: Node2D, other: Node2D, knockback:Vector2):
	var hit_dir: float = sign(other.global_position.x - me.global_position.x)
	var final_knockback = Vector2(knockback.x * hit_dir, knockback.y)
	return final_knockback

func get_bottom_offset(sprite: Sprite2D) -> float: #TODO: must pass the enum instead of having two global functions
	return -sprite.get_rect().size.y / 2
	
func get_top_offset(sprite: Sprite2D) -> float: 
	return sprite.get_rect().size.y / 2
	
func play_anim_name(player: AnimationPlayer, anim: String):
	player.play(anim)
	player.seek(0)
	player.speed_scale = 1.0
	
func calculate_time(sec) -> String:
	var mili = fmod(sec, 1)*100
	var seconds = fmod(sec, 60)
	var minutes = fmod(sec/60, 60)
	var hours = sec/3600

	var str = "%1d:%02d:%02d.%02d" % [hours, minutes, seconds, mili]
	return str

func display_damage(damage: float, character: BaseChar, color: Color):
	print("called")
	var dmgnum = load("res://Objects/DamageNumber.tscn").instantiate() as DamageNumber
	dmgnum.text = str(int(damage))
	dmgnum.color = color
	dmgnum.position = character.position
	character.get_parent().add_child(dmgnum)
	
func flash(array: Array, color: Color, mat: ShaderMaterial, tween: Tween):
	if not Settings.saved_values["Shaders"]:
		return
	if tween:
		tween.kill()
	mat.set_shader_parameter("flash_color", color)
	tween = create_tween()
	for p in array:
		tween.tween_callback(func(): mat.set_shader_parameter("intens", p))
		tween.tween_interval(0.1)
		
func handle_error(error: Variant): 
	Err.err = error
	get_tree().change_scene_to_file("res://Scenes/ERROR.tscn")
		
func apply_status(status_name:String, timesec:float, intesnity: float, character: BaseChar): #not ideal, but we ball
	if character.has_node(status_name):
		var status: StatusEffect = character.get_node(status_name)
		status.time = timesec
		status.intesnity += intesnity
	else:
		var script = load("res://Objects/Status Effects/Statuses/%s.gd" % status_name)
		var status: StatusEffect = script.new()
		status.time = timesec
		status.intesnity = intesnity
		status.who = character
		character.add_child(status)
		
	
	
func shake(currentshake:float, x:bool, y:bool) -> Vector2:
	return Vector2(randf_range(-currentshake, currentshake) * float(x), randf_range(-currentshake, currentshake) * float(y))
	
var pause_active:bool = false
func hitpause(h: int):
	if pause_active: 
		return
	get_tree().paused = true
	pause_active = true
	await get_tree().create_timer(h/60.0, true).timeout
	pause_active = false
	get_tree().paused = false
#endregion
