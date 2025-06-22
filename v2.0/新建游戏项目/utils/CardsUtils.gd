extends Node
class_name CardsUtils
#static var COMMON_CODITION={
	#"是否出现在酒馆":CardFindCondition.build(
		#"是否出现在酒馆",true,CardFindCondition.ConditionEnum.等于
	#),
	#"随从":CardFindCondition.build(
		#"cardType",BaseCard.CardTypeEnum.MINION,CardFindCondition.ConditionEnum.等于
	#),
	#"法术":CardFindCondition.build(
		#"cardType",BaseCard.CardTypeEnum.SPELL,CardFindCondition.ConditionEnum.等于
	#)
#}
#
#static func 合成三连(card1:BaseCard,card2:BaseCard,card3:BaseCard)->BaseCard:
	#var result=card1
	#result.is_gold=true
	#card1.属性加成.append_array(card2.属性加成)
	#card2.属性加成.append_array(card3.属性加成)
	#return result

## 下载网络图片并保存到本地
## @param url: 图片下载地址，例如 "https://art.hearthstonejson.com/v1/orig/BG20_GEM.png"
## @param save_path: 保存路径，例如 "C:/" 或 "user://images/"
## @param file_name: 可选，保存的文件名，如果不提供则使用URL中的文件名
## @return: 返回保存的完整路径，失败返回空字符串
static func download_image(image_url: String, save_path_with_filename: String) -> bool:
	# 创建临时节点来执行下载
	var downloader = Node.new()
	Engine.get_main_loop().root.call_deferred("add_child",downloader)
	
	# 准备返回结果
	var success := false
	
	# 创建HTTP请求
	var http_request = HTTPRequest.new()
	downloader.add_child(http_request)
	await http_request.tree_entered
	
	# 使用信号等待下载完成
	var completed = false
	
	# 连接完成信号
	http_request.request_completed.connect(
		func(result, response_code, headers, body):
			completed = true
			if result != HTTPRequest.RESULT_SUCCESS:
				push_error("下载失败，错误代码: ", result)
				downloader.queue_free()
				return
			
			# 提取目录路径
			var dir_path = save_path_with_filename.get_base_dir()
			
			# 确保目录存在
			var dir = DirAccess.open(dir_path)
			if not dir:
				if DirAccess.make_dir_recursive_absolute(dir_path) != OK:
					push_error("无法创建目录: ", dir_path)
					downloader.queue_free()
					return
			
			# 保存图片数据
			var file = FileAccess.open(save_path_with_filename, FileAccess.WRITE)
			if file:
				file.store_buffer(body)
				file.close()
				success = true
				print("图片已保存到: ", save_path_with_filename)
			else:
				push_error("无法写入文件: ", save_path_with_filename)
	)
	
	# 开始请求
	var error = http_request.request(image_url)
	if error != OK:
		push_error("请求创建失败: ", error)
		downloader.queue_free()
		return false
	
	# 等待下载完成
	while not completed:
		await downloader.get_tree().process_frame
	downloader.queue_free()
	return success
	

# 查询
#static func find_card(conditionList:Array[CardFindCondition])->Array:
	#return Globals.all_card.values().filter(func (card):
		#var all_result:Array[bool]=[]
		#for i in conditionList:
			#var re=false
			#if i.key in card:
				#match i.判断:
					#CardFindCondition.ConditionEnum.大于:
						#re=(card[i.key]>i.value)
					#CardFindCondition.ConditionEnum.等于:
						#re=(card[i.key]==i.value)
					#CardFindCondition.ConditionEnum.小于:
						#re=(card[i.key]<i.value)
					#CardFindCondition.ConditionEnum.大于等于:
						#re=(card[i.key]>=i.value)
					#CardFindCondition.ConditionEnum.小于等于:
						#re=(card[i.key]<=i.value)
					#CardFindCondition.ConditionEnum.不等于:
						#re=(card[i.key]!=i.value)
					#CardFindCondition.ConditionEnum.在:
						#re=(card[i.key].has(i.value))
					#CardFindCondition.ConditionEnum.不在:
						#re=(!card[i.key].has(i.value))
					#_:
						#pass
			#if !re and i.且或:
				#return false
			#all_result.append(re)
		#return all_result.any(func(b): return b)
		#)
	#pass

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
			var data=load(resource_path).instantiate()
			data.文件路径=full_path
			data.文件名=base_name
			scene_dict[base_name] = data
		file_name = dir.get_next()
	return scene_dict
