@tool
extends Object
class_name SignalUtils

## 断开所有连接
static func 断开所有连接(信号:Signal):
	for i in 信号.get_connections():
		var s=i.signal as Signal
		s.disconnect(i.callable)
		#print("断开信号",s.get_name())
