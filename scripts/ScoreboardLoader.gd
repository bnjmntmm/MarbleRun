extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.configure({
		"api_key": "rBQM1XFDj91z2kmpCa1ps2HWVYnj7R6XahCQOe2K",
		"game_id": "MarbleRun",
		"log_level": 1
	})


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
