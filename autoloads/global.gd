extends Node

const GRID_SIZE:int = 32
const SPEED_UP:int = 500

var save_data:SaveData

func _ready() -> void:
	save_data = SaveData.load_or_create()
