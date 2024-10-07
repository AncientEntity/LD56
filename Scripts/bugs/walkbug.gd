extends BaseBug

var direction = 1
var speed = 50

func _ready() -> void:
	super._ready()
	if direction == 1:
		$WalkBug.flip_h = true
		$WalkBug/Legs.flip_h = true
	print(direction)

func _process(delta: float) -> void:
	super._process(delta)

func _physics_process(delta: float) -> void:
	if not attacking:
		move_local_x(direction * speed * delta)
