extends Sprite2D
class_name Building


@export var maxHealth = 100.0;
@onready var health_base = maxHealth
var health
@export var healthRegenSpeed = 0.25;

var maxHealthbarSize = 191.0;

var parentShop
@onready var on_ready = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_health(maxHealth)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_health(health + healthRegenSpeed * delta) #changed from 0.25 so longer buildings
	
func set_health(newHealth : float) -> void:	
	health = clamp(newHealth,0,maxHealth)
	$UI/HealthBar.size.x = 191.0 * (health / maxHealth)
	$UI/HealthBar.visible = health < maxHealth
	if health <= 0:
		parentShop.destroy()
