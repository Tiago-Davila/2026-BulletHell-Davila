extends CharacterBody2D

@export var bullet_scene: PackedScene
@onready var shoot_timer = $ShootTimer
@onready var rotater = $Rotater
@onready var sprite = $AnimatedSprite2D

var patrones = [
	{"speed": 0.0, "wait": 0.15, "count": 8, "radius": 100.0},
	{"speed": 50.0, "wait": 0.2, "count": 6, "radius": 100.0},
	{"speed": 80.0, "wait": 0.2, "count": 3, "radius": 100.0},
	{"speed": 100.0, "wait": 0.4, "count": 3, "radius": 50.0}
]

var indice_patron: int = 0
var rotate_speed: float = 0.0
var tiempo_en_patron: float = 0.0
var duracion_patron: float = 4.0
var tiempo_entre_ataques: float = 0.2
 
var estado_actual: String = "IDLE"
var vida: int = 700

func _ready() -> void:
	get_tree().current_scene.sumar_enemigo()
	sprite.play("idle")
	estado_actual = "IDLE"
	
	await get_tree().create_timer(2.0).timeout
	cambiar_a_siguiente_patron()

func _process(delta: float) -> void:
	if estado_actual == "ATACANDO":
		var new_rotation = rotater.rotation_degrees + rotate_speed * delta
		rotater.rotation_degrees = wrapf(new_rotation, 0.0, 360.0)
		
		tiempo_en_patron -= delta
		if tiempo_en_patron <= 0:
			cambiar_a_siguiente_patron()

func configurar_puntos(count: int, radius: float) -> void:
	for hijo in rotater.get_children():
		hijo.queue_free()
		
	var step = 2 * PI / count
	for i in range(count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)

func cambiar_a_siguiente_patron() -> void:
	estado_actual = "CAMBIANDO_ESTADO"
	shoot_timer.stop()
	sprite.play("cambiando_estado")
	
	await sprite.animation_finished
	
	sprite.play("idle")
	await get_tree().create_timer(tiempo_entre_ataques).timeout
	
	var patron = patrones[indice_patron]
	rotate_speed = patron["speed"]
	shoot_timer.wait_time = patron["wait"]
	configurar_puntos(patron["count"], patron["radius"])
	
	indice_patron += 1
	if indice_patron >= patrones.size():
		indice_patron = 0
		
	tiempo_en_patron = duracion_patron
	estado_actual = "ATACANDO"
	sprite.play("atacando")
	shoot_timer.start()

func _on_shoot_timer_timeout() -> void:
	if not bullet_scene: return
	
	for s in rotater.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = s.global_position
		bullet.rotation = s.global_rotation

func tomar_daño(daño: int) -> void:
	vida -= daño
	print("Vida del boss", vida)
	if vida <= 0:
		queue_free()
		get_tree().current_scene.restar_enemigo()
