extends BaseBug

var direction = 1
var speed = 50
@onready var body: AnimatedSprite2D = $WalkBug/Body

func _ready() -> void:
	super._ready()
	if direction == 1:
		$WalkBug.flip_h = true
		$WalkBug/Legs.flip_h = true
		body.flip_h = true
	print(direction)

func _process(delta: float) -> void:
	super._process(delta)

func _physics_process(delta: float) -> void:
	if not attacking:
		move_local_x(direction * speed * delta)
		body.play("default")
	else:
		body.play("attack")
