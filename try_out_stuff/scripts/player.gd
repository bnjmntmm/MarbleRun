extends XROrigin3D

@onready var viewport_2_din_3d = $LeftController/Viewport2Din3D
var cube = preload("res://try_out_stuff/scenes/cube.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.spawnBlock.connect(spawn_block)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_left_controller_button_pressed(name):
	if name == "ax_button":
		viewport_2_din_3d.visible = !viewport_2_din_3d.visible

func spawn_block():
	var cubeNew = cube.instantiate()
	get_parent().add_child(cubeNew,true)
	randomize()
	var randPos = Vector3(
		lerp(GameManager.playAreaMin.x, GameManager.playAreaMax.x, randf()),
		lerp(GameManager.playAreaMin.y, GameManager.playAreaMax.y, randf()),
		lerp(GameManager.playAreaMin.z, GameManager.playAreaMax.z, randf())
	)
	cubeNew.global_transform.origin = randPos
