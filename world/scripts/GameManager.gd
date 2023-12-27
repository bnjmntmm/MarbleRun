extends Node

signal changeArea
signal spawnBlock

var playAreaMin : Vector3
var playAreaMax: Vector3



var passed_through_tracks = 0

var final_score : float
var start_time = 0
var end_time = 0

func calculateScore():
	var elapsedTime = end_time-start_time
	var track_weight: float = 1.0
	var time_weight: float = 0.5
	
	var score: float = roundf(abs(passed_through_tracks * (passed_through_tracks/elapsedTime) +  elapsedTime*(passed_through_tracks/elapsedTime)))
	final_score = score


func changeAreaFunc():
	changeArea.emit()

func spawn_block():
	spawnBlock.emit()
