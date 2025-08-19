extends CharacterBody3D

class_name Player

var TargetPosition = Vector3.ZERO
var CameraRef : Camera3D

@export var PlaneNodePath : CSGMesh3D

var ShipSpeed = 600

signal OnPlayerStopped

enum STATE {
	IN_GAME,
	IN_UI
}

var PlayerState = STATE.IN_GAME

func _ready() -> void:
	TargetPosition =  global_position
	CameraRef = get_viewport().get_camera_3d()
	PlayerEngageDialogue(load("res://Content/Dialogues/OpeningDialogue.dialogue"))
	
func ChangeState(state : STATE):
	PlayerState = state
	
func PlayerEngageDialogue(dialogue):
	ChangeState(STATE.IN_UI)
	DialogueManager.show_example_dialogue_balloon(dialogue, "start")
	await DialogueManager.dialogue_ended
	ChangeState(STATE.IN_GAME)
	
func IsInGame():
	return PlayerState == STATE.IN_GAME
	
func MoveTowardsTargetPosition(delta):
	if global_position.distance_to(TargetPosition) > 1:
		var dir = (TargetPosition - global_position).normalized()
		velocity = dir * ShipSpeed * delta
		if move_and_slide():
			TargetPosition = global_position
			OnPlayerStopped.emit()
			$CPUParticles3D.emitting = false
			return
			
		look_at(TargetPosition)
		$CPUParticles3D.emitting = true
	else:
		TargetPosition = global_position
		$CPUParticles3D.emitting = false

	
	
func _process(delta: float) -> void:
	if IsInGame() == false:
		return
	MoveTowardsTargetPosition(delta)
	
	if Input.is_action_pressed("click"):
		var position2D = get_viewport().get_mouse_position()
		var position3D = PlaneNodePath.mesh.get_aabb().intersects_ray(
				CameraRef.project_ray_origin(position2D),
				CameraRef.project_ray_normal(position2D))
		if position3D:
			TargetPosition = position3D
