extends Sprite2D

var groth_speed = 300
var groth = 0
var rng_rate = 8

@onready var parent: MenuButton = $"../.."
const candy = preload("res://Scenes/candy.tscn")


func _process(delta):
	groth += 1
	if groth > groth_speed:  # Custom input action to trigger frame change
		groth = 0
		give_money()

func give_money():
	var rng = randi_range(2, rng_rate)
	if(parent.cur_mined > 0):
		parent.sub_ore()
	elif self.get_child_count() >= 1:
		rng = 0
	else:
		parent.sub_ore()
	
	for i in rng:
		var candy = candy.instantiate()
		self.add_child(candy)
		candy.position = Vector2(self.position.x - randi_range(10, 150) , self.position.y + randi_range(-150, 50))
		candy.do_move(true)
