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
signal backMenu

var passed_through_tracks = 0

var final_score : float
var start_time = 0
var end_time = 0

func _ready():
	SilentWolf.configure({
	"api_key": "rBQM1XFDj91z2kmpCa1ps2HWVYnj7R6XahCQOe2K",
	"game_id": "MarbleRun",
	"log_level": 1
  })


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
	
func back_to_menu():
	backMenu.emit()
func get_current_score():
	var sw_result = await SilentWolf.Scores.get_scores().sw_get_scores_complete
