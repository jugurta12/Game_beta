extends RigidBody2D

func _ready():
	# Jouer l'animation "walk" si tu n'as qu'une animation
	$AnimatedSprite2D.play("walk")  # Remplace "walk" par le nom de ton animation

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()  # Supprimer le mob quand il quitte l'écran
