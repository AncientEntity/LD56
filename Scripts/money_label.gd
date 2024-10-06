extends Label

@onready var game_manager: Node = %GameManager

func _ready() -> void:
	self.text = ("$%d"%[game_manager.money])

func update_text():
	self.text = ("$%d"%[game_manager.money])
