@tool
extends Node
class_name FileUtis

"""
递归获取目录下所有文件
参数:
path: 要搜索的目录路径
filter: 可选的Callable过滤函数，接受文件路径作为参数，返回bool值决定是否包含该文件
返回:
包含所有
匹配文件路径的数组
"""
static func get_all_files_in_directory(path: String, filter: Callable = Callable()) -> Array[String]:
	var files :Array[String]= []
	var dir := DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name := dir.get_next()
		
		while file_name != "":
			if file_name != "." and file_name != "..":
				var full_path := path.path_join(file_name)
				
				if dir.current_is_dir():
					# 如果是目录，递归调用
					files.append_array(get_all_files_in_directory(full_path, filter))
				else:
					# 如果是文件，检查过滤条件
					if not filter.is_valid() or filter.call(full_path):
						files.append(full_path)
			
			file_name = dir.get_next()
		
		dir.list_dir_end()
	
	return files
