extends Area2D

var velocidad: Vector2 = Vector2.ZERO
var tiempo_vida: float = 1.5
var explotando: bool = false

@onready var area_explosion = $AreaExplosion
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	sprite.play("bomba")

func _process(delta: float) -> void:
	if explotando: 
		return
		
	tiempo_vida -= delta
	position += velocidad * delta
	
	if tiempo_vida <= 0:
		explotar()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not explotando:
		explotar()

func explotar() -> void:
	explotando = true
	sprite.play("explosion")
	
	var cuerpos = area_explosion.get_overlapping_bodies()
	
	for cuerpo in cuerpos:
		if cuerpo.is_in_group("player") and cuerpo.has_method("tomar_daño"):
			cuerpo.tomar_daño(20)
			
	await sprite.animation_finished
	queue_free()
