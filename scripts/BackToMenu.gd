extends Node3D

@export_file("*.tscn") var target_scene : String

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.backMenu.connect(resetGame)


func resetGame():
	if not target_scene or target_scene == "":
		return
	#Find the XRToolsSceneBase this node is a child of
	var scene_base : XRToolsSceneBase = XRTools.find_xr_ancestor(self, "*", "XRToolsSceneBase")
	if not scene_base:
		return 
	
	#Start loading the target scene
	scene_base.load_scene(target_scene)
