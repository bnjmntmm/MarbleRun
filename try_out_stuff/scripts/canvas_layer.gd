extends CanvasLayer


@onready var x_add = $MarginContainer/HBoxContainer/VBoxContainer/XAdd
@onready var x_minus = $MarginContainer/HBoxContainer/VBoxContainer2/XMinus
@onready var y_add = $MarginContainer/HBoxContainer/VBoxContainer/YAdd
@onready var y_minus = $MarginContainer/HBoxContainer/VBoxContainer2/YMinus
@onready var apply_area = $MarginContainer/HBoxContainer/VBoxContainer3/Apply_Area

var x_addState = false
var y_addState = false
var x_minusState = false
var y_minusState = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if x_addState:
		GameManager.addXValue()
		await get_tree().create_timer(0.2).timeout
	if y_addState:
		GameManager.addYValue()
		await get_tree().create_timer(0.2).timeout
	if x_minusState:
		GameManager.subtractXValue()
		await get_tree().create_timer(0.2).timeout
	if y_minusState:
		GameManager.subtractYValue()
		await get_tree().create_timer(0.2).timeout
	
	
	if visible:
		x_add.disabled = false
		x_minus.disabled = false
		y_add.disabled = false
		y_minus.disabled = false
	else:
		x_add.disabled = true
		x_minus.disabled = true
		y_add.disabled = true
		y_minus.disabled = true

func _on_x_add_pressed():
	x_addState = true


func _on_x_add_button_up():
	x_addState = false


func _on_y_add_pressed():
	y_addState = true


func _on_y_add_button_up():
	y_addState = false


func _on_x_minus_pressed():
	x_minusState = true


func _on_x_minus_button_up():
	x_minusState = false


func _on_y_minus_pressed():
	y_minusState = true


func _on_y_minus_button_up():
	y_minusState = false


func _on_apply_area_button_down():
	GameManager.apply_area()
