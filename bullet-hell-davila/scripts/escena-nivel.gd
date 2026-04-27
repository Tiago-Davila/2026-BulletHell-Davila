extends Node2D
var enemigos_restantes: int = 0

func _ready() -> void:
	enemigos_restantes = get_tree().get_nodes_in_group("enemigos").size()
	
	
func restar_enemigo() -> void:
	enemigos_restantes -= 1
	print("Faltan: ", enemigos_restantes)
	if enemigos_restantes <= 0:
		get_tree().change_scene_to_file("res://escenas/nivel-2.tscn")


	
