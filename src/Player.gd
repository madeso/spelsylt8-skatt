extends KinematicBody2D

const GRAVITY = 200
const MIN_VELY = 300
const RUN_SPEED = 50
const JUMP_POWER = 100

var dy = 0
var air_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt):
	dy = dy + GRAVITY * dt
	dy = min(dy, MIN_VELY)
	
	if Input.is_action_just_pressed("ui_up"):
		dy = -JUMP_POWER
	
	var mx = 0
	var moved = false
	if Input.is_action_pressed("ui_left"):
		mx = -1
		moved = true
		$Sprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
		mx = 1
		moved = true
		$Sprite.flip_h = false
	
	var dx = mx * dt * RUN_SPEED
	if move_and_collide(Vector2(dx, 0)):
		dx = 0
		moved = false
	
	air_timer += dt
	if move_and_collide(Vector2(0, dy * dt)):
		dy = 0
		air_timer = 0
		
	# animate
	print(dy)
	if air_timer < 0.1:
		if moved:
			$Sprite.animation = "run"
		else:
			$Sprite.animation = "idle"
	else:
		if dy > 0:
			$Sprite.animation = "fall"
		else:
			$Sprite.animation = "jump"
