extends Node2D

const velocidad_slash: int = 300
var distancia_maxima: float = 700.0
var posicion_inicial: Vector2
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	sprite.sprite_frames.set_animation_loop("slash", false)
	sprite.play("slash")
	

func _process(delta: float) -> void:
	position += transform.x * velocidad_slash * delta
	if global_position.distance_to(posicion_inicial) >= distancia_maxima:
		queue_free()




func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free() # Replace with function body.
