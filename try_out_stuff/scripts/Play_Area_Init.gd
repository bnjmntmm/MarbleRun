extends Node

var InitChildren = []
@onready var label_3d = $"../Label3D"

@onready var area_init_box = $Area_Init_Box
@onready var area_init_box_2 = $Area_Init_Box2
@onready var area_init_box_3 = $Area_Init_Box3
@onready var area_init_box_4 = $Area_Init_Box4






func _ready():
	GameManager.connect("changeArea", area_changed)

func area_changed():
	GameManager.playAreaMin = Vector3(
		min(area_init_box.global_transform.origin.x,area_init_box_2.global_transform.origin.x,area_init_box_3.global_transform.origin.x,area_init_box_4.global_transform.origin.x),
		min(area_init_box.global_transform.origin.y,area_init_box_2.global_transform.origin.y,area_init_box_3.global_transform.origin.y,area_init_box_4.global_transform.origin.y),
		min(area_init_box.global_transform.origin.z,area_init_box_2.global_transform.origin.z,area_init_box_3.global_transform.origin.z,area_init_box_4.global_transform.origin.z)	
	)
	GameManager.playAreaMax = Vector3(
		max(area_init_box.global_transform.origin.x,area_init_box_2.global_transform.origin.x,area_init_box_3.global_transform.origin.x,area_init_box_4.global_transform.origin.x),
		max(area_init_box.global_transform.origin.y,area_init_box_2.global_transform.origin.y,area_init_box_3.global_transform.origin.y,area_init_box_4.global_transform.origin.y),
		max(area_init_box.global_transform.origin.z,area_init_box_2.global_transform.origin.z,area_init_box_3.global_transform.origin.z,area_init_box_4.global_transform.origin.z)	
	)
	#label_3d.text = "min: " + str(GameManager.playAreaMin) + " ; max: " + str(GameManager.playAreaMax)

