extends CanvasLayer

@export var test: int
@onready var selection_wheel = $SelectionWheel

func _process(delta):
	
	$Label.text=str(selection_wheel.get_current_selection())
	if Input.is_action_just_pressed("block_select"):
		$SelectionWheel.show()
	elif Input.is_action_just_released("block_select"):
		var tool = $SelectionWheel.Close()
		$Label.text = "Selected Block: " + tool
