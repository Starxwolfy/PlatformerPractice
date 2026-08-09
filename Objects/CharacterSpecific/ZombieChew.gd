class_name ZombitChew extends Area2D
@export var me: Player
@export var stats: HitboxData
var healovertime: float = 0
func check():
	if has_overlapping_areas():
		var hitter = get_overlapping_areas()
		var first = hitter[0] as hurtbox
		if first is hurtbox:
			regen()
			bleed(first)
			spawn_chew()
			first.deal_damage(stats, me.coolness.coolnesspercent, me)
			me.coolness.coolnesspercent += 0.25
		

func regen():
	CoolUtils.apply_status("Regeneration", 5, 1, me)
func bleed(character: hurtbox):
	if character is hurtbox:
		CoolUtils.apply_status("Bleeding", 5, 1, character.character)
	
func spawn_chew():
	if has_overlapping_areas():
		var hit = HitSound.new()
		hit.stream = load("res://Sound/SFX/chomp-1.mp3")
		me.add_child(hit)

		
		

		
		
		
