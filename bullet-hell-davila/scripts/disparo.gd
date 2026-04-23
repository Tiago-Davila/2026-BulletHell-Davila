extends Area2D

const velocidad_slash: int = 300
var distancia_maxima: float = 2000
var posicion_inicial: Vector2
var daño: int = 100
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	posicion_inicial = global_position
	sprite.play("disparo")
	

func _process(delta: float) -> void:
	position += transform.x * velocidad_slash * delta
	if global_position.distance_to(posicion_inicial) >= distancia_maxima:
		queue_free()



	



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemigos"):
		body.tomar_daño(daño)
		queue_free() # Replace with function body.
