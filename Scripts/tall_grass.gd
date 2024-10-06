extends Node2D

@onready var button: Button = $Button
@onready var button_2: Button = $Button2

var children = []

func _ready() -> void:
	print("in ready")
	var i =  0
	for grass in self.get_children():
		#temp if statment to exclude testing buttons from array
		if grass.is_class("Button") == false:
			children.append(grass)
			i += 1
	pass

#children has an array of 6 grass objects, pops and moves the object L || R based on the right bool
func cut_grass(right : bool):
	var poped = children.pop_front() if right else children.pop_back()
	#1200 bc X scale is set to 0.75 and all 6 are 900 pxl wide
	poped.position.x += 1200 if right else -1200
	children.insert(5 if right else 0, poped)


#temp function while buttons are here. Call cut_grass for function
func _on_button_pressed(right : bool):
	cut_grass(right)
