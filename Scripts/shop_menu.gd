extends MenuButton

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
		2 : 
			print("Tried to %s"%[item_text])
		3 : 
			print("Tried to %s"%[item_text])
	update_items()
