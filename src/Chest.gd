extends Area2D

func _ready():
	pass # Replace with function body.

func _on_Chest_body_entered(body):
	if body.name == "Player":
		if $Sprite.animation == "idle":
			if body.has_key:
				$Sprite.animation = "unlocked"
