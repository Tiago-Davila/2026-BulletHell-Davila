extends Area2D


var velocidad: Vector2 = Vector2.ZERO

var daño: int = 1
 
func _physics_process(delta: float) -> void:
	position += velocidad * delta 
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.tomar_daño(daño)
		queue_free()
