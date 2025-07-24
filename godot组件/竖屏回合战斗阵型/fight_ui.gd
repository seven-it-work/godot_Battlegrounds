extends PanelContainer

@onready var 蓄力队列=$"HBoxContainer/蓄力队列"
@onready var enemyGroupUI=$HBoxContainer/battlefield/EnemyGroup
@onready var playerGroupUI=$HBoxContainer/battlefield/PlayerGroup

func 初始化(playerGroup:FightGroupEntity,enemyGroup:FightGroupEntity):
	for i in 蓄力队列.get_children():
		i.free()
	for i in playerGroup.get_all_list():
		#res://蓄力.tscn
		var ui=preload("uid://b3r6u7ku23ulw").instantiate()
		蓄力队列.add_child(ui)
		ui.初始化(i)
	
	for i in enemyGroupUI.get_children():
		i.queue_free()
	await get_tree().process_frame
	
	for i in 9:
		var fightEntity=enemyGroup.get_by_index(9-i)
		#res://FightPeopleUI.tscn
		var ui=preload("uid://ckt1pye1xb11q").instantiate()
		enemyGroupUI.add_child(ui)
		await get_tree().process_frame
		if fightEntity:
			ui.初始化(fightEntity)
		
	for i in playerGroupUI.get_children():
		i.queue_free()
	for i in 9:
		var fightEntity=enemyGroup.get_by_index(i)
		#res://FightPeopleUI.tscn
		var ui=preload("uid://ckt1pye1xb11q").instantiate()
		playerGroupUI.add_child(ui)
		ui.初始化(fightEntity)
	pass
