extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		var card = preload("uid://dr3w1srvxktsy").instantiate()
		$PanelContainer/DraggableCardComponent.add_card(card)
