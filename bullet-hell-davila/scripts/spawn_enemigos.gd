extends Area2D

@export var escena_enemigo: PackedScene
@export var contenedor_puntos: Node2D 

func _on_spawntimer_timeout() -> void:
	if not escena_enemigo or not contenedor_puntos: 
		return

	var lista_puntos = contenedor_puntos.get_children()
	
	if lista_puntos.is_empty(): 
		return 
		
	var punto_elegido = lista_puntos.pick_random()

	var instancia_enemigo = escena_enemigo.instantiate()
	get_tree().current_scene.add_child(instancia_enemigo)	
	
	instancia_enemigo.global_position = punto_elegido.global_position
