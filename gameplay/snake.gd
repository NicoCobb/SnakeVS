class_name Snake extends Node2D

signal food_eaten

#@onready var head: Head = %Head as Head
var head_scene:PackedScene = preload("res://gameplay/head.tscn")
var tail_scene:PackedScene = preload("res://gameplay/tail.tscn")
#spawner???

var time_between_moves:float = 1000.0
var time_since_last_move:float = 0
var speed:float = 10000.0
var move_dir:Vector2 = Vector2.RIGHT #Vector2(1,0)

var snake_parts:Array[SnakePart] = []

var player:int = 0

#TODO: separate on spawn p1 p2 somehow
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn_point:Vector2 = Vector2.ZERO
	#instantiate
	var head:Head = head_scene.instantiate()
	head.position = spawn_point
	#parent instantiate
	get_parent().add_child(head)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player == 1: #P1 controls
		if Input.is_action_pressed("p1_up"):
			move_dir = Vector2.UP
		if Input.is_action_pressed("p1_down"):
			move_dir = Vector2.DOWN
		if Input.is_action_pressed("p1_left"):
			move_dir = Vector2.LEFT
		if Input.is_action_pressed("p1_right"):
			move_dir = Vector2.RIGHT
	if player == 2:
		if Input.is_action_pressed("p2_up"):
			move_dir = Vector2.UP
		if Input.is_action_pressed("p2_down"):
			move_dir = Vector2.DOWN
		if Input.is_action_pressed("p2_left"):
			move_dir = Vector2.LEFT
		if Input.is_action_pressed("p2_right"):
			move_dir = Vector2.RIGHT
	
#TODO: Fix for 2p
func _on_food_eaten():
	#note: it's less efficient to use a spawner here instead of just moving the node
	#	   but this is kind of for practice anyway

	#spawn new when eaten
	spawner.call_deferred("spawn_food")
	#add tail
	spawner.call_deferred("spawn_tail", p1_snake_parts[p1_snake_parts.size() - 1].last_position)
	#speeeeeed
	speed += 500
	score += 1

func update_snake():
	var new_pos:Vector2 = head.position + move_dir * Global.GRID_SIZE
	new_pos = bounds.wrap_vector(new_pos)
	head.move_to(new_pos)
	
	for i in range(1, p1_snake_parts.size(), 1):
		p1_snake_parts[i].move_to(p1_snake_parts[i-1].last_position)
