extends CharacterBody2D

@export var bala_enemigo_basico: PackedScene
var vida := 30
var timer := 0.0

func _process(delta: float) -> void:
	timer += delta
	if timer >= 2.0 and bala_enemigo_basico:
		timer = 0.0
		disparar()

func disparar() -> void:
	var jugador = get_tree().get_first_node_in_group("player")
	if not jugador: return 

	var bala = bala_enemigo_basico.instantiate() 
	get_tree().current_scene.add_child(bala)       
	bala.global_position = global_position
	bala.velocidad = global_position.direction_to(jugador.global_position) * 200

func tomar_daño(daño: int) -> void:
	vida -= daño
	if vida <= 0: queue_free()
