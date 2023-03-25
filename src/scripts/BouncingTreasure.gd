extends KinematicBody2D


var dx = 0
var dy = 0

func rand_sign():
	if randf() > 0.5:
		return 1
	else:
		return -1

func _ready():
	var treasures = ["red", "blue", "green", "coin", "silver"]
	$Sprite.animation = treasures[randi() % treasures.size()]
	dx = rand_range(30, 100) * rand_sign()
	dy = rand_range(60, 100) * rand_sign()


func _process(dt):
	dy += dt * 100
	
	if move_and_collide(Vector2(0, dy*dt)):
		dy *= -1
			
	if move_and_collide(Vector2(dx*dt, 0)):
		dx *= -1
