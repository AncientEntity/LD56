extends Control

@onready var grid_right: GridContainer = $GridRight
@onready var grid_left: GridContainer = $GridLeft

var tile_shop_asset = preload("res://Scenes/tile_shop.tscn")
@onready var button: Button = $Button

var test_alts = true

func _ready() -> void:	
	pass

func _update_grid():
	if(_can_develop(true)):
		var tile_asset = tile_shop_asset.instantiate()
		self.grid_right.add_child(tile_asset)
	elif(_can_develop(false)):
		var tile_asset = tile_shop_asset.instantiate()
		self.grid_left.add_child(tile_asset)

func _can_develop(right : bool):
	if(test_alts && right):
		test_alts = false
		return true
	elif(!test_alts && !right):
		test_alts = true
		return true


func _on_button_pressed() -> void:
	_update_grid()
