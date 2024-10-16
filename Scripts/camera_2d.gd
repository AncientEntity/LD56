extends Camera2D

var viewport_size
var left_boundry
var right_boundry
var moveSpeed = 500
var screen_delta = 0.25	    #% of the side of screen needed to move the camera

@onready var game_manager: Node = %GameManager
@onready var color_rect: ColorRect = $ColorRect

var lostScreen = preload("res://Scenes/lostScreen.tscn")
var pauseMenuScene = preload("res://Scenes/pause_menu.tscn")
var activePauseMenu = null

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
	var mouse_position = get_viewport().get_mouse_position()
	var mouseXPercent = mouse_position.x / get_window().content_scale_size.x
	#and mouseXPercent > 0
	if mouseXPercent <= screen_delta  and max_left <= self.position.x:
		#LEFT
		position.x -= moveSpeed * delta * (1 - mouseXPercent/screen_delta)
	elif 1.0 - mouseXPercent <= screen_delta and max_right >= self.position.x:
		#RIGHT
		position.x += moveSpeed * delta * (1 - (1 - mouseXPercent)/screen_delta)
			
	if Input.is_action_just_pressed("toggleFullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	
	if Input.is_action_just_pressed("pause") && !game_manager.lost:
		if not activePauseMenu:
			print(game_manager.lost)
			activePauseMenu = pauseMenuScene.instantiate()
			add_child(activePauseMenu)
			Engine.time_scale = 0
		else:
			print(game_manager.lost)
			activePauseMenu.queue_free()
			activePauseMenu = null
			Engine.time_scale = 1
	if(game_manager.lost && game_manager.lost_delay >0):
		color_rect.z_index = 4096
		var start_alpha = 120.0 / 255.0
		var end_alpha = 200.0 / 255.0 
		var normalized_time = clamp(game_manager.lost_delay / 3.0, 0.0, 1.0)
		color_rect.color.a = lerp(end_alpha, start_alpha, normalized_time)

func show_end_screen():
	activePauseMenu = lostScreen.instantiate()
	add_child(activePauseMenu)
	Engine.time_scale = 0

func update_max():
	max_left = -1*game_manager.max_left * desired_pixles - max_offset
	max_right = game_manager.max_right * desired_pixles + max_offset
