class_name KillStreakComponent extends Node

signal kill_changed(ks:int)

var kill_streak: int:
		set(val):
			kill_changed.emit(val)
		
