extends Node2D
class_name BaseBug

var maxHealthbarSize = 191.0;
var health
var maxHealth = 100.0
var damage = 10
var base_kill = 200

@onready var attackRays = [$LeftRay,$RightRay]
var attacking = false

@onready var gravityRay: RayCast2D = $DownRay
var gravity = 50
var velX = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_health(maxHealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if(!gravityRay.is_colliding()):
		velX += gravity * delta
		self.position.y += velX
	else:
		velX = 0
	
	attacking = false
	for ray in attackRays:
		if ray.is_colliding() and ray.get_collider():
			if(ray.get_collider().is_in_group("building")):
				var building = ray.get_collider().get_parent()
				building.set_health(building.health - delta * damage)
				attacking = true
			elif(ray.get_collider().get_parent().get_name() == "Pumpkin"):
				ray.get_collider().get_parent().damaged(self)


func set_health(newHealth):
	health = clamp(newHealth,0.0,maxHealth)
	$HealthBar.size.x = 191.0 * (health / maxHealth)
	$HealthBar.visible = health < maxHealth
	if health <= 0:
		queue_free()
		#%GameManager.money += base_kill * self.scale.x
