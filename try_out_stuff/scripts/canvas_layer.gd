extends CanvasLayer


@onready var x_add = $MarginContainer/HBoxContainer/VBoxContainer/XAdd
@onready var x_minus = $MarginContainer/HBoxContainer/VBoxContainer2/XMinus
@onready var y_add = $MarginContainer/HBoxContainer/VBoxContainer/YAdd
@onready var y_minus = $MarginContainer/HBoxContainer/VBoxContainer2/YMinus
@onready var apply_area = $MarginContainer/HBoxContainer/VBoxContainer3/Apply_Area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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



func _on_x_add_button_down():
	GameManager.addXValue()


func _on_y_add_button_down():
	GameManager.addYValue()


func _on_x_minus_button_down():
	GameManager.subtractXValue()


func _on_y_minus_button_down():
	GameManager.subtractYValue()


func _on_apply_area_button_down():
	GameManager.apply_area()
