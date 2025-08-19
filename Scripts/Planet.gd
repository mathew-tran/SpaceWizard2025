extends Node3D

class_name Planet

@export var PlanetDataRef : PlanetData

var RotationSpeed = .2

func _ready() -> void:
	Helper.GetPlayer().OnPlayerStopped.connect(OnPlayerStopped)
	$AnimationPlayer.play("anim")
	Setup()
	
func OnPlayerStopped():
	if Helper.GetPlayer().global_position.distance_to(global_position) < 20:
		if $Timer.time_left != 0.0:
			return
		print("Accessed " + PlanetDataRef.PlanetName)
		await Helper.GetPlayer().PlayerEngageDialogue(load(PlanetDataRef.Dialogue))
		$Timer.start()
		
func Setup():
	if PlanetDataRef:
		for child in $PlanetMesh.get_children():
			child.queue_free()
		var mesh = load(PlanetDataRef.PlanetMesh).instantiate()
		$PlanetMesh.add_child(mesh)
		
func _process(delta: float) -> void:
	rotate_y(RotationSpeed * delta)
	

func _on_area_3d_mouse_entered() -> void:
	if PlanetDataRef:
		var data = {}
		data["title"] = PlanetDataRef.PlanetName
		Helper.GetInfoPanel().ShowInfo(data)


func _on_area_3d_mouse_exited() -> void:
	Helper.GetInfoPanel().ShowInfo(null)
