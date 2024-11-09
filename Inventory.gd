'''Die Grundlage des Inventars bildet der ScrollContainer, in diesem gibt es einen GridContainer und dieser widerrum
beinhaltet einen VBoxContainer (New_Item_Scene in InventoryClass).'''

extends ScrollContainer

var Inventory

'''Es wird eine Inventory Class Instanz erstellt.
Das Setup wird ausgeführt um Infos wie Container und NewItem Scene weiterzugeben.
Der Verweis auf die Instanz wird an eine Globale Variable weitergegeben (Global.Inventory_Instance).'''

func _ready() -> void:
	Inventory = InventoryClass.new()
	Inventory.Setup(self, $"GridContainer (Layout)", "res://NewItem.tscn")
	Global.Inventory_Instance = Inventory
