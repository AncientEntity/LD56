extends AnimatedSprite2D

var moveing = 0
var towards = Vector2(0,0)
var speed = 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(moveing == 1):
		self.move_local_x(speed * delta * 1)
		if(self.global_position.y <= -150):
			self.queue_free()

func do_move (move_in : bool):
	self.look_at(Vector2(0,-150))
	moveing = 1
