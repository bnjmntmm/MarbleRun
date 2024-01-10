extends Node


var playAreaMin : Vector3
var playAreaMax: Vector3

var XPlaneValue
var ZPlaneValue
var PlaneOrigin


signal submitArea
signal complete

signal xAdd
signal xMinus

signal yAdd
signal yMinus

signal delete_track_pickable



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
	elapsedTime = 0
	end_time = 0
	start_time = 0
	passed_through_tracks = 0

func addXValue():
	xAdd.emit()
func addYValue():
	yAdd.emit()
func subtractXValue():
	xMinus.emit()
func subtractYValue():
	yMinus.emit()

func apply_area():
	submitArea.emit()
	
func setupComplete():
	complete.emit()
func delete_track():
	delete_track_pickable.emit()
