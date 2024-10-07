extends Sprite2D

@onready var game_manager: Node = %GameManager
@onready var glow: Sprite2D = $Glow
@onready var glow_2: Sprite2D = $Glow2

func _ready() -> void:
	pass

func damaged(collider : Node2D):
	game_manager.life -= 1
	if(game_manager.life >= 0):
		match game_manager.life:
			2:
				for child in $Candle.get_children():
					print("removed ",child.get_name())
					child.queue_free()
				$Glow.queue_free()
				collider.queue_free()
			1:
				for child in $Candle3.get_children():
					print("removed ",child.get_name())
					child.queue_free()
				$Glow2.queue_free()
				collider.queue_free()
			0:
				for child in $Candle2.get_children():
					print("removed ",child.get_name())
					child.queue_free()
				collider.queue_free()
				game_manager._lost()
