extends Sprite2D
class_name Building

@export var maxHealth = 100.0;
var health

var maxHealthbarSize = 191.0;

var parentShop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_health(maxHealth)


	
func set_health(newHealth : float) -> void:
	health = clamp(newHealth,0,maxHealth)
	$UI/HealthBar.size.x = 191.0 * (health / maxHealth)
	$UI/HealthBar.visible = health < maxHealth
	if health <= 0:
		parentShop.destroy()
