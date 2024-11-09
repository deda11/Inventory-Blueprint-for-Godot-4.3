'''Inventar Klasse, das eigentliche Inventar erstellt eine neue Instanz dieser Klasse.
Diese Instanz wird an eine Globale Variable übermittelt Global.Inventory_Instance.
Dadurch ist es möglich mit dem Inventar von überall aus zu interagieren, indem Global.Inventory_Instance
aufgerufen wird.'''

class_name InventoryClass

var Setup_Done = false
var ScrollContainer_Inventory : ScrollContainer
var GridContainer_Inventory : GridContainer
var New_Item_Scene

var InventorySlots = []
	
	
'''Setup sammelt alle notwendigen Informationen des aktuellen Inventars. Um später damit zu arbeiten.'''
	
func Setup(ScrollContainerInventory:ScrollContainer, GridContainerInventory:GridContainer,
	NewItemScenePath:String):
					
	ScrollContainer_Inventory = ScrollContainerInventory
	GridContainer_Inventory = GridContainerInventory
	New_Item_Scene = load(NewItemScenePath) #Path Bsp: "res://my_scene.tscn"
	Setup_Done = true
	
	
'''AddItem wird aufgerufen, wenn ein Item eingesammelt wird im Spiel. Dazu werden die ItemInfos über Item mitgegeben.
Dann wird geprüft ob es bereits Items im Inventar gibt (Slots).
Dann prüfen wir ob einer dieser Slots bereits unser Item enthält, falls ja wird slotFound auf true gesetzt.
	Es wird dann die Anzahl des Items um die Anzahl aus ItemInfo erhöht.
Ansonsten wird ein neuer Slot erstellt, mit Sprite, Name und Anzahl aus ItemInfo.'''
	
func AddItem(Item):
	'''Item benötigt: Index 0 = Sprite, Index 1 = Name, Index 2 = Amount'''
	var slotFound = false
	
	if not InventorySlots.is_empty():
		for Slot in InventorySlots:
			if Slot.get_node("HBoxContainer/Label").text == Item[1]:
				slotFound = true
				var amount = int(Slot.get_node("HBoxContainer/Label2").text)
				amount += Item[2]
				Slot.get_node("HBoxContainer/Label2").text = "(" + str(amount) + ")"
				break
				
	if slotFound == false:
			var newSlot = New_Item_Scene.instantiate()
			
			newSlot.ItemInfo = Item
			newSlot.get_node("Button").icon = Item[0]
			newSlot.get_node("HBoxContainer/Label").text = Item[1]
			newSlot.get_node("HBoxContainer/Label2").text = "(" + str(Item[2]) + ")"
			InventorySlots.append(newSlot)
				
			GridContainer_Inventory.add_child(newSlot)
			
			
'''DeleteItem wird aufgerufen, wenn ein Item benutzt oder gelöscht wird im Inventar. Dazu braucht es ebenfalls ItemInfo.
Sofern es überhaupt tatsächlich Items gibt im Inventar wird der korrekte Slot gesucht über den ItemInfo Namen.
Dann wird die Anzahl um 1 gesenkt.
Sofern Anzahl >= 1, wird der Text entsprechend angepasst.
Andernfalls wird der Slot gelöscht, sowohl die Scene/Node als auch der Index im Array.'''
	
func DeleteItem(Item):
	if not InventorySlots.is_empty():
		for Slot in InventorySlots:
			if Slot.get_node("HBoxContainer/Label").text == Item[1]:
				var amount = int(Slot.get_node("HBoxContainer/Label2").text)
				amount -= 1
				if amount >= 1:
					Slot.get_node("HBoxContainer/Label2").text = "(" + str(amount) + ")"
				else:
					Slot.queue_free()
					InventorySlots.erase(Slot)
