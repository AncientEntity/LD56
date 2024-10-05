extends PhysicsBody2D

var rng = RandomNumberGenerator.new()

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
	if abs(get_position().x-xBounds[0]) < stopDistance*8:
		moveDirection = 1
		lastDirectionChangeTime = Time.get_unix_time_from_system() - rng.randi_range(-8,0)
		return
	elif abs(get_position().x-xBounds[1]) < stopDistance*8:
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
