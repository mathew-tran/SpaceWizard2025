extends Node

func GetInfoPanel() -> InfoPanel:
	return get_tree().get_nodes_in_group("InfoPanel")[0]

func GetPlayer() -> Player:
	return get_tree().get_nodes_in_group("Player")[0]
	
func GetObjectivePanel() -> ObjectivePanel:
	return get_tree().get_nodes_in_group("ObjectivePanel")[0]
