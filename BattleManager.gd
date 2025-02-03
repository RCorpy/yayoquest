extends Node

var battle_timer
# Called when the node enters the scene tree for the first time.
func _ready():
	battle_timer = $"../BattleTimer"
	battle_timer.one_shot = true
	battle_timer.wait_time = 1.0

func _on_end_turn_button_pressed():
	opponent_turn()


func opponent_turn():
	$"../EndTurnButton".disabled = true
	$"../EndTurnButton".visible = false
	$"../OpponentDeck".draw_card()
	
	#wait 1 sec
	battle_timer.start()
	await battle_timer.timeout

	#check for cards that we can play, if there arent, end turn
	if false:
		end_opponent_turn()
		return
	#choose cards to play
	
	#End turn
	end_opponent_turn()
	
func end_opponent_turn():
		#Reset player deck draw
	$"../EndTurnButton".disabled = false
	$"../EndTurnButton".visible = true
