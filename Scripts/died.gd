extends Node2D

func _on_mm_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")

func _on_exit_button_button_down() -> void:
	get_tree().quit()

func _on_rs_button_button_down() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
