extends Area3D
@export var next_level: String = "res://scenes/Level2.tscn"

func _on_body_entered(body):
	if body == GameManager.current_character:
		get_tree().change_scene_to_file(next_level)
