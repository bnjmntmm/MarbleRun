extends Node
@onready var label_3d = $"../Label3D"
@onready var area_init_box := $Area_Init_Box

@onready var area_setup_viewport = $"../XROrigin3D/LeftController/AreaSetupViewport"

signal setupComplete

func _ready():
	GameManager.connect("xAdd", addXToMesh)
	GameManager.connect("yAdd", addYToMesh)
	GameManager.connect("xMinus", substractXFromMesh)
	GameManager.connect("yMinus", substractYFromMesh)
	GameManager.connect("submitArea",area_changed)


	
	
func _process(delta):
	pass
	
func addXToMesh():
	area_init_box.get_child(0).get_shape().size.x = area_init_box.get_child(0).get_shape().get_size().x + 0.1
	area_init_box.get_child(1).get_mesh().size.x = area_init_box.get_child(1).get_mesh().size.x + 0.1
func substractXFromMesh():
	if area_init_box.get_child(0).get_shape().size.x < 0.1:
		return
	else:
		area_init_box.get_child(0).get_shape().size.x = area_init_box.get_child(0).get_shape().get_size().x - 0.1
		area_init_box.get_child(1).get_mesh().size.x = area_init_box.get_child(1).get_mesh().size.x - 0.1
func addYToMesh():
	area_init_box.get_child(0).get_shape().size.z = area_init_box.get_child(0).get_shape().get_size().z + 0.1
	area_init_box.get_child(1).get_mesh().size.z = area_init_box.get_child(1).get_mesh().size.z + 0.1
func substractYFromMesh():
	if area_init_box.get_child(0).get_shape().size.z < 0.1:
		return
	else:
		area_init_box.get_child(0).get_shape().size.z = area_init_box.get_child(0).get_shape().get_size().z - 0.1
		area_init_box.get_child(1).get_mesh().size.z = area_init_box.get_child(1).get_mesh().size.z - 0.1


func area_changed():
	
	GameManager.XPlaneValue = area_init_box.get_child(0).get_shape().size.x
	GameManager.ZPlaneValue = area_init_box.get_child(0).get_shape().size.z
	GameManager.PlaneOrigin = area_init_box.transform.origin
	#label_3d.text = "Transform: " + str(area_init_box.transform.origin) +  "XPLane: " + str(GameManager.XPlaneValue) + "\n YPlane: " + str(GameManager.ZPlaneValue)
	var minX = GameManager.PlaneOrigin.x - (GameManager.XPlaneValue/2)
	var minZ = GameManager.PlaneOrigin.z - (GameManager.ZPlaneValue/2)

	var maxX = GameManager.PlaneOrigin.x + (GameManager.XPlaneValue/2)
	var maxZ = GameManager.PlaneOrigin.z + (GameManager.ZPlaneValue/2)

	GameManager.playAreaMin = Vector3(minX,0,minZ)
	GameManager.playAreaMax = Vector3(maxX,0,maxZ)
	area_setup_viewport.enabled = false
	area_setup_viewport.visible = false
	area_init_box.visible = false
	GameManager.setupComplete()
