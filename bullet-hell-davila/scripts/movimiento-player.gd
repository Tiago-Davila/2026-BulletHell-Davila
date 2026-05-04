extends CharacterBody2D

var velocidad: int = 200
var puede_dashear: bool = true
var dasheando: bool = false
var direccion_dash: Vector2 = Vector2.ZERO
var velocidad_dash: int = 700
var dash_duracion: float = 0.1
var dash_timer: float = 0.0
var dash_cooldown: float = 1.0
var dash_cooldown_timer: float = 0.0
var vida: int = 5
var vida_maxima: int = 5
var municion: int = 0


var atacando: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var corazones = [$GUI/corazon1, $GUI/corazon2, $GUI/corazon3, $GUI/corazon4, $GUI/corazon5]
@onready var balas = [$GUI/Bala, $GUI/Bala2, $GUI/Bala3, $GUI/Bala4, $GUI/Bala5]

func _ready() -> void:
	actualizar_municion()
	actualizar_salud()
func _process(_delta: float) -> void:
	if get_global_mouse_position().x < global_position.x:
		sprite.flip_h = true
		$areaAtaque/CollisionShape2D.position.x = -abs($areaAtaque/CollisionShape2D.position.x)
	else:
		sprite.flip_h = false
		$areaAtaque/CollisionShape2D.position.x = abs($areaAtaque/CollisionShape2D.position.x)
		

func _physics_process(delta: float) -> void:
	if dasheando:
		dash_timer -= delta
		if dash_timer <= 0:
			dasheando = false

	if not puede_dashear:
		dash_cooldown_timer -= delta
		if dash_cooldown_timer <= 0:
			puede_dashear = true

	var direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo")

	if Input.is_action_just_pressed("dash") and puede_dashear and not dasheando:
		dasheando = true
		puede_dashear = false
		dash_timer = dash_duracion
		dash_cooldown_timer = dash_cooldown
		if direction != Vector2.ZERO:
			direccion_dash = direction.normalized()
		else:
			direccion_dash = (get_global_mouse_position() - global_position).normalized()

	if Input.is_action_just_pressed("slash") and not atacando and not dasheando:
		atacando = true
		sprite.play("atacando")

	if dasheando:
		velocity = velocidad_dash * direccion_dash
	else:
		velocity = direction * velocidad

	if not atacando:
		if dasheando:
			sprite.play("dash")
		elif direction != Vector2.ZERO:
			sprite.play("run")
		else:
			sprite.play("idle")

	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "atacando":
		atacando = false
		
func _input (event:InputEvent) -> void:
	if(event.is_action_pressed("slash")):
		var bodies: Array = $areaAtaque.get_overlapping_bodies()
		for body in bodies:
			if(body.is_in_group("enemigos")):
				body.tomar_daño(10)
				
				
func tomar_daño(daño: int) -> void:
	vida -= daño
	actualizar_salud()
	if vida <= 0:queue_free()
	
	
func actualizar_salud() -> void:
	for i in range(corazones.size()):
		corazones[i].visible = i < vida


func recargar(cantidad: int) -> void:
	municion = clamp(municion + cantidad, 0,5) # me sirve para ponerle un tope de 5 municiones 
	actualizar_municion()


func curar(cantidad: int) -> void:
	vida = clamp(vida + cantidad, 0,5) # me sirve para ponerle un tope de 5 de vida 
	actualizar_salud()

func actualizar_municion() -> void:
	for i in range(balas.size()):
		balas[i].visible = i < municion
		
