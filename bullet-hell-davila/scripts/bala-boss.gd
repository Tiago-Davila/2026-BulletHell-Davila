extends Area2D

var speed: float = 100.0

func _process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_kill_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.tomar_daño(1)
		queue_free()
