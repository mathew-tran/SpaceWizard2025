extends Panel

class_name ObjectivePanel

func ClearObjective():
	visible = false
	
func SetObjective(message):
	$Label.text = message
	visible = true
