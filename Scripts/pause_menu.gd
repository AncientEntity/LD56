extends Control

func _on_mm_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
	Engine.time_scale = 1


func _on_exit_button_button_down() -> void:
	get_tree().quit()


func _on_rs_button_button_down() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1
