class_name Head extends SnakePart

signal collided_with_tail

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		#area.queue_free()
		#using call_deferred allows the function to wait until the
		#physics process of that frame has completed
		Global.food_eaten.emit()
		area.call_deferred("queue_free")
	else:
		#has hit tail, no other groups currently
		collided_with_tail.emit()
		
