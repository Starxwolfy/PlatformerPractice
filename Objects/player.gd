class_name BaseChar extends CharacterBody2D

@export_category("Set Up")
@export var stats: Stats
@export var machine: statemachine
@export var dir: float
@export var fake_dir: float
@export var graphic: Sprite2D
@export var player: AnimationPlayer
@export var state: State
@export var is_running: bool
@export var health: HealthContainer
@export var armored: bool = false
@export var hrtbox: hurtbox
@export_category("Juicy Stuff")
@export var blood_color: Color = Color(1,0, 0, 1)
@export var full_flash: Array[float]
