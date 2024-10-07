extends AnimatedSprite2D

var groth_speed 
var groth = 0
var total_frames = 3
var rng_rate = 4

const candy = preload("res://Scenes/candy.tscn")

func _ready():
	groth_speed = randi_range(175, 275)
	self.play("grow_farm")

func _process(delta):
	groth += 1
	if groth > groth_speed:  # Custom input action to trigger frame change
		groth = 0
		groth_speed = randi_range(175, 300)
		if(self.frame == 2):
			give_money()
		self.frame = (self.frame +1) % total_frames


func give_money():
	var rng = randi_range(1, rng_rate)
	for i in rng:
		var candy = candy.instantiate()
		self.add_child(candy)
		candy.position = Vector2(self.position.x - randi_range(10, 150) , self.position.y + randi_range(-50, 50))
		candy.do_move(true)
