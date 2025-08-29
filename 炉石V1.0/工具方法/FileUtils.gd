@tool
extends Node
class_name FileUtils

# 复制文件:cite[2]
static func copy_file(source_path: String, destination_path: String) -> int:
	if not FileAccess.file_exists(source_path):
		printerr("Source file does not exist: " + source_path)
		return ERR_FILE_NOT_FOUND

	var source_file := FileAccess.open(source_path, FileAccess.READ)
	if not source_file:
		printerr("Failed to open source file: " + source_path + ", Error: " + str(FileAccess.get_open_error()))
		return FAILED

	var dest_dir := destination_path.get_base_dir()
	if not DirAccess.dir_exists_absolute(dest_dir):
		var err := DirAccess.make_dir_recursive_absolute(dest_dir)
		if err != OK:
			printerr("Failed to create destination directory: " + dest_dir)
			source_file.close()
			return err

	var dest_file := FileAccess.open(destination_path, FileAccess.WRITE)
	if not dest_file:
		printerr("Failed to open destination file: " + destination_path + ", Error: " + str(FileAccess.get_open_error()))
		source_file.close()
		return FAILED

	var content := source_file.get_as_text()
	dest_file.store_string(content)

	source_file.close()
	dest_file.close()
	return OK

# 复制目录（递归）:cite[2]
static func copy_directory(source_dir: String, destination_dir: String) -> int:
	if not DirAccess.dir_exists_absolute(source_dir):
		printerr("Source directory does not exist: " + source_dir)
		return ERR_FILE_NOT_FOUND

	# 创建目标目录
	var err := DirAccess.make_dir_recursive_absolute(destination_dir)
	if err != OK:
		printerr("Failed to create destination directory: " + destination_dir)
		return err

	var dir := DirAccess.open(source_dir)
	if not dir:
		printerr("Failed to open source directory: " + source_dir)
		return FAILED

	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			if file_name != "." and file_name != "..":
				var sub_source := source_dir.path_join(file_name)
				var sub_dest := destination_dir.path_join(file_name)
				err = copy_directory(sub_source, sub_dest)
				if err != OK:
					return err
		else:
			var file_source := source_dir.path_join(file_name)
			var file_dest := destination_dir.path_join(file_name)
			err = copy_file(file_source, file_dest)
			if err != OK:
				return err
		file_name = dir.get_next()

	dir.list_dir_end()
	return OK

# 删除目录（递归）:cite[2]
static func delete_directory(path: String) -> int:
	if not DirAccess.dir_exists_absolute(path):
		push_warning("Directory does not exist, nothing to delete: " + path)
		return OK # 不存在则视为删除成功

	var dir := DirAccess.open(path)
	if not dir:
		printerr("Failed to open directory: " + path)
		return FAILED

	var err := dir.list_dir_begin()
	if err != OK:
		printerr("Failed to list directory: " + path)
		return err

	var file_name := dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			if file_name != "." and file_name != "..":
				var sub_dir := path.path_join(file_name)
				err = delete_directory(sub_dir)
				if err != OK:
					return err
		else:
			err = dir.remove(file_name)
			if err != OK:
				printerr("Failed to remove file: " + file_name + " in directory: " + path)
				return err
		file_name = dir.get_next()

	dir.list_dir_end()

	# 现在删除空目录本身
	err = DirAccess.remove_absolute(path)
	if err != OK:
		printerr("Failed to remove directory: " + path)
		return err

	return OK

# 读取文件内容为字符串:cite[2]:cite[3]
static func read_file_to_string(file_path: String) -> String:
	if not FileAccess.file_exists(file_path):
		printerr("File does not exist: " + file_path)
		return ""

	var file := FileAccess.open(file_path, FileAccess.READ)
	if not file:
		printerr("Failed to open file for reading: " + file_path + ", Error: " + str(FileAccess.get_open_error()))
		return ""

	var content := file.get_as_text()
	file.close()
	return content

# 将字符串写入文件:cite[2]
static func write_string_to_file(file_path: String, content: String, create_dirs: bool = false) -> int:
	if create_dirs:
		var dir := file_path.get_base_dir()
		if not DirAccess.dir_exists_absolute(dir):
			var err := DirAccess.make_dir_recursive_absolute(dir)
			if err != OK:
				printerr("Failed to create directory: " + dir)
				return err

	var file := FileAccess.open(file_path, FileAccess.WRITE)
	if not file:
		printerr("Failed to open file for writing: " + file_path + ", Error: " + str(FileAccess.get_open_error()))
		return FAILED

	file.store_string(content)
	file.close()
	return OK

# 确保目录存在，如果不存在则创建（递归创建）
static func ensure_directory_exists(dir_path: String):
	if DirAccess.dir_exists_absolute(dir_path):
		return
	var err := DirAccess.make_dir_recursive_absolute(dir_path)
	if err != OK:
		printerr("Failed to create directory: " + dir_path + ", Error: " + str(err))
	


# 检查文件是否存在:cite[2]
static func file_exists(file_path: String) -> bool:
	return FileAccess.file_exists(file_path)

# 检查目录是否存在
static func directory_exists(dir_path: String) -> bool:
	return DirAccess.dir_exists_absolute(dir_path)

# 获取文件大小（字节）:cite[2]
static func get_file_size(file_path: String) -> int:
	if not FileAccess.file_exists(file_path):
		printerr("File does not exist: " + file_path)
		return -1

	var file := FileAccess.open(file_path, FileAccess.READ)
	if not file:
		printerr("Failed to open file: " + file_path + ", Error: " + str(FileAccess.get_open_error()))
		return -1

	var size := file.get_length()
	file.close()
	return size

# 移动文件:cite[2]
static func move_file(source_path: String, destination_path: String) -> int:
	var err := copy_file(source_path, destination_path)
	if err != OK:
		return err

	err = delete_file(source_path)
	if err != OK:
		# 如果删除失败，尝试清理已复制的文件
		delete_file(destination_path)
		return err

	return OK

# 移动目录:cite[2]
static func move_directory(source_dir: String, destination_dir: String) -> int:
	var err := copy_directory(source_dir, destination_dir)
	if err != OK:
		return err

	err = delete_directory(source_dir)
	if err != OK:
		delete_directory(destination_dir)
		return err

	return OK

# 删除文件:cite[2]
static func delete_file(file_path: String) -> int:
	if not FileAccess.file_exists(file_path):
		push_warning("File does not exist, nothing to delete: " + file_path)
		return OK

	var err := DirAccess.remove_absolute(file_path)
	if err != OK:
		printerr("Failed to delete file: " + file_path)
		return err

	return OK

# 获取目录下的文件列表（可选递归）:cite[2]
static func list_files_in_directory(dir_path: String, recursive: bool = false, include_dirs: bool = false) -> Array[String]:
	var file_list: Array[String] = []

	if not DirAccess.dir_exists_absolute(dir_path):
		printerr("Directory does not exist: " + dir_path)
		return file_list

	var dir := DirAccess.open(dir_path)
	if not dir:
		printerr("Failed to open directory: " + dir_path)
		return file_list

	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		if file_name == "." or file_name == "..":
			file_name = dir.get_next()
			continue

		var full_path := dir_path.path_join(file_name)

		if dir.current_is_dir():
			if include_dirs:
				file_list.append(full_path)
			if recursive:
				var sub_files := list_files_in_directory(full_path, recursive, include_dirs)
				file_list.append_array(sub_files)
		else:
			file_list.append(full_path)

		file_name = dir.get_next()

	dir.list_dir_end()
	return file_list

# 读取文件为PackedByteArray:cite[2]
static func read_file_to_bytes(file_path: String) -> PackedByteArray:
	if not FileAccess.file_exists(file_path):
		printerr("File does not exist: " + file_path)
		return PackedByteArray()

	var file := FileAccess.open(file_path, FileAccess.READ)
	if not file:
		printerr("Failed to open file for reading: " + file_path + ", Error: " + str(FileAccess.get_open_error()))
		return PackedByteArray()

	var bytes := file.get_buffer(file.get_length())
	file.close()
	return bytes

# 将PackedByteArray写入文件:cite[2]
static func write_bytes_to_file(file_path: String, data: PackedByteArray, create_dirs: bool = false) -> int:
	if create_dirs:
		var dir := file_path.get_base_dir()
		if not DirAccess.dir_exists_absolute(dir):
			var err := DirAccess.make_dir_recursive_absolute(dir)
			if err != OK:
				printerr("Failed to create directory: " + dir)
				return err

	var file := FileAccess.open(file_path, FileAccess.WRITE)
	if not file:
		printerr("Failed to open file for writing: " + file_path + ", Error: " + str(FileAccess.get_open_error()))
		return FAILED

	file.store_buffer(data)
	file.close()
	return OK
