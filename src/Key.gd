extends Area2D

onready var key_scene = preload("res://prefabs/KeyEffect.tscn")

func _on_Key_body_entered(body):
	if body.name == "Player":
		queue_free()
		var key = key_scene.instance()
		key.set_position(position)
		get_parent().add_child(key)
		body.collect_key()
