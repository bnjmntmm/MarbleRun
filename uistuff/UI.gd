extends CanvasLayer

@export var test: int

func _process(delta):
	if Input.is_action_just_pressed("block_select"):
		$SelectionWheel.show()
	elif Input.is_action_just_released("block_select"):
		var tool = $SelectionWheel.Close()
		$Label.text = "Selected Block: " + tool
