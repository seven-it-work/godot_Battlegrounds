@tool
extends Object
class_name StrUtils

## 字符串工具类，参考 Hutool-Utils 的 StrUtils 实现

## 判断字符串是否为空
static func is_empty(s: String) -> bool:
	return s == null or s.length() == 0

## 判断字符串是否不为空
static func is_not_empty(s: String) -> bool:
	return not is_empty(s)

## 判断字符串是否为空或仅包含空白字符
static func contains_whitespace(s: String) -> bool:
	if is_empty(s):
		return false
	var whitespace_chars = [" ", "\t", "\n", "\r", "\v", "\f"]
	for i in range(s.length()):
		if s[i] in whitespace_chars:
			return true
	return false

## 判断字符串是否为空或仅包含空白字符
static func is_blank(s: String) -> bool:
	if is_empty(s):
		return true
	var whitespace_codes = [32, 9, 10, 11, 12, 13, 0xA0]  # 常见空白字符代码
	for i in range(s.length()):
		var code = s.unicode_at(i)
		if not code in whitespace_codes:
			return false
	return true

## 判断字符串是否不为空且包含非空白字符
static func is_not_blank(s: String) -> bool:
	return not is_blank(s)

## 去除字符串两端的空白字符
static func trim(s: String) -> String:
	return s.strip_edges()

## 去除字符串左侧的空白字符
static func trim_start(s: String) -> String:
	return s.strip_edges(true, false)

## 去除字符串右侧的空白字符
static func trim_end(s: String) -> String:
	return s.strip_edges(false, true)

## 去除字符串中的所有空白字符
static func trim_all(s: String) -> String:
	return s.replace(" ", "").replace("\t", "").replace("\n", "").replace("\r", "")

## 截取字符串
static func substring(s: String, start: int, end: int = -1) -> String:
	if is_empty(s):
		return s
	var len = s.length()
	if start < 0:
		start = len + start
	if end == -1:
		end = len
	elif end < 0:
		end = len + end
	return s.substr(start, end - start)

## 截取字符串左侧指定长度的字符
static func left(s: String, len: int) -> String:
	if is_empty(s):
		return s
	if len <= 0:
		return ""
	return s.substr(0, min(len, s.length()))

## 截取字符串右侧指定长度的字符
static func right(s: String, len: int) -> String:
	if is_empty(s):
		return s
	if len <= 0:
		return ""
	var str_len = s.length()
	return s.substr(max(0, str_len - len), min(len, str_len))

## 获取字符串长度，null安全
static func length(s: String) -> int:
	return 0 if s == null else s.length()

## 字符串比较，忽略大小写
static func equals_ignore_case(a: String, b: String) -> bool:
	if a == null and b == null:
		return true
	if a == null or b == null:
		return false
	return a.to_lower() == b.to_lower()

## 检查字符串是否以指定前缀开头
static func starts_with(s: String, prefix: String, ignore_case: bool = false) -> bool:
	if is_empty(s) or is_empty(prefix):
		return false
	if ignore_case:
		return s.to_lower().begins_with(prefix.to_lower())
	return s.begins_with(prefix)

## 检查字符串是否以指定后缀结尾
static func ends_with(s: String, suffix: String, ignore_case: bool = false) -> bool:
	if is_empty(s) or is_empty(suffix):
		return false
	if ignore_case:
		return s.to_lower().ends_with(suffix.to_lower())
	return s.ends_with(suffix)

## 检查字符串是否包含另一字符串
static func contains(s: String, search_str: String, ignore_case: bool = false) -> bool:
	if is_empty(s) or is_empty(search_str):
		return false
	if ignore_case:
		return s.to_lower().contains(search_str.to_lower())
	return s.contains(search_str)


## 重复字符串指定次数
static func repeat(s: String, count: int) -> String:
	if is_empty(s) or count <= 0:
		return ""
	return s.repeat(count)

## 填充字符串到指定长度，左侧填充
static func pad_start(s: String, length: int, pad_char: String = " ") -> String:
	if s == null or pad_char.is_empty():
		return s
	var str_len = s.length()
	if str_len >= length:
		return s
	return pad_char.repeat(length - str_len) + s

## 填充字符串到指定长度，右侧填充
static func pad_end(s: String, length: int, pad_char: String = " ") -> String:
	if s == null or pad_char.is_empty():
		return s
	var str_len = s.length()
	if str_len >= length:
		return s
	return s + pad_char.repeat(length - str_len)

## 删除字符串中的所有指定字符
static func remove(s: String, char_to_remove: String) -> String:
	if is_empty(s) or is_empty(char_to_remove):
		return s
	return s.replace(char_to_remove, "")

## 删除字符串中的所有空白字符
static func remove_whitespace(s: String) -> String:
	if is_empty(s):
		return s
	var result = ""
	var whitespace_codes = [32, 9, 10, 11, 12, 13, 0xA0]  # 常见空白字符代码
	for i in range(s.length()):
		var code = s.unicode_at(i)
		if not code in whitespace_codes:
			result += s[i]
	return result

## 替换字符串中的指定内容
static func replace(s: String, search_value: String, replace_value: String, ignore_case: bool = false) -> String:
	if is_empty(s) or is_empty(search_value):
		return s
	if ignore_case:
		var regex = RegEx.new()
		regex.compile("(?i)" + search_value)
		return regex.sub(s, replace_value, true)
	return s.replace(search_value, replace_value)

## 将字符串转换为驼峰命名法
static func to_camel_case(s: String) -> String:
	if is_empty(s):
		return s
	var result = ""
	var capitalize_next = false
	for i in range(s.length()):
		var c = s[i]
		if c == '_' or c == '-' or c == ' ':
			capitalize_next = true
		else:
			if capitalize_next:
				result += c.to_upper()
				capitalize_next = false
			else:
				result += c.to_lower()
	return result

## 将字符串转换为下划线命名法
static func to_snake_case(s: String) -> String:
	if is_empty(s):
		return s
	var result = ""
	for i in range(s.length()):
		var c = s[i]
		# 检查是否是大写字母（Godot 4.4.1 方式）
		if c >= "A" and c <= "Z":
			# 在非首字母且前一个字符不是大写，或者后面跟着小写时添加下划线
			if i > 0:
				var prev_char = s[i-1]
				var next_char = s[i+1] if i < s.length()-1 else ""
				if (prev_char < "A" or prev_char > "Z") or \
				   (next_char != "" and (next_char >= "a" and next_char <= "z")):
					result += "_"
			result += c.to_lower()
		else:
			result += c
	return result.to_lower()

## 将字符串首字母大写
static func capitalize(s: String) -> String:
	if is_empty(s):
		return s
	return s[0].to_upper() + s.substr(1)

## 将字符串首字母小写
static func uncapitalize(s: String) -> String:
	if is_empty(s):
		return s
	return s[0].to_lower() + s.substr(1)

## 反转字符串
static func reverse(s: String) -> String:
	if is_empty(s):
		return s
	var result = ""
	for i in range(s.length()-1, -1, -1):
		result += s[i]
	return result

## 统计子字符串出现的次数
static func count_matches(s: String, sub: String) -> int:
	if is_empty(s) or is_empty(sub):
		return 0
	var count = 0
	var index = 0
	while true:
		index = s.find(sub, index)
		if index == -1:
			break
		count += 1
		index += sub.length()
	return count

## 检查字符串是否只包含字母
static func is_alpha(s: String) -> bool:
	if is_empty(s):
		return false
	for c in s:
		if not c.is_valid_unicode_identifier():
			return false
	return true

## 检查字符串是否只包含数字
static func is_numeric(s: String) -> bool:
	if is_empty(s):
		return false
	for c in s:
		if not c.is_valid_int():
			return false
	return true

## 检查字符串是否只包含字母或数字
static func is_alphanumeric(s: String) -> bool:
	if is_empty(s):
		return false
	for c in s:
		if not (c.is_valid_unicode_identifier() or c.is_valid_int()):
			return false
	return true

## 连接字符串数组
static func join(strings: Array, separator: String = "") -> String:
	if strings == null or strings.is_empty():
		return ""
	var result = str(strings[0])
	for i in range(1, strings.size()):
		result += separator + str(strings[i])
	return result

## 分割字符串为数组
static func split(s: String, delimiter: String, ignore_case: bool = false) -> Array:
	if is_empty(s):
		return []
	if is_empty(delimiter):
		return [s]
	if ignore_case:
		var regex = RegEx.new()
		regex.compile("(?i)" + delimiter)
		return regex.split(s)
	return s.split(delimiter)

## 将字符串转换为布尔值
static func to_bool(s: String) -> bool:
	if is_empty(s):
		return false
	var lower = s.to_lower().strip_edges()
	return lower == "true" or lower == "1" or lower == "yes" or lower == "on"

## 检查字符串是否为有效的电子邮件地址
static func is_email(s: String) -> bool:
	if is_empty(s):
		return false
	var regex = RegEx.new()
	regex.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")
	return regex.search(s) != null

## 检查字符串是否为有效的URL
static func is_url(s: String) -> bool:
	if is_empty(s):
		return false
	var regex = RegEx.new()
	regex.compile("^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$")
	return regex.search(s) != null

## 检查字符串是否为有效的IP地址
static func is_ip(s: String) -> bool:
	if is_empty(s):
		return false
	var regex = RegEx.new()
	regex.compile("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
	return regex.search(s) != null

## 检查字符串是否为有效的十六进制颜色代码
static func is_hex_color(s: String) -> bool:
	if is_empty(s):
		return false
	var regex = RegEx.new()
	regex.compile("^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$")
	return regex.search(s) != null

## 生成随机字符串
static func random(length: int = 16, chars: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String:
	if length <= 0 or is_empty(chars):
		return ""
	var result = ""
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in range(length):
		result += chars[rng.randi() % chars.length()]
	return result

## 字符串掩码处理（保护敏感信息）
static func mask(s: String, start: int = 0, end: int = -1, mask_char: String = "*") -> String:
	if is_empty(s):
		return s
	var str_len = s.length()
	if start < 0:
		start = 0
	if end < 0 or end > str_len:
		end = str_len
	if start >= end:
		return s
	return s.substr(0, start) + mask_char.repeat(end - start) + s.substr(end)
