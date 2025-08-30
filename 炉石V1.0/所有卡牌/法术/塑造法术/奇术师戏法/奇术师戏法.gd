extends Spellcraft

func 获取描述(dic:Dictionary={})->String:
	var 伤害=1+(player.本局对战使用的法术数量/4)*获取倍率()
	dic["atk"]=伤害
	dic["hp"]=伤害
	dic["个数"]=player.本局对战使用的法术数量%4
	return super.获取描述(dic)
	
## 由子类实现
func 法术使用处理():
	var 目标=选择目标对象.目标卡片
	var 伤害=1+(player.本局对战使用的法术数量/4)*获取倍率()
	if 目标:
		if 目标 is BaseMinion:
			目标.属性加成(AttributeBonus.build(
				名称,
				Vector2(伤害,伤害),
				名称,
			), 是否永久加成)
