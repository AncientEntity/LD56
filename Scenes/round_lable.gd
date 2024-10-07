extends Label

@onready var game_manager: Node = %GameManager

func _ready() -> void:
	self.text = ("Round %d"%[game_manager.roundNumber])

func update_text():
	self.text = ("Round %d"%[game_manager.roundNumber])
