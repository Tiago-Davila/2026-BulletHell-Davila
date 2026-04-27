extends Node2D

const disparo = preload("res://escenas/disparo.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270 :
		scale.y = -1
	else:
		scale.y = 1
	if Input.is_action_just_pressed("disparo"):
		var player = get_parent()
		if player.municion <= 0:
			return
		player.municion -=1
		player.actualizar_municion()
		var slash_instance = disparo.instantiate()
		get_tree().root.add_child(slash_instance)
		slash_instance.global_position = global_position
		slash_instance.rotation = rotation
		
