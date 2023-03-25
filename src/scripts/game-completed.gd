extends Node2D

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		get_tree().change_scene("res://levels/Level-0.tscn")
