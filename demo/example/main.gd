extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(7):
		var card = preload("uid://dr3w1srvxktsy").instantiate()
		$HBoxContainer/VBoxContainer/Tavern/Cards.add_card(card)
		$HBoxContainer/VBoxContainer/CardList/Cards.add_card(preload("uid://dr3w1srvxktsy").instantiate())

	pass
