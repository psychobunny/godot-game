extends Node2D

export (PackedScene) var Mob
var score


func _ready():
	randomize()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message('Get Ready')

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	$HUD.show_game_over()

func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()
	
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	
	var mob = Mob.instance()
	add_child(mob)
	
	# GDScript uses radians, derp
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2 # perpindicular to path's direction
	
	mob.position = $MobPath/MobSpawnLocation.position
	mob.rotation = direction
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	
	