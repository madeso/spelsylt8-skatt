extends Area2D

onready var treasure_scene = preload("res://prefabs/Treasure.tscn")

var is_spawning = false
var spawn_timer = 0
var spawn_count = 15

const TIME_BETWEEN = 0.25
const DX = 50
const DY_LO = 50
const DY_HI = 80

func _ready():
	pass # Replace with function body.

func _process(dt):
	if not is_spawning:
		return
		
	if spawn_count <= 0:
		return
	
	spawn_timer -= dt
	if spawn_timer > 0:
		return
	
	spawn_timer += TIME_BETWEEN
	var treasure = treasure_scene.instance()
	treasure.set_position(position)
	treasure.dx = rand_range(-DX, DX)
	treasure.dy = rand_range(-DY_LO, -DY_HI)
	get_parent().add_child(treasure)
	SoundPlayer.play_spawn_treasure()
	spawn_count -= 1

func _on_Chest_body_entered(body):
	if body.name == "Player":
		if $Sprite.animation == "idle":
			if body.has_key:
				$Sprite.animation = "unlocked"
				SoundPlayer.play_open_chest()


func _on_Sprite_animation_finished():
	if $Sprite.animation == "unlocked":
		is_spawning = true
