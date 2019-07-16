extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message('Game Over')
	yield($MessageTimer, 'timeout') # using the created timer (2s)
	
	$MessageLabel.text = 'Try again...\nDodge!'
	$MessageLabel.show()
	yield(get_tree().create_timer(1), 'timeout') # other way using the scene's timer (1s)
	
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal('start_game')

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_restart_game(): # since Mob is being instanced manually, see Main.gd
    queue_free() # deletes current node at end of current frame