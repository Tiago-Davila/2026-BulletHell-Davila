extends Button
@export var escena: PackedScene

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(escena)
