extends Sprite2D
class_name Building

@export var maxHealth = 100.0;
var health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = maxHealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
