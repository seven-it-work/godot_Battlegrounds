## 可拖拽的卡片
extends PanelContainer
class_name BaseDragableCard

signal drag_started
signal drag_stoped

## 拖拽标识
var dragable := false

## 开始拖拽
func start_drag():
#	这里就没有用
	dragable = true
	modulate.a = 0.9 
	drag_started.emit()

## 结束拖拽
func stop_drag():
#	这里就没有用
	dragable = false
	modulate.a = 1
	drag_stoped.emit()

## 释放正在拖拽
func is_dragable():
	return dragable
