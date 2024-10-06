extends AnimatedSprite2D

var groth_speed = 300
var groth = 0
var total_frames = 3

func _ready():
	self.play("grow_farm")

func _process(delta):
	groth += 1
	if groth > groth_speed:  # Custom input action to trigger frame change
		groth = 0
		self.frame = (self.frame +1) % total_frames
