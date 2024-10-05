extends MenuButton

#prefabs
var house_asset = preload("res://Scenes/house.tscn")
var mine_asset = preload("res://Scenes/mine.tscn")

var asset_size = 0.35
var asset_scale = Vector2(asset_size, asset_size) 
var var_offset = 5

#Menu holder
var popup_menu

#Id { key : text, key : price }
var items = {
	1: {"text": "Buy House", "price": 100},	
	2: {"text": "Buy Farm", "price": 200},
	3: {"text": "Buy Mine", "price": 300},
}

func _ready() -> void:
	popup_menu = self.get_popup()
	
	#adding all items into popup menu
	for id in items.keys():
		popup_menu.add_item("%s for %d" % [items[id]["text"], items[id]["price"]], id)
	
	#estabilishing what to do when item is selected
	popup_menu.id_pressed.connect(on_item_selected)

func update_items():
	#Update prices by getting prices from their own respectfivly not going to be handled like this
	#THIS IS JUST TEST VALUES 
	items[1]["price"] += 200
	items[2]["price"] += 200
	items[3]["price"] += 200
	
	#Update all items text
	for id in items.keys():
		popup_menu.set_item_text(id-1, "%s for %d" % [items[id]["text"], items[id]["price"]])

# Function to handle item selection
func on_item_selected(id):
	var item_text = self.get_popup().get_item_text(id-1)
	match id:
		1 : 
			print("Tried to %s"%[item_text])
			spawn_house()
		2 : 
			print("Tried to %s"%[item_text])
		3 : 
			print("Tried to %s"%[item_text])
			spawn_mine()
	update_items()


func spawn_house() -> void:
	var house = house_asset.instantiate()
	if house:
		free_childen()
		get_parent().add_child(house)
		house.position = get_spawnposition()
		house.scale = asset_scale
	else:
		print("Failed to instantiate house.")

func spawn_mine() -> void:
	var mine = mine_asset.instantiate()
	if mine:
		free_childen()
		get_parent().add_child(mine)
		mine.position = get_spawnposition()
		mine.scale = asset_scale
	else:
		print("Failed to instantiate house.")

#getting correct postion for Vector2 to spawn object at
func get_spawnposition() -> Vector2:
	var current_position = get_global_position()
	var popup_menu_size = popup_menu.get_size()
	return Vector2(current_position.x + (popup_menu_size.x / 2), current_position.y + (popup_menu_size.y) - var_offset)

func free_childen():
	for child in popup_menu.get_children():
		child.queue_free()
