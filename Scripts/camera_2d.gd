extends Camera2D

var viewport_size
var left_boundry
var right_boundry
var moveSpeed = 500
var screen_delta = 0.25	    #% of the side of screen needed to move the camera

@onready var game_manager: Node = %GameManager

#WARNING if this is changed from 60 then the position of tall_grass needs to all be changed
#(tile_shop min size + grid_H_seperation) = desired_pixles is the total pixles needed for all grass items to be
#ONLY change that through the scale of THIS Grass Node2D
#desired_pixles/scale
var grid_H_seperation = 60   
var desired_pixles = (150 + grid_H_seperation)/self.scale.x
var max_offset = 100.0
@onready var max_right = game_manager.max_right * desired_pixles + max_offset
@onready var max_left = -1*game_manager.max_left * desired_pixles - max_offset

var baseResolution = [1152,648]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	max_left = -1*game_manager.max_left * desired_pixles - max_offset
	max_right = game_manager.max_right * desired_pixles + max_offset
	var mouse_position = get_viewport().get_mouse_position()
	var mouseXPercent = mouse_position.x / get_window().content_scale_size.x
	
	if mouseXPercent <= screen_delta and mouseXPercent > 0 and max_left <= self.position.x:
		#LEFT
		position.x -= moveSpeed * delta * (1 - mouseXPercent/screen_delta)
	elif 1.0 - mouseXPercent <= screen_delta and mouseXPercent < 1 and max_right >= self.position.x:
		#RIGHT
		position.x += moveSpeed * delta * (1 - (1 - mouseXPercent)/screen_delta)
			
	if Input.is_action_just_pressed("toggleFullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
