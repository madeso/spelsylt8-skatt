extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Instantiate
var noise = OpenSimplexNoise.new()
var timer = 0
var op

export var scale_factor = 10
export var scale_factor_x = 1.0
export var scale_factor_y = 1.0
export var inter_speed = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	op = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt):
	timer += dt * inter_speed
	var dx = noise.get_noise_1d(timer) * scale_factor_x
	var dy = noise.get_noise_2d(timer, timer) * scale_factor_y
	position = op + scale_factor * Vector2(dx, dy)
	
