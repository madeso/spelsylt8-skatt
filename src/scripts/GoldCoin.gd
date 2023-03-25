extends Area2D

onready var coin_scene = preload("res://prefabs/CoinEffect.tscn")

func _ready():
	$Sprite.frame = randi() % 4

func _on_GoldCoin_body_entered(body):
	if body.name == "Player":
		queue_free()
		var coin = coin_scene.instance()
		coin.set_position(position)
		get_parent().add_child(coin)
		body.collect_coin()
