extends Sprite2D
class_name Building

@export var maxHealth = 100.0;
var health

var maxHealthbarSize = 191.0;

var parentShop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_health(maxHealth)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_health(health - 0.01) #changed from 0.25 so longer buildings
	
func set_health(newHealth : float) -> void:
	health = newHealth
	$UI/HealthBar.size.x = 191.0 * (health / maxHealth)
	$UI/HealthBar.visible = health < maxHealth
	if health <= 0:
		parentShop.destroy()
		
