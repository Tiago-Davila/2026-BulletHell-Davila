extends Node2D

@export var escena: PackedScene

func _on_timer_timeout() -> void:
	if not escena: return
	
	var puntos_posibles = []
	
	for hijo in get_children():
		if hijo is Marker2D:
			puntos_posibles.append(hijo)
			
	if puntos_posibles.size() > 0:
		var punto_elegido = puntos_posibles.pick_random()
		
		var spawn = escena.instantiate()
		get_tree().current_scene.add_child(spawn)
		spawn.global_position = punto_elegido.global_position
