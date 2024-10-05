extends Node2D

var max_left = 2
var max_right = 2

func _ready() -> void:
	pass

func get_max(right : bool) -> int:
	if(right):
		return max_right
	return max_left
