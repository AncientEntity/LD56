extends Node2D

@onready var game_manager: Node = %GameManager#change if pos of tall grass holder moves
@onready var world_buying_grid: Control = $"../../world_buying_grid"

var children = []

var wall

#WARNING if this is changed from 60 then the position of tall_grass needs to all be changed
#num_of_grass_items*(tile_shop min size + grid_H_seperation) = desired_pixles is the total pixles needed for all grass items to be
#ONLY change that through the scale of THIS Grass Node2D
#desired_pixles/ 1204 		gives needed scale
var grid_H_seperation = 60   
var desired_pixles = 6*(150 + grid_H_seperation)/self.scale.x

func _ready() -> void:
	print("in ready")
	var i =  0
	for grass in self.get_children():
		#temp if statment to exclude testing buttons from array
		if(grass.is_class("StaticBody2D") == true):
			wall = grass
			print("wall is ", wall.get_name())
		elif grass.is_class("Button") == false:
			children.append(grass)
			i += 1
		
	pass

#children has an array of 6 grass objects, pops and moves the object L || R based on the right bool
func cut_grass(right : bool):
	var poped = children.pop_front() if right else children.pop_back()
	
	#READ WARNING BEFORE TOUCHING THIS
	#desired_pixles/scale = correct movement for each
	poped.position.x += (desired_pixles) if right else (-desired_pixles)
	
	if(right):
		children.insert(5, poped)
		print("pos was ",wall.position.x)
		wall.position.x += desired_pixles/6
		print("pos now ",wall.position.x)
		game_manager.max_right += 1
	else:
		children.insert(0, poped)
		wall.position.x -= desired_pixles/6
		game_manager.max_left += 1
	world_buying_grid._update_grid(right)


#temp function while buttons are here. Call cut_grass for function
func _on_button_pressed(right : bool):
	cut_grass(right)
