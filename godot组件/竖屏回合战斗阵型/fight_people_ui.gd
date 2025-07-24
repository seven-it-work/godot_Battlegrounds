extends PanelContainer

var fightEntity:FightEntity

func _process(delta: float) -> void:
	if fightEntity!=null:
		print(fightEntity.名称)
	pass

func _ready() -> void:
	pass

func 初始化(fightEntity:FightEntity):
	if fightEntity==null:
		return
	self.fightEntity=fightEntity
	$Label.text=fightEntity.名称
