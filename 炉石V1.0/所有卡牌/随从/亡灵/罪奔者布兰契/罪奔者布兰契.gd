extends BaseMinion

@export var 复生:bool = true

func 复生时():
	# When reborn, retain all health and additional effects
	# This is handled by the base class, but we can add specific logic here
	print("罪奔者布兰契复生：保留所有生命值和附加效果")
