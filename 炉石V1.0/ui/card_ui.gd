extends DragObj
class_name CardUI

var cardData:CardEntity

static func build(cardData:CardEntity)->CardUI:
	var cardUI=preload("uid://dy3yv2yd2kdo1").instantiate()
	cardUI.cardData=cardData
	cardUI.add_child(cardData)
	return cardUI
