extends CharacterBody2D

@export var bala_enemigo: PackedScene
@export var velocidad_bala: float = 200.0
@export var tiempo_disparo: float = 2.0

var vida := 30
var timer := 0.0

@onready var canones = $canones 

func _process(delta: float) -> void:
	timer += delta
	if timer >= tiempo_disparo and bala_enemigo:
		timer = 0.0
		disparar()

func disparar() -> void:
	var jugador = get_tree().get_first_node_in_group("player")
	if not jugador: return 
	canones.look_at(jugador.global_position)
	
	for canon in canones.get_children():
		var bala = bala_enemigo.instantiate() 
		get_tree().current_scene.add_child(bala)       
		bala.global_position = canon.global_position
		bala.velocidad = Vector2.RIGHT.rotated(canon.global_rotation) * velocidad_bala

func tomar_daño(daño: int) -> void:
	vida -= daño
	if vida <= 0: queue_free()
