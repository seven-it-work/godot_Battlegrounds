extends HBoxContainer
class_name Attribute
enum AttributeType{
	进度条,
	范围值,
	固定值
}
@export var 名称:String=""
@export var attributeType:AttributeType=AttributeType.进度条
## 进度条 范围值 必填
@export var min_value:float=0;
## 进度条 范围值 必填
@export var max_value:float=100;
## 进度条 必填
@export var step:float=0.01;
## 当前值
@export var value:String="";

@onready var progressBar:=$ProgressBar
@onready var valueLabel:=$"值"

func _process(delta: float) -> void:
	$Label.text=名称;
	progressBar.hide()
	valueLabel.hide()
	if attributeType==AttributeType.进度条:
		progressBar.show()
		progressBar.min_value=min_value
		progressBar.max_value=max_value
		progressBar.step=step
		progressBar.value=value.to_float()
	if attributeType==AttributeType.范围值:
		valueLabel.show()
		valueLabel.text="%s~%s"%[min_value,max_value]
	if attributeType==AttributeType.固定值:
		valueLabel.show()
		valueLabel.text=value
		
		
		
