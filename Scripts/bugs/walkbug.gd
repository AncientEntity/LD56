extends BaseBug

var direction = 0
var speed = 15

func _ready() -> void:
	direction = -1 if global_position.x > 0 else 1
	super._ready()
	if direction > 0:
		$WalkBug.flip_h = true

func _process(delta: float) -> void:
	super._process(delta)
	
func _physics_process(delta: float) -> void:
	if not attacking:
		move_local_x(direction * speed * delta)
