extends CharacterBody2D  

var velocidad: int = 350
@onready var sprite: Sprite2D = $playerIdle #obtengo el sprite del personaje


func _process(_delta: float) -> void:
	if get_global_mouse_position().x < global_position.x:
		sprite.flip_h = true  
	else:
		sprite.flip_h = false 
		
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	velocity = direction * velocidad
	
	move_and_slide()
   
