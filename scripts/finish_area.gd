extends Node3D

@onready var confetti_alt = $ConfettiAlt

#Target Scene name
@export_file("*.tscn") var target_scene : String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
signal marble_in_fin

func _on_area_3d_body_entered(body):
	print(body.name)
	if body != self:
		if body.name == "Marble":
			GameManager.end_time = Time.get_unix_time_from_system()
			GameManager.calculateScore()
			confetti_alt.play_confetti()
			marble_in_fin.emit()
			await get_tree().create_timer(1.5).timeout
			switch_to_score_scene()
			

func switch_to_score_scene():
	
	if not target_scene or target_scene == "":
		return
	#Find the XRToolsSceneBase this node is a child of
	var scene_base : XRToolsSceneBase = XRTools.find_xr_ancestor(self, "*", "XRToolsSceneBase")
	if not scene_base:
		return 
	
	#Start loading the target scene
	scene_base.load_scene(target_scene)
