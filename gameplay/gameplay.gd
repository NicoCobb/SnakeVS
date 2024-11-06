class_name Gameplay extends Node2D

const gameover_scene:PackedScene = preload("res://menus/game_over.tscn")
const pause_scene:PackedScene = preload("res://menus/pause_menu.tscn")


@onready var head: Head = %Head as Head
@onready var bounds: Bounds = %Bounds
@onready var spawner: Spawner = %Spawner
@onready var hud: HUD = %HUD

var time_between_moves:float = 1000.0
var time_since_last_move:float = 0
var speed:float = 10000.0
var move_dir:Vector2 = Vector2.RIGHT #Vector2(1,0)
var p1_snake_parts:Array[SnakePart] = []
var p2_snake_parts:Array[SnakePart] = []
var gameover_menu:GameOver
var pause_menu:PauseMenu
var score:int:
	get:
		return score
	set(value):
		score = value
		hud.update_score(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#connect all signals
	head.food_eaten.connect(_on_food_eaten)
	head.collided_with_tail.connect(_on_tail_collided)
	spawner.tail_added.connect(_on_tail_added)
	
	time_since_last_move = time_between_moves
	spawner.spawn_food()
	p1_snake_parts.push_back(head)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
	
	if head.player == 1: #P1 controls
		if Input.is_action_pressed("ui_up"):
			move_dir = Vector2.UP
		if Input.is_action_pressed("ui_down"):
			move_dir = Vector2.DOWN
		if Input.is_action_pressed("ui_left"):
			move_dir = Vector2.LEFT
		if Input.is_action_pressed("ui_right"):
			move_dir = Vector2.RIGHT
	if head.player == 2
		
func _physics_process(delta: float) -> void:
	time_since_last_move += delta * speed
	if time_since_last_move >= time_between_moves:
		time_since_last_move = 0
		update_snake()

func update_snake():
	var new_pos:Vector2 = head.position + move_dir * Global.GRID_SIZE
	new_pos = bounds.wrap_vector(new_pos)
	head.move_to(new_pos)
	
	for i in range(1, p1_snake_parts.size(), 1):
		p1_snake_parts[i].move_to(p1_snake_parts[i-1].last_position)

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

func _on_tail_added(tail:Tail):
	p1_snake_parts.push_back(tail)

func _on_tail_collided():
	if not gameover_menu:
		gameover_menu = gameover_scene.instantiate() as GameOver
		add_child(gameover_menu)
		gameover_menu.set_score(score)
		
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		pause_game()
		
func pause_game():
	pause_menu = pause_scene.instantiate() as PauseMenu
	add_child(pause_menu)
