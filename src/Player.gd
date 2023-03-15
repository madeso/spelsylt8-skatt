extends KinematicBody2D

const GRAVITY = 200
const MAX_VEL_DOWN = 300
const JUMP_POWER = 100

const RUN_SPEED = 80
const RUN_GROUND_ACC = 200
const RUN_AIR_ACC = 100
const GROUND_DEACC = 200
const AIR_DEACC = 25

var dx = 0
var dy = 0
var air_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt):
	dy = dy + GRAVITY * dt
	dy = min(dy, MAX_VEL_DOWN)
	
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
	
	if moved:
		var acc = RUN_AIR_ACC
		if air_timer < 0.1:
			acc = RUN_GROUND_ACC
		dx = clamp(dx + mx * dt * acc, -RUN_SPEED, RUN_SPEED)
		
	else:
		var last_sign = sign(dx)
		var deacc = AIR_DEACC
		if air_timer < 0.1:
			deacc = GROUND_DEACC
		dx -= sign(dx) * dt * deacc
		if sign(dx) != last_sign:
			dx = 0
	if move_and_collide(Vector2(dx * dt, 0)):
		dx = 0
		moved = false
	
	air_timer += dt
	if move_and_collide(Vector2(0, dy * dt)):
		dy = 0
		air_timer = 0
		
	# animate
	print(dx)
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
