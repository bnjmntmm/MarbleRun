extends CanvasLayer

@onready var button := $MarginContainer/VBoxContainer/Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		button.disabled = false
	else:
		button.disabled = true
	pass


func _on_button_button_down():
	GameManager.changeAreaFunc()


func _on_button_2_button_down():
	GameManager.spawn_block()
