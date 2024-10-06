extends Area2D

var speed = 300
var damage = 10
var isFriendly = true

var targetGroup = "bugs" if isFriendly else "building"

func _physics_process(delta: float) -> void:
	move_local_x(speed * delta)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(targetGroup):
		area.get_parent().set_health(area.get_parent().health - damage)
		queue_free()
