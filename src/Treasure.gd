extends KinematicBody2D

onready var treasure_effect = preload("res://prefabs/TreasureEffect.tscn")

var dx = 0
var dy = 0

const FRAC_Y = 0.6
const FRAC_X = 0.8
const LIM = 8

func _ready():
	var treasures = ["red", "blue", "green"]
	$Sprite.animation = treasures[randi() % treasures.size()]


func _process(dt):
	dy += dt * 100
	
	if move_and_collide(Vector2(0, dy*dt)):
		if abs(dy) > LIM:
			dy *= -FRAC_Y
			dx *= FRAC_X
		else:
			dy = 0
	if move_and_collide(Vector2(dx*dt, 0)):
		dx *= -FRAC_X


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		queue_free()
		var effect = treasure_effect.instance()
		effect.set_position(position)
		get_parent().add_child(effect)
		body.collect_coin()
