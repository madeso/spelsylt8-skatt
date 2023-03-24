extends Area2D

export(String, FILE, "*.tscn") var target_level_path = ""

func _on_NextScene_body_entered(body):
	if body.name != "Player": return
	get_tree().change_scene(target_level_path)
