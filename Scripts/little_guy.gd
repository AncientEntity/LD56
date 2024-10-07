extends PhysicsBody2D

var rng = RandomNumberGenerator.new()
@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight

var projectile = preload("res://Scenes/projectiles/baseprojectile.tscn")

var currentTask = CEnums.ECurrentTask.FIGHTING
var targetTaskObject = null
var stopDistance = 10

var fightSideBias = "LEFT"
var agrodEnemies = []
var damage = 5
var shootDelay = 1
var lastShotTime = 0

var moveSpeed = 100.0
var moveDirection = 0
var lastDirectionChangeTime = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owner = get_parent().owner
	pass # Replace with function body.

func _process(delta):
	if agrodEnemies.size() > 0 or %GameManager.roundState == CEnums.ERoundState.Invasion:
		currentTask = CEnums.ECurrentTask.FIGHTING
	else:
		currentTask = CEnums.ECurrentTask.IDLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match currentTask:
		CEnums.ECurrentTask.IDLE:
			IdleTask(delta)
		CEnums.ECurrentTask.HARVESTING: #todo
			WalkToObjective()
		CEnums.ECurrentTask.MINING: #todo
			WalkToObjective()
		CEnums.ECurrentTask.FIGHTING:
			Fight()
func Fight():
	if Time.get_unix_time_from_system() - lastShotTime < shootDelay:
		return
	
	if agrodEnemies.size() > 0:
		var newProjectile = projectile.instantiate()
		add_sibling(newProjectile)
		newProjectile.set_position(get_position())
		newProjectile.look_at(agrodEnemies[0].position)
		newProjectile.damage = damage
		
		lastShotTime = Time.get_unix_time_from_system()
	else:
		var direction = -1 if fightSideBias == "LEFT" else 1
		self.linear_velocity.x = moveSpeed * direction

func WalkToObjective():
	# todo
	var distanceToTarget = self.get_position().distance_to(targetTaskObject.get_position())

func WanderDirection():
	if ray_left.is_colliding():
		print("is colliding")
		if(ray_left.get_collider().get_name() == "LeftWall"):
			moveDirection = 1
			lastDirectionChangeTime = Time.get_unix_time_from_system() - rng.randi_range(-8,0)
			return
	elif ray_right.is_colliding():
		if(ray_right.get_collider().get_name() == "RightWall"):
			moveDirection = -1
			lastDirectionChangeTime = Time.get_unix_time_from_system() - rng.randi_range(-8,0)
			return

	if Time.get_unix_time_from_system() - lastDirectionChangeTime < 0 and moveDirection != 0:
		return
	
	moveDirection = rng.randi_range(-1,1)
	lastDirectionChangeTime = Time.get_unix_time_from_system() - rng.randi_range(-8,0)
	

func IdleTask(delta : float):
	WanderDirection()
	var mouse_position = get_global_mouse_position()
	var eyeLook = atan2(mouse_position.y - position.y,mouse_position.x - position.x)
	eyeLook = rad_to_deg(eyeLook)+180
	$BodySprite/LeftEye.rotation_degrees = eyeLook
	$BodySprite/RightEye.rotation_degrees = eyeLook
	
	var direction = moveSpeed * moveDirection
	self.linear_velocity.x = direction


func _on_agro_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("bugs"):
		agrodEnemies.append(area.get_parent())

func _on_agro_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("bugs"):
		agrodEnemies.erase(area.get_parent())
