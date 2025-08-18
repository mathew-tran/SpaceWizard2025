extends Node

func GetInfoPanel() -> InfoPanel:
	return get_tree().get_nodes_in_group("InfoPanel")[0]
