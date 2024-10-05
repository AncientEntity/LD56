extends Node2D

var max_left = 5
var max_right = 5

func _ready() -> void:
	pass

func get_max(right : bool) -> int:
	if(right):
		return max_right
	return max_left
