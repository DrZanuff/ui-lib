extends Button

class_name TabButton

enum TabStates {ACTIVE, INACTIVE}

var active_colors: ButtonFontColors = ButtonFontColors.new(Color("#ffffff"), Color("#d9d9d9"), Color("#d9d9d9"), Color("#d9d9d9"),Color("#d9d9d9"))
var inactive_colors: ButtonFontColors = ButtonFontColors.new(Color("#2f2f2f"), Color("#f2f2f2"), Color("#ffffff"), Color("#454545"),Color("#454545"))

var _colors: Dictionary[int, ButtonFontColors] = {
	TabStates.ACTIVE: active_colors,
	TabStates.INACTIVE: inactive_colors,
}

@onready var _active_bg: NinePatchRect = %BlueNinePatchRect
@onready var _inactive_bg: NinePatchRect = %GreyNinePatchRect

@export var tab_name: String = "Tab":
	set(value):
		tab_name = value
		text = value
		
var _tab_id: int = -1

var _current_state: TabStates = TabStates.INACTIVE

func set_tab_id(id: int) -> void:
	_tab_id = id

func get_tab_id() -> int:
	return _tab_id

func get_current_state() -> TabStates:
	return _current_state

func set_state(state: TabStates) -> void:
	var is_active: bool = state == TabStates.ACTIVE
	_current_state = state
	var font_colors: ButtonFontColors = _colors[state]
	add_theme_color_override("font_color", font_colors.font_color)
	add_theme_color_override("font_focus_color", font_colors.font_focus_color)
	add_theme_color_override("font_pressed_color", font_colors.font_pressed_color)
	add_theme_color_override("font_hover_color", font_colors.font_hover_color)
	add_theme_color_override("font_hover_pressed_color", font_colors.font_hover_pressed_color)
	_active_bg.visible = is_active
	_inactive_bg.visible = not is_active

class ButtonFontColors:
	var font_color: Color
	var font_focus_color: Color
	var font_pressed_color: Color
	var font_hover_color: Color
	var font_hover_pressed_color: Color
	func _init(
		p_font_color: Color = Color.WHITE,
		p_font_focus_color: Color = Color.WHITE,
		p_font_pressed_color: Color = Color.WHITE,
		p_font_hover_color: Color = Color.WHITE,
		p_font_hover_pressed_color: Color = Color.WHITE
	) -> void:
		font_color = p_font_color
		font_focus_color = p_font_focus_color
		font_pressed_color = p_font_pressed_color
		font_hover_color = p_font_hover_color
		font_hover_pressed_color = p_font_hover_pressed_color
