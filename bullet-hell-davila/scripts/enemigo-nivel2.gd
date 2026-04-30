extends CharacterBody2D

@export var bala_enemigo: PackedScene
@export var velocidad_bala: float = 200.0
@export var cooldown_enemigo: float = 2.0

var tiempo_movimiento: float = 0.0
var direccion_actual: Vector2 = Vector2.ZERO
var velocidad: float = 50.0
var vida: int = 30
var timer: float = 0.0

@onready var notificador = $VisibleOnScreenNotifier2D

func _physics_process(delta: float) -> void:
	timer += delta
	tiempo_movimiento -= delta
	
	if timer >= cooldown_enemigo and bala_enemigo:
		timer = 0.0
		disparar()
		
	if tiempo_movimiento <= 0:
		cambiar_direccion()
		
	velocity = direccion_actual * velocidad
	move_and_slide()

func cambiar_direccion() -> void:
	var movimiento_x = randf_range(-1.0, 1.0)
	var movimiento_y = randf_range(-0.5, 0.5)
	
	direccion_actual = Vector2(movimiento_x, movimiento_y).normalized()
	tiempo_movimiento = 2.0

func disparar() -> void:
	if not notificador.is_on_screen(): return
	var jugador = get_tree().get_first_node_in_group("player")
	if not jugador: return

	var bala = bala_enemigo.instantiate()
	get_tree().current_scene.add_child(bala)
	bala.global_position = global_position
	bala.rotation = global_position.direction_to(jugador.global_position).angle()
	bala.velocidad = global_position.direction_to(jugador.global_position) * velocidad_bala

func tomar_daño(daño: int) -> void:
	vida -= daño
	if vida <= 0:
		if get_tree().current_scene.has_method("restar_enemigo"):
			get_tree().current_scene.restar_enemigo()
		queue_free()
