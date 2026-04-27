extends CharacterBody2D

@export var bala_enemigo: PackedScene
@export var velocidad_bala: float = 200.0 

var vida := 30
var timer := 0.0
@export var cooldown_enemigo : float= 2.0
@onready var notificador = $VisibleOnScreenNotifier2D
func _process(delta: float) -> void:
	timer += delta
	if timer >= cooldown_enemigo and bala_enemigo:
		timer = 0.0
		disparar()

func disparar() -> void:
	if not notificador.is_on_screen():return
	var jugador = get_tree().get_first_node_in_group("player")
	if not jugador: return 

	var bala = bala_enemigo.instantiate() 
	get_tree().current_scene.add_child(bala)       
	bala.global_position = global_position
	
	bala.velocidad = global_position.direction_to(jugador.global_position) * velocidad_bala
	
func tomar_daño(daño: int) -> void:
	vida -= daño
	get_tree().current_scene.restar_enemigo()
	if vida <= 0: queue_free()
