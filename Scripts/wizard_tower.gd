extends Sprite2D

var shootDelay = 5
var lastShotTime
var chargeTime
var y_offset = 55

var agrodEnemies = []
var damage = 5.0

var fightSideBias = "LEFT"

const projectile = preload("res://Scenes/projectiles/Wizard_Ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(self.get_global_transform().origin.x > 0):
		fightSideBias = "RIGHT"
	lastShotTime = Time.get_unix_time_from_system()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_unix_time_from_system() - lastShotTime > shootDelay:
		Fire()

func Fire():
	#print("FIRE")
	if agrodEnemies.size() > 0:
		print("agro")
		var newProjectile = projectile.instantiate()
		add_sibling(newProjectile)
		newProjectile.damage = damage
		newProjectile.set_position(get_position())
		newProjectile.position.y -= y_offset
		newProjectile.look_at(agrodEnemies[0].position)
		
		lastShotTime = Time.get_unix_time_from_system()
	else:
		var direction = -1 if fightSideBias == "LEFT" else 1




func _on_agro_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("bugs"):
		print("entered ",area.get_parent())
		agrodEnemies.append(area.get_parent())

func _on_agro_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("bugs"):
		agrodEnemies.erase(area.get_parent())
