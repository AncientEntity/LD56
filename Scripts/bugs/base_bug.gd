extends Node2D
class_name BaseBug

var damage = 10
var attackRays = [$LeftRay,$RightRay]
var attacking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	attacking = false
	for ray in attackRays:
		if ray.is_colliding() and ray.get_collider():
			if(ray.get_collider().is_in_group("building")):
				var building = ray.get_collider().get_parent()
				building.set_health(building.health - delta * damage)
				attacking = true


#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.is_in_group("building"):
		#overlappedBuildings.append(area.get_parent())
#
#func _on_area_2d_area_exited(area: Area2D) -> void:
	#if area.is_in_group("building"):
		#overlappedBuildings.erase(area.get_parent())
