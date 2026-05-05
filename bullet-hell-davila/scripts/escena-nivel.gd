extends Node2D

@export var escena_siguiente_nivel: PackedScene

var enemigos_restantes: int = 0

func sumar_enemigo() -> void:
	enemigos_restantes += 1

func restar_enemigo() -> void:
	enemigos_restantes -= 1
	print(enemigos_restantes)
	if enemigos_restantes <= 0:
		pasar_de_nivel()

func pasar_de_nivel() -> void:
	get_tree().change_scene_to_packed(escena_siguiente_nivel)


	
