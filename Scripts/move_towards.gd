extends AnimatedSprite2D

@onready var buying_grid: Control

var moveing = 0
var towards = Vector2(0,0)
var speed = 800

var candy_price = 25
var sale_rng
var rng

func start_ready() :
	buying_grid = $"../../../../.."
	rng = randf_range(0.8, 1.5)
	sale_rng = rng 
	
	#calculating the OMEGA candy
	if(rng == 1.49):
		rng = 5
		sale_rng = rng*rng
	
	speed = speed / (rng * self.get_parent().scale.x)
	self.scale = Vector2( rng * 0.25/self.get_parent().scale.x,rng * 0.25/self.get_parent().scale.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(moveing == 1):
		self.move_local_x(speed * delta)
		if(self.global_position.y <= -149):
			buying_grid.give_money(int(candy_price * sale_rng))
			self.queue_free()

func do_move (move_in : bool):
	self.look_at(Vector2(0,-150))
	start_ready()
	moveing = 1
