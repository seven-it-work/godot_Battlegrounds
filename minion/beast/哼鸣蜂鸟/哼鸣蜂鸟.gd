extends BaseCard

func fight_start(player:Player):
	super.fight_start(player)
	player.beat_attack+=1

func fight_end(player:Player):
	super.fight_start(player)
	player.beat_attack-=1
	
