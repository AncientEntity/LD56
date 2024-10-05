extends MenuButton

var asset_size = 0.35
var asset_scale = Vector2(asset_size, asset_size) 
var pos_offset = Vector2 ( 18, -7 )

#Menu holder
var popup_menu

#Id { key : text, key : price }
var items = {
	1: {"text": "Buy House", "price": 100, "asset": preload("res://Scenes/house.tscn")},	
	2: {"text": "Buy Farm", "price": 200, "asset": preload("res://Scenes/farm.tscn")},
	3: {"text": "Buy Mine", "price": 300, "asset": preload("res://Scenes/mine.tscn")},
}

func _ready() -> void:
	popup_menu = self.get_popup()
	
	#adding all items into popup menu
	for id in items.keys():
		popup_menu.add_item("%s for %d" % [items[id]["text"], items[id]["price"]], id)
	
	#estabilishing what to do when item is selected
	popup_menu.id_pressed.connect(on_item_selected)
	self.mouse_entered.connect(on_mouse_entered)
	self.mouse_exited.connect(on_mouse_exited)

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
	#check if money allows
	var spawned_asset = items[id]["asset"].instantiate()
	if spawned_asset:
		free_childen()
		self.add_child(spawned_asset)
		spawned_asset.position =  spawned_asset.position - pos_offset
		spawned_asset.scale = asset_scale
	update_items()


func free_childen():
	print("freeing children")
	for child in self.get_children():
		print("freeing ", child)
		child.queue_free()


func on_mouse_entered():
	pass

func on_mouse_exited():
	pass
