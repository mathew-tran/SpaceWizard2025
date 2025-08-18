extends Node3D

func _ready() -> void:
	$AnimationPlayer.play("anim")


func _on_area_3d_mouse_entered() -> void:
	print(name + "entered")
	var data = {}
	data["title"] = "Planet"
	Helper.GetInfoPanel().ShowInfo(data)


func _on_area_3d_mouse_exited() -> void:
	Helper.GetInfoPanel().ShowInfo(null)
