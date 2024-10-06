extends AnimatedSprite2D

var groth_speed = 200
var groth = 0
var total_frames = 3


@onready var money_lable: Label = %money_lable
const candy = preload("res://Scenes/candy.tscn")

func _ready():
	self.play("grow_farm")

func _process(delta):
	groth += 1
	if groth > groth_speed:  # Custom input action to trigger frame change
		groth = 0
		if(self.frame == 2):
			print("gave money")
			give_money()
		self.frame = (self.frame +1) % total_frames


func give_money():
	var candy = candy.instantiate()
	self.add_child(candy)
	candy.position = Vector2(self.position.x - 85, self.position.y + 20)
	candy.do_move(true)
