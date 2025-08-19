extends Node

var MainProgression = "START"

func ChangeObjective(objectiveName):
	Helper.GetObjectivePanel().SetObjective(objectiveName)

func ClearObjective():
	Helper.GetObjectivePanel().ClearObjective()
