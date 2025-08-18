extends VBoxContainer

class_name InfoPanel

func _ready() -> void:
	ShowInfo(null)
	
func _process(delta: float) -> void:
	global_position = get_global_mouse_position() + Vector2(0, 16)

func ShowInfo(data):
	visible = true
	
	if data == null:
		visible = false
		return
	if data.has("title"):
		$Label.text=  data["title"]
		
	size = Vector2.ZERO
	await get_tree().process_frame
