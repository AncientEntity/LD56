extends PhysicsBody2D

var rng = RandomNumberGenerator.new()
@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight

enum ECurrentTask {
	IDLE,
	HARVESTING,
	MINING,
}
var currentTask = ECurrentTask.IDLE
var targetTaskObject = null
var stopDistance = 10

var moveSpeed = 100.0
var moveDirection = 0
var lastDirectionChangeTime = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owner = get_parent().owner
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match currentTask:
		ECurrentTask.IDLE:
			IdleTask(delta)
		ECurrentTask.HARVESTING: #todo
			WalkToObjective()
		ECurrentTask.MINING: #todo
			WalkToObjective()
	

func WalkToObjective():
	# todo
	var distanceToTarget = self.get_position().distance_to(targetTaskObject.get_position())

func WanderDirection():
	var xBounds = [%LeftWall.get_position().x,%RightWall.get_position().x]
	if ray_left.is_colliding():
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
