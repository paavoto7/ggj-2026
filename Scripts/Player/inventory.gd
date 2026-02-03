class_name Inventory extends Node

var inventory: Array[Node] = []
var currentMask: MaskItem = null
var currentItem: Node = null

func _exit_tree() -> void:
    unapply_mask()

func add_item(item: Node) -> void:
    if not item:
        return
    inventory.append(item)

func remove_item(item: Node) -> void:
    if not item:
        return
    inventory.erase(item)

func apply_mask(mask: MaskItem) -> void:
    if not mask and inventory.has(mask as Node):
        return
    if currentMask:
        currentMask.unset_static_effects()
    
    currentMask = mask
    mask.set_static_effects()

func unapply_mask() -> void:
    if currentMask:
        currentMask.unset_static_effects()
        currentMask = null

func change_current_item(item: Node) -> void:
    if item and inventory.has(item):
        currentItem = item
