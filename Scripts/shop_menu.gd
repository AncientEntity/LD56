extends MenuButton

#@onready var game_manager: Node = $"../GameManager"
@onready var game_manager: Control = $"../.."
const DASHED_SHOP = preload("res://Assets/TempAssets/DashedShop.png")

var pos_offset = Vector2 ( 18, -7 )

var has_land = false

#Holders
var popup_menu
var cur_asset_id

#Id { key : text, key : price }
var items = {
	1: {"text": "Buy House", "price": 100, "asset": preload("res://Scenes/buildings/house.tscn")},	
	2: {"text": "Buy Farm", "price": 200, "asset": preload("res://Scenes/buildings/farm.tscn")},
	3: {"text": "Buy Mine", "price": 300, "asset": preload("res://Scenes/buildings/mine.tscn")},
	4: {"text": "Buy Tower", "price": 300, "asset": preload("res://Scenes/buildings/tower.tscn")},
}

func _ready() -> void:
	popup_menu = self.get_popup()
	#estabilishing what to do when item is selected
	popup_menu.id_pressed.connect(on_item_selected)

func update_items():
	#Update prices by getting prices from their own respectfivly not going to be handled like this
	get_popup().clear()
	
	if !has_land:
		items[1]["price"] = game_manager.get_prices(1, false)
		items[2]["price"] = game_manager.get_prices(2, false)
		items[3]["price"] = game_manager.get_prices(3, false)
		items[4]["price"] = game_manager.get_prices(4, false)
		#Update all items text
		for id in items.keys():
			popup_menu.add_item("%s for -$%d" % [items[id]["text"], items[id]["price"]], id)
	else:
		popup_menu.add_item("Destroy +$%d"%[game_manager.get_prices(cur_asset_id, true)], 0)

# Function to handle item selection
func on_item_selected(id):
	
	#check if money allows
	if(id == 0):
		game_manager.sell_building(cur_asset_id)
		destroy()
	else:
		#var item_text = self.get_popup().get_item_text(id-1)
		var spawned_asset = items[id]["asset"].instantiate()
		cur_asset_id = id 
		if spawned_asset && items[id]["price"] <= game_manager.get_prices(0,false):
			game_manager.sell_building(-1*cur_asset_id)
			
			free_childen()
			self.add_child(spawned_asset)
			spawned_asset.position =  spawned_asset.position - pos_offset
			spawned_asset.parentShop = self
			
			self.modulate = Color("ffffff")
			self.icon = null
			has_land = true
		else:
			print("Invalid Money")
			spawned_asset.queue_free()
		

func destroy():
	free_childen()
	self.modulate = Color("#FFFFFF00")
	self.icon = DASHED_SHOP
	has_land = false
	update_items()

func free_childen():
	for child in self.get_children():
		child.queue_free()

func _on_mouse_entered() -> void:
	self.modulate = Color("ffffff")

func _on_mouse_exited() -> void:
	if(!has_land):
		self.modulate = Color("#FFFFFF00")

func _on_pressed() -> void:
	update_items()
