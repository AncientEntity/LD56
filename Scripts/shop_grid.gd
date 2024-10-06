extends Control
#@onready var button: Button = $Button		#Temp

@onready var grid_right: GridContainer = $GridRight
@onready var grid_left: GridContainer = $GridLeft
@onready var game_manager: Node = %GameManager

var tile_shop_asset = preload("res://Scenes/tile_shop.tscn")	#Shop Scene

var grids = {
	1: {"text": "right_grid", "max": 0, "placed": 1},	
	2: {"text": "left_grid", "max": 0, "placed": 1},
}

func _ready() -> void:	
	grids[1]["max"] = game_manager.max_right
	grids[2]["max"] = game_manager.max_left
	
	#pre-loads max grid right away 
	while _can_develop(true):
		grids[1]["placed"] += 1
		var tile_asset = tile_shop_asset.instantiate()
		self.grid_right.add_child(tile_asset)
	while _can_develop(false):
		grids[2]["placed"] += 1
		var tile_asset = tile_shop_asset.instantiate()
		self.grid_left.add_child(tile_asset)

func _update_grid(right: bool):
	grids[1]["max"] = game_manager.max_right
	grids[2]["max"] = game_manager.max_left
	
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
			print("adding right")
			return true
	elif(!right):
		if(grids[2]["max"] >= grids[2]["placed"]+1):
			print("adding left")
			return true
	return false

func _on_button_pressed(right : bool) -> void:
	_update_grid(right)



func sell_building(id : int):
	match abs(id):
		1:
			game_manager.money += game_manager.house_cost/(2 if id > 0 else -1)
		2:
			game_manager.money += game_manager.farm_cost/(2 if id > 0 else -1)
		3:
			game_manager.money += game_manager.mine_cost/(2 if id > 0 else -1)
		4:
			game_manager.money += game_manager.tower_cost/(2 if id > 0 else -1)
	game_manager.update_lables()

#func buy_building(id : int):
	#match id:
		#1:
			#game_manager.money -= game_manager.house_cost
		#2:
			#game_manager.money -= game_manager.farm_cost
		#3:
			#game_manager.money -= game_manager.mine_cost
		#4:
			#game_manager.money -= game_manager.tower_cost
	#game_manager.update_lables()

func get_prices(id : int, sell : bool) -> int:
	match id:
		0:
			return game_manager.money
		1:
			return game_manager.house_cost / (2 if sell else 1)
		2:
			return game_manager.farm_cost / (2 if sell else 1)
		3:
			return game_manager.mine_cost / (3 if sell else 1)
		4:
			return game_manager.tower_cost / (2 if sell else 1)
	return 0
