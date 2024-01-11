extends Control

@onready var GameManagerScoreLabel = $Label/GameManagerScoreLabel
@onready var name_input = $NameLabel/NameInput
@onready var save_button = $Label/SaveButton
@onready var score_label = $BoxContainer/scoreLabel

var list_index = 0
var max_scores = 10
var local_scores
var scores
const ScoreItem = preload("res://addons/silent_wolf/Scores/ScoreItem.tscn")
var ld_name ="main"
# Called when the node enters the scene tree for the first time.
func _ready():
	GameManagerScoreLabel.text = str(GameManager.final_score)
	save_button.set_disabled(false)
	save_button.text = "SAVE SCORE TO SCOREBOARD"
	scores = SilentWolf.Scores.scores
	local_scores = SilentWolf.Scores.local_scores
	if len(scores) > 0: 
		render_scores(scores,local_scores)
	else:
		var sw_result = await SilentWolf.Scores.get_scores().sw_get_scores_complete
		scores = sw_result.scores
		render_scores(scores,local_scores)

func _enter_tree():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_up():
	if name_input.text != "":
		save_button.set_disabled(true)
		save_button.text = "Saved"
		local_scores.append({"player_name": name_input.text, "score": GameManager.final_score})
		render_scores(scores,local_scores)
		


func _on_back_button_button_up():
	GameManager.back_to_menu()

func add_item(player_name: String, score_value: String) -> void:
	var item = ScoreItem.instantiate()
	list_index += 1	
	item.get_node("PlayerName").text = str(list_index) + str(". ") + player_name
	item.get_node("Score").text = score_value
	item.offset_top = list_index * 100
	$BoxContainer.add_child(item)


func render_scores(scores: Array, local_scores : Array):
	var all_scores = scores
	if ld_name in SilentWolf.Scores.ldboard_config and is_default_leaderboard(SilentWolf.Scores.ldboard_config[ld_name]):
		all_scores = merge_scores_with_local_scores(scores, local_scores, max_scores)
		if scores.is_empty() and local_scores.is_empty():
			pass
	if all_scores.is_empty():
		for score in scores:
			add_item(score.player_name, str(int(score.score)))
	else:
		for score in all_scores:
			add_item(score.player_name, str(int(score.score)))

func merge_scores_with_local_scores(scores: Array, local_scores: Array, max_scores: int=10) -> Array:
	if local_scores:
		for score in local_scores:
			var in_array = score_in_score_array(scores, score)
			if !in_array:
				scores.append(score)
			scores.sort_custom(sort_by_score);
	if scores.size() > max_scores:
		var new_size = scores.resize(max_scores)
	return scores

func score_in_score_array(scores: Array, new_score: Dictionary) -> bool:
	var in_score_array =  false
	if !new_score.is_empty() and !scores.is_empty():
		for score in scores:
			if score.score_id == new_score.score_id: # score.player_name == new_score.player_name and score.score == new_score.score:
				in_score_array = true
	return in_score_array

func sort_by_score(a: Dictionary, b: Dictionary) -> bool:
	if a.score > b.score:
		return true;
	else:
		if a.score < b.score:
			return false;
		else:
			return true;

func is_default_leaderboard(ld_config: Dictionary) -> bool:
	var default_insert_opt = (ld_config.insert_opt == "keep")
	var not_time_based = !("time_based" in ld_config)
	return default_insert_opt and not_time_based
