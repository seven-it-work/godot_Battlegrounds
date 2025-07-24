extends Node
class_name FightGroupEntity


@export var groupIndex:Dictionary[int,FightEntity]={}

func get_all_list()->Array[FightEntity]:
	return groupIndex.values()

func get_by_index(index:int)->FightEntity:
	return groupIndex.get(index)
