extends Building
var guyScene = preload("res://Scenes/little_guy.tscn")
var myGuy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	myGuy = guyScene.instantiate()
	get_tree().get_root().get_node("GameScene/WORLD").add_child(myGuy)
	myGuy.global_position = $Sprite2D.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _exit_tree() -> void:
	if myGuy:
		myGuy.queue_free()
