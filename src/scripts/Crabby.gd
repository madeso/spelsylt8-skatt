extends KinematicBody2D


var dx = 1
var state = "walk"
var timer = 10

const SPEED = 30

func set_timer():
	timer = rand_range(2, 10)

func _ready():
	set_timer()


func _process(dt):
	move_and_collide(Vector2(0, 10 * dt))
	
	timer -= dt
	
	var switch_state = false
	if timer < 0:
		set_timer()
		switch_state = true
	
	if state == "walk":
		$Sprite.animation = "run"
		$Sprite.flip_h = dx > 0
		if move_and_collide(Vector2(dx * SPEED * dt, 0)):
			dx = dx * -1
		if switch_state:
			state = "idle"
	elif state == "idle":
		$Sprite.animation = "idle"
		if switch_state:
			state = "walk"
			

func _on_HurtBox_body_entered(body):
	if body.name == "Player":
		body.kill()
