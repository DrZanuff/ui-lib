extends MarginContainer

class_name TabComponent

@export var tabs: Array[TabElement] 
@onready var _tabs_wrapper = %TabsWrapper

const _TAB_REFERENCE = preload("res://scenes/components/tab-component/tab-button.tscn")
var _tabs_hashmap: Dictionary[int, TabElement] = {}

func _ready() -> void:
	for child in _tabs_wrapper.get_children():
		child.queue_free()
	
	var tab_id = 0
	
	for tab : TabElement in tabs:
		var new_tab: TabButton = _TAB_REFERENCE.instantiate()
		new_tab.tab_name = tab.tab_name
		new_tab.set_tab_id(tab_id)
		new_tab.pressed.connect(_display_tab.bind(tab_id, new_tab))
		
		_tabs_hashmap[tab_id] = tab
		_tabs_wrapper.add_child(new_tab)
		
		new_tab.set_state(TabButton.TabStates.ACTIVE if tab_id == 0 else TabButton.TabStates.INACTIVE )
		tab_id += 1

func _display_tab(id: int, tab_button: TabButton) -> void:
	_disable_all_tabs()
	
	var tab_element: TabElement = _tabs_hashmap[id]
	tab_button.set_state(TabButton.TabStates.ACTIVE)
	var content = get_node(tab_element.tab_content)
	(content as CanvasItem).show()

func _disable_all_tabs() -> void:
	for child in _tabs_wrapper.get_children():
		if child is TabButton:
			child.set_state(TabButton.TabStates.INACTIVE)
	
	for tab: TabElement in tabs:
		var content = get_node(tab.tab_content)
		(content as CanvasItem).hide()
	
