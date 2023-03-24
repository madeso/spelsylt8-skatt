extends KinematicBody2D

const GRAVITY = 300
const MAX_VEL_DOWN = 300
const JUMP_POWER = 100
const JUMP_TIMER = 0.35
const JUMP_BUFFER = 0.25

const WALL_JUMP_HOR = 50
const WALL_JUMP_POWER = 150

const RUN_SPEED = 80
const RUN_GROUND_ACC = 250
const RUN_AIR_ACC = 100
const GROUND_DEACC = 250
const AIR_DEACC = 25
const WALK_TIMER = 0.20

var dx = 0
var dy = 0
var air_timer = 0
var jump_timer = -1
var jump_buffer = -1
var wall_timer = 0
var alive = true
var death_timer = 0
var has_key = false
var walk_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func collect_coin():
	print("got some coin")
	SoundPlayer.play_coin()

func collect_treasure():
	SoundPlayer.play_treasure()

func collect_key():
	has_key = true
	print("got some key")
	SoundPlayer.play_collect_key()

func kill():
	if alive:
		print("player was killed by danger")
		alive = false
		dy = -JUMP_POWER * 1.25
		air_timer = 1
		SoundPlayer.play_die()

func update_dead(dt):
	death_timer += dt
	dy = dy + GRAVITY * dt
	dy = min(dy, MAX_VEL_DOWN)
	air_timer += dt
	if move_and_collide(Vector2(0, dy * dt)):
		dy = 0
		air_timer = 0
		
	if death_timer > 0.25:
		death_timer = 11
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()
			
	
	if air_timer < 0.1:
		change_animation("dead_ground")
	else:
		change_animation("dead_hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt):
	if alive == false:
		update_dead(dt)
		return
	# ---------------------------------------------------------------------------------------------
	# horizontal movmeent
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
		
		if air_timer < 0.1:
			walk_timer += dt
			if walk_timer > WALK_TIMER:
				walk_timer -= WALK_TIMER
				SoundPlayer.play_walk()
	else:
		var last_sign = sign(dx)
		var deacc = AIR_DEACC
		if air_timer < 0.1:
			deacc = GROUND_DEACC
		dx -= sign(dx) * dt * deacc
		if sign(dx) != last_sign:
			dx = 0
	if wall_timer < 10:
		wall_timer += dt
	if move_and_collide(Vector2(dx * dt, 0)):
		dx = 0
		moved = false
		wall_timer = 0
	
	
	# ---------------------------------------------------------------------------------------------
	# vertical movment
	dy = dy + GRAVITY * dt
	dy = min(dy, MAX_VEL_DOWN)
	
	if jump_buffer >= 0:
		jump_buffer -= dt
	
	if Input.is_action_just_pressed("ui_up"):
		jump_buffer = JUMP_BUFFER
	
	if jump_buffer > 0:
		if air_timer < 0.1:
			jump_timer = JUMP_TIMER
			dy = -JUMP_POWER
			jump_buffer = -1
			SoundPlayer.play_jump()
		elif wall_timer < 0.1 and moved:
			# wall jump
			wall_timer = 10.0
			jump_timer = 0
			dx = -WALL_JUMP_HOR * mx
			dy = -WALL_JUMP_POWER
			jump_buffer = -1
			SoundPlayer.play_walljump()
	
	if Input.is_action_pressed("ui_up") and jump_timer > 0.0:
		dy = -JUMP_POWER
		jump_timer -= dt
	else:
		jump_timer = -1
	
	
	air_timer += dt
	if move_and_collide(Vector2(0, dy * dt)):
		if dy > 200:
			SoundPlayer.play_hardland()
		elif dy > 50:
			SoundPlayer.play_land()
		dy = 0
		air_timer = 0
		
	# ---------------------------------------------------------------------------------------------
	# animate
	# print(jump_buffer)
	# print(dx)
	if air_timer < 0.1:
		if abs(dx) > 6:
			change_animation("run")
		else:
			change_animation("idle")
	else:
		if dy > 0:
			change_animation("fall")
		else:
			change_animation("jump")

func change_animation(name):
	# if $Sprite.animation != name:
	# 	print("changing animation to ", name)
	$Sprite.animation = name
