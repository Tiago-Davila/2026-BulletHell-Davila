extends Button
@export var escena: String

func _on_pressed() -> void:
	get_tree().change_scene_to_file(escena) # Replace with function body.
