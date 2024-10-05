extends Control
@onready var button: Button = $Button		#Temp

@onready var grid_right: GridContainer = $GridRight
@onready var grid_left: GridContainer = $GridLeft
@onready var game_scene: Node2D = $".."

var tile_shop_asset = preload("res://Scenes/tile_shop.tscn")	#Shop Scene

var grids = {
	1: {"text": "right_grid", "max": 0, "placed": 1},	
	2: {"text": "left_grid", "max": 0, "placed": 1},
}

func _ready() -> void:	
	grids[1]["max"] = game_scene.max_right
	grids[2]["max"] = game_scene.max_left
	pass

func _update_grid(right: bool):
	grids[1]["max"] = game_scene.max_right
	grids[2]["max"] = game_scene.max_left
	
	var tile_asset
	if(_can_develop(true) && right):
		grids[1]["placed"] += 1
		tile_asset = tile_shop_asset.instantiate()
		self.grid_right.add_child(tile_asset)
	elif(_can_develop(right) && !right):
		grids[2]["placed"] += 1
		tile_asset = tile_shop_asset.instantiate()
		self.grid_left.add_child(tile_asset)

func _can_develop(right : bool):
	if(grids[1]["max"] >= grids[1]["placed"]+1 && right):
		if(grids[1]["max"] >= grids[1]["placed"]+1):
			return true
	elif(!right):
		if(grids[2]["max"] >= grids[2]["placed"]+1):
			return true
	return false

func _on_button_pressed(right : bool) -> void:
	_update_grid(right)
