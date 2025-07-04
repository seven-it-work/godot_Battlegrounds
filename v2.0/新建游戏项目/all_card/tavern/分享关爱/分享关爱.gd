extends CardData
func 使用触发():
	super.使用触发(player)
	player.分享关爱=true
	pass

func 是否能够使用(player:Player)->bool:
	return !player.分享关爱


func 执行(player:Player):
	var list=player.获取战斗中的牌()
	if list.is_empty():
		return
	var card=list.get(0)
	if player.是否在战斗中:
		var 敌人=player.fight.获取敌人(player)
		var 敌人战斗中的牌=敌人.获取战斗中的牌()
		if 敌人战斗中的牌.is_empty():
			return
		#敌人战斗中的牌
		# todo 这里用ai去写最近寻找算法
		# 如果两个都是偶数 或者 都是奇数，那么他们是对齐的
		# 否则他们是错位对其如下：
		# [占位] [空格] [占位] [空格] [占位]
		# [空格] [占位] [空格] [占位] [空格]
		# 非错位对齐如下：
		# [占位] [空格] [占位] [空格] [占位]
		# [空格] [空格] [占位] [空格] [空格]
		# 现在需要你找出最近的对象，比如：
		# [物一] [空格] [物二] [空格] [物三]
		# [空格] [品一] [空格] [品二] [空格]
		# [品一]最近的有两个[物一][物二] 同理 [品二]最近的有两个[物三][物二]
		# 例子2：
		# [物一] [空格] [物二] [空格] [物三]
		# [空格] [空格] [品一] [空格] [空格]
		# [品一]最近的只有[物二]
		# 现在让你写出这个算法。入参如下：物list,品list,[品一]对象 返回 [品一]对象的最近的物对象。list的长度最少为0，最多为7,list不包含空格（空格是我为了给你方便演示居中对齐时的位置关系，比如例子2中的3对1 那么1 需要居中就要补充空格）
		pass
	pass
	#<b>战斗开始时：</b>你最左边的随从会获得等同于距其最近的敌方随从的属性值。

# 返回某个 `品` 的最近 `物` 列表
func find_nearest_wu(wu_list: Array, pin_list: Array, target_pin) -> Array:
	var nearest_wu_list = []

	# 检查输入合法性
	if wu_list.is_empty() or pin_list.is_empty() or not target_pin in pin_list:
		return nearest_wu_list

	var wu_count = wu_list.size()
	var pin_count = pin_list.size()
	var target_index = pin_list.find(target_pin)

	# 判断是否错位
	var is_misaligned = (wu_count % 2) != (pin_count % 2)

	if is_misaligned:
		# 错位情况：品位于物的中间位置
		# 计算最近的物索引
		var wu_index = (target_index * 2 + 1) / 2  # 相当于 target_index + 0.5

		# 最近的物可能是 floor(wu_index) 和 ceil(wu_index)
		var lower_index = floor(wu_index)
		var upper_index = ceil(wu_index)

		if lower_index >= 0 and lower_index < wu_count:
			nearest_wu_list.append(wu_list[lower_index])
		if upper_index >= 0 and upper_index < wu_count and upper_index != lower_index:
			nearest_wu_list.append(wu_list[upper_index])
	else:
		# 对齐情况：品和物直接上下对齐
		var wu_index = target_index
		if wu_index >= 0 and wu_index < wu_count:
			nearest_wu_list.append(wu_list[wu_index])

		# 检查左右相邻的物（如果有）
		if wu_index - 1 >= 0:
			nearest_wu_list.append(wu_list[wu_index - 1])
		if wu_index + 1 < wu_count:
			nearest_wu_list.append(wu_list[wu_index + 1])

	return nearest_wu_list