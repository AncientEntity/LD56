extends Camera2D

var viewport_size
var left_boundry
var right_boundry
var moveSpeed = 500			
var screen_delta = 0.25	    #% of the side of screen needed to move the camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_positions()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_positions()
	var mouse_position = get_viewport().get_mouse_position() 
	if mouse_position.x < left_boundry:
		position.x -= moveSpeed * delta * (1 - mouse_position.x/left_boundry)
		print("change is %s" % [moveSpeed * delta * (1 - mouse_position.x/left_boundry)])
	elif mouse_position.x > right_boundry:
		position.x += moveSpeed * delta * (1- (viewport_size.x - mouse_position.x)/right_boundry)
		print("change is %s" % [moveSpeed * delta * (1- (viewport_size.x - mouse_position.x)/right_boundry)])
		#right to bound
	pass

func update_positions() -> void:
	viewport_size = get_viewport().get_size()
	left_boundry = viewport_size.x * (0.5 - screen_delta)
	right_boundry = viewport_size.x * (0.5 + screen_delta)
	pass
