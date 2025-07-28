extends PanelContainer
@export var build:Build
signal 构建

func 初始化(build:Build):
	self.build=build
	$"VBoxContainer/名称".text="Lv.%s %s"%[build.lv,build.名称]
	$"VBoxContainer/描述".text=build.获取描述()
	for i in $"VBoxContainer/消耗资源".get_children():
		i.queue_free()
	
	
	for i in NeedResource.资源名称:
		var label=Label.new()
		label.text="%s：%s"%[i,build.消耗资源[i]]
		$"VBoxContainer/消耗资源".add_child(label)
		
	
func _process(delta: float) -> void:
	if build:
		pass


func _on_构建_pressed() -> void:
	构建.emit()
	pass # Replace with function body.
