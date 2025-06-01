extends Node
class_name CardsUtils
static var COMMON_CODITION={
	"是否出现在酒馆":CardFindCondition.build(
		"是否出现在酒馆",true,CardFindCondition.ConditionEnum.等于
	),
	"随从":CardFindCondition.build(
		"cardType",BaseCard.CardTypeEnum.MINION,CardFindCondition.ConditionEnum.等于
	),
	"法术":CardFindCondition.build(
		"cardType",BaseCard.CardTypeEnum.SPELL,CardFindCondition.ConditionEnum.等于
	)
}

# 查询
static func find_card(conditionList:Array[CardFindCondition]):
	return Globals.all_card.values().filter(func (card):
		var all_result:Array[bool]=[]
		for i in conditionList:
			var re=false
			if i.key in card:
				match i.判断:
					CardFindCondition.ConditionEnum.大于:
						re=(card[i.key]>i.value)
					CardFindCondition.ConditionEnum.等于:
						re=(card[i.key]==i.value)
					CardFindCondition.ConditionEnum.小于:
						re=(card[i.key]<i.value)
					CardFindCondition.ConditionEnum.大于等于:
						re=(card[i.key]>=i.value)
					CardFindCondition.ConditionEnum.小于等于:
						re=(card[i.key]<=i.value)
					CardFindCondition.ConditionEnum.不等于:
						re=(card[i.key]!=i.value)
					CardFindCondition.ConditionEnum.在:
						re=(card[i.key].has(i.value))
					CardFindCondition.ConditionEnum.不在:
						re=(!card[i.key].has(i.value))
					_:
						pass
			if !re and i.且或:
				return false
			all_result.append(re)
		return all_result.any(func(b): return b)
		)
	pass

# 递归扫描目录及子目录
static func scan_scenes_recursive(base_path: String, current_path: String = "",scene_dict:Dictionary = {}):
	var full_path = base_path.path_join(current_path) if current_path else base_path
	var dir = DirAccess.open(full_path)
	if not dir:
		printerr("无法打开目录: ", full_path)
		return
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			# 忽略特殊目录
			if file_name != "." and file_name != "..":
				# 递归扫描子目录
				var new_path = current_path.path_join(file_name) if current_path else file_name
				scan_scenes_recursive(base_path, new_path,scene_dict)
		elif file_name.ends_with(".tscn"):
			# 获取不带扩展名的文件名
			var base_name = file_name.trim_suffix(".tscn")
			# 获取资源完整路径
			var resource_path = full_path.path_join(file_name)
			# 添加到字典
			scene_dict[base_name] = load(resource_path).instantiate()
		file_name = dir.get_next()
	return scene_dict
