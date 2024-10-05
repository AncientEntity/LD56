extends Camera2D

var viewport_size
var left_boundry
var right_boundry
var moveSpeed = 500
var screen_delta = 0.25	    #% of the side of screen needed to move the camera

var baseResolution = [1152,648]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_positions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_positions()
	var mouse_position = get_viewport().get_mouse_position() 
	if mouse_position.x < left_boundry:
		if(mouse_position.x >= (left_boundry) - (viewport_size.x - right_boundry)):
			position.x -= moveSpeed * delta * (1 - mouse_position.x/left_boundry)
	elif mouse_position.x > right_boundry:
		if(mouse_position.x <= viewport_size.x):
			position.x += moveSpeed * delta * (1 - (viewport_size.x - mouse_position.x)/right_boundry)
			
	if Input.is_action_just_pressed("toggleFullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

#updates all variable vector positions
func update_positions() -> void:
	viewport_size = get_viewport().get_size()
	left_boundry = viewport_size.x * (0.5 - screen_delta)
	right_boundry = viewport_size.x * (0.5 + screen_delta)
