extends Area2D

signal hit

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()  # Cacher le personnage au début

func _process(delta):
	var velocity = Vector2.ZERO

	# Gérer les déplacements
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	# Si le personnage se déplace, on joue l'animation
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("walk_r")  # Remplace "walk" par le nom de ton animation
	else:
		$AnimatedSprite2D.stop()  # Si pas de mouvement, arrête l'animation

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()  # Émettre le signal hit quand le personnage est touché
	$CollisionShape2D.set_deferred("disabled", true)  # Désactiver la collision temporairement

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
