extends BaseMinion


func 攻击其他随从(防御者: BaseMinion):
	await super.攻击其他随从(防御者)
	_移除目标关键词(防御者)

func _移除目标关键词(目标: BaseMinion):
	if 目标.复生:
		目标.复生 = false
	if 目标.嘲讽:
		目标.嘲讽 = false
