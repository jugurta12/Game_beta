extends Node

@export var mob_scene: PackedScene
var score

func _ready():
	new_game() 

func _process(delta):
	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Character.start($StartPosition.position)
	$StartTimer.start()

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	score += 1

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()  # Crée un nouveau mob
	
	# Trouver le point de spawn du mob
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob.position = mob_spawn_location.position  # Positionner le mob au point de spawn
	
	# Ajouter une vitesse de mouvement
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	var direction = mob_spawn_location.rotation + PI / 2
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)  # Ajouter le mob à la scène
