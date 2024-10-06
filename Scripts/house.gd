extends Building
var guyScene = preload("res://Scenes/little_guy.tscn")

var guyCount = 2
var myGuys = []

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	for i in guyCount:
		var newGuy = guyScene.instantiate()
		get_tree().get_root().get_node("GameScene/WORLD").add_child(newGuy)
		newGuy.global_position = $Sprite2D.global_position + Vector2(rng.randi_range(-100,100),0)
		myGuys.append(newGuy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _exit_tree() -> void:
	for myGuy in myGuys:
		if myGuy:
			myGuy.queue_free()
