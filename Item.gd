'''Dieses Skript ist die Grundlage für jedes Item. Es legt wichtige Informationen fest, die an das Inventar übermittelt werden.
Diese ItemInfo beinhaltet Sprite, Item Name, Item Anzahl. 

Kategorie (CategoryEnum) kann verwendet werden um später bei Klicken des Items im Inventar einen Effekt auszulösen wie 
zb. Heilung, Schaden, Gift, Buffs etc.'''

extends Sprite2D

@export var ItemName: String
@export var ItemAmount: int

enum CategoryEnum {
	HEAL,
	POISON
}
@export var Category: CategoryEnum

var ItemInfo = [] #Index 0 = Sprite, Index 1 = Name, Index 2 = Amount


'''Die Werte die über den Editor als @export festgelegt wurden, werden nun in das ItemInfo Array gelegt. Um diese später
an die Inventar Instanz zu übergeben.

Übergeben wird der Sprite für das Bild im Inventar.
Der Name des Items, dieser wird im Inventar angezeigt.
Die Anzahl des Items die ins Inventar gelegt werden.'''

func _ready() -> void:
	ItemInfo.append(self.texture)
	ItemInfo.append(ItemName)
	ItemInfo.append(ItemAmount)


'''Sobald die Area2D vom Item angeklickt wird, wird Item ins Inventar eingefügt und von der Welt gelöscht.'''
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT  and event.pressed:
		Global.Inventory_Instance.AddItem(ItemInfo)
		self.queue_free()
