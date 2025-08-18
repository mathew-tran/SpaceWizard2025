extends Camera3D

@export var FollowObject : Node3D 
var FollowSpeed = 30

func MoveTowardsTargetPosition(delta):
	if FollowObject == null:
		return
	if global_position.distance_to(FollowObject.global_position) > 1:
		var dir = (FollowObject.global_position - global_position).normalized()
		dir.y = 0
		global_position += dir * FollowSpeed * delta
	
func _process(delta: float) -> void:
	MoveTowardsTargetPosition(delta)
