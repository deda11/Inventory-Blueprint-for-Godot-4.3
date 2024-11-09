'''Dieses Skript dient lediglich dem Klick auf das jeweile Item im Inventar. 
Bisher wird das Item oder der ganze Slot (wenn < 0 Items) aus dem Inventar entfernt.'''

extends VBoxContainer

var ItemInfo = []

func _on_button_pressed() -> void:
	Global.Inventory_Instance.DeleteItem(ItemInfo)
