extends Area2D


func _on_GoldCoin_body_entered(body):
	if body.name == "Player":
		queue_free()
		body.collect_coin()
