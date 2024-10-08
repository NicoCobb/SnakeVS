class_name GameOver extends CanvasLayer

@onready var score: Label = %ScoreLabel
@onready var high_score: Label = %HighScoreLabel
@onready var restart: Button = %RestartButton
@onready var quit: Button = %QuitButton

func set_score(s:int):
	score.text = "Final Score: " + str(s)
	if s > Global.save_data.high_score:
		high_score.visible = true
		Global.save_data.high_score = s
		Global.save_data.save()
	else:
		high_score.visible = false

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	#note: does not do anything in a web browser
	get_tree().quit()
	
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false
