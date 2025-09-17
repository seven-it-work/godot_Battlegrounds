extends BaseSpell

func 法术使用处理():
	var buff_value: int = 1 * 获取倍率() # +1/+1 for normal, +2/+2 for golden
	# Assuming there's a way to enhance blood gem effects
	# This is a placeholder implementation
	print('无畏的食客选择：增强鲜血宝石效果 +%d/+%d' % [buff_value, buff_value])
	# 触发卡.player.鲜血宝石加成 += Vector2i(buff_value, buff_value)
