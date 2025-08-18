extends Node3D

var TargetPosition = Vector3.ZERO
var CameraRef : Camera3D

@export var PlaneNodePath : CSGMesh3D

var ShipSpeed = 20
func _ready() -> void:
	TargetPosition =  global_position
	CameraRef = get_viewport().get_camera_3d()
	
func MoveTowardsTargetPosition(delta):
	if global_position.distance_to(TargetPosition) > 1:
		var dir = (TargetPosition - global_position).normalized()
		global_position += dir * ShipSpeed * delta
		look_at(TargetPosition)
	else:
		TargetPosition = global_position

	
	
func _process(delta: float) -> void:
	MoveTowardsTargetPosition(delta)
	
	if Input.is_action_just_released("click"):
		var position2D = get_viewport().get_mouse_position()
		var position3D = PlaneNodePath.mesh.get_aabb().intersects_ray(
				CameraRef.project_ray_origin(position2D),
				CameraRef.project_ray_normal(position2D))
		if position3D:
			TargetPosition = position3D
