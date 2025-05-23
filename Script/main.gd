extends Node
@export var mob_scene: PackedScene
var score

func _ready():
	pass
	#new_game() 

func _process(_delta) :
	pass

func game_over():
	$MobTimer.stop()
	$ScoreTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Character.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score (score)
	$HUD.show_message ("GET READY!")

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()

	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2;
	mob.position = mob_spawn_location.position;
	
	var velocity = Vector2(randf_range (150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
