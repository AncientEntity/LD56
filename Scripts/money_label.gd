extends Label

@onready var game_manager: Node = %GameManager

func _ready() -> void:
	self.text = ("dolla dolla bills is now %d"%[game_manager.money])

func update_text():
	self.text = ("dolla dolla bills is now %d"%[game_manager.money])
