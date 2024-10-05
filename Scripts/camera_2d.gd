extends Camera2D

var viewport_size
var left_boundry
var right_boundry
var moveSpeed = 500
var screen_delta = 0.25	    #% of the side of screen needed to move the camera

var baseResolution = [1152,648]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	var mouseXPercent = mouse_position.x / get_window().content_scale_size.x
	if mouseXPercent <= screen_delta:
		position.x -= moveSpeed * delta * (1 - mouseXPercent/screen_delta)
	elif 1.0 - mouseXPercent <= screen_delta:
		position.x += moveSpeed * delta * (1 - (1 - mouseXPercent)/screen_delta)
			
	if Input.is_action_just_pressed("toggleFullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
