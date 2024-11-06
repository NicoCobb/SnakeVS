class_name Snake extends Node2D

@onready var head: Head = %Head as Head

var time_between_moves:float = 1000.0
var time_since_last_move:float = 0
var speed:float = 10000.0
var move_dir:Vector2 = Vector2.RIGHT #Vector2(1,0)
var snake_parts:Array[SnakePart] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
