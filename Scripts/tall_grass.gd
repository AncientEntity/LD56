extends Node2D

@onready var game_manager: Node = %GameManager#change if pos of tall grass holder moves
@onready var world_buying_grid: Control = $"../../world_buying_grid"

var children = []

var wall
var label

#temp while buttons are in use
var buttons = []

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
		if grass.is_class("StaticBody2D"):
			wall = grass
			print("wall is ", wall.get_name())
		elif grass.is_class("Sprite2D"):
			children.append(grass)
			i += 1
		elif grass.is_class("Label"):
			label = grass
		elif grass.is_class("Button"):
			#temp while buttons are in use
			buttons.append(grass)
	if(self.get_name() == "GrassRight"):
		label.position = Vector2(children[0].position.x - desired_pixles/12, children[0].position.y - 60)
		update_text()
	elif(self.get_name() == "GrassLeft"):
		label.position = Vector2(children[5].position.x - desired_pixles/12, children[5].position.y - 60)
		update_text()

#children has an array of 6 grass objects, pops and moves the object L || R based on the right bool
func cut_grass(right : bool):
	if(!can_buy(right)):
		return
	
	
	var poped = children.pop_front() if right else children.pop_back()
	
	#READ WARNING BEFORE TOUCHING THIS
	#desired_pixles/scale = correct movement for each
	poped.position.x += (desired_pixles) if right else (-desired_pixles)
	
	if(right):
		children.insert(5, poped)
		wall.position.x += desired_pixles/6
		game_manager.max_right += 1
		label.position.x += desired_pixles/6
		
		#temp while buttons are in use
		for button in buttons:
			button.position.x += desired_pixles/6
	else:
		children.insert(0, poped)
		wall.position.x -= desired_pixles/6
		game_manager.max_left += 1
		label.position.x -= desired_pixles/6
		
		#temp while buttons are in use 
		for button in buttons:
			button.position.x -= desired_pixles/6
	world_buying_grid._update_grid(right)
	update_text()
	
	#if children.back().global_position.x < 0:
	#	%Camera2D.limit_left = children.back().global_position.x - 100
	#else:
	#	%Camera2D.limit_right = children.back().global_position.x + 100

func can_buy(right : bool) -> bool:
	if(game_manager.money >= game_manager.grass_cut_cost * ((game_manager.max_right - 1) if right else (game_manager.max_left - 1))):
		game_manager.money -= game_manager.grass_cut_cost * ((game_manager.max_right - 1) if right else (game_manager.max_left - 1))
		game_manager.update_lables()
		return true
	return false

func update_text():
	if(self.get_name() == "GrassRight"):
		label.text = "Cut for $%d"%[game_manager.grass_cut_cost * (game_manager.max_right - 1)]
	elif(self.get_name() == "GrassLeft"):
		label.text = "Cut for $%d"%[game_manager.grass_cut_cost * (game_manager.max_left - 1)]

#temp function while buttons are here. Call cut_grass for function
func _on_button_pressed(right : bool):
	cut_grass(right)
