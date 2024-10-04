extends CanvasLayer

const gameplay_scene:PackedScene = preload("res://gameplay/gameplay.tscn")

@onready var score: Label = %ScoreLabel
@onready var start: Button = %StartButton
@onready var quit: Button = %QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var high_score:int = Global.save_data.high_score
	score.text = "High score: " + str(high_score)
	pass # Replace with function body.

func _on_start_button_pressed() -> void:
	#note: more robust scene manager probably preferred for higher complexity projects
	#      for handling things like background loading, transitions, data transfer, etc
	get_tree().change_scene_to_packed(gameplay_scene)
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	#note: does not do anything in a web browser
	get_tree().quit()
