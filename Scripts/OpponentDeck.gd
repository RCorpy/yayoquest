extends Node2D

const CARD_SCENE_PATH = "res://Scenes/Card.tscn"
const CARD_DRAW_SPEED = 0.4
const STARTING_HAND_SIZE = 5

var opponent_deck = ["TowerYellow", "TowerBlue", "TowerPurple", "TowerBlue", "TowerPurple", "TowerBlue", "TowerPurple", "TowerBlue", "TowerPurple"]
var card_database_reference
var card_draw_this_turn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	opponent_deck.shuffle()
	$RichTextLabel.text = str(opponent_deck.size())
	card_database_reference = preload("res://Scripts/CardDataBase.gd")
	for i in range(STARTING_HAND_SIZE):
		draw_card()
		card_draw_this_turn = false
	card_draw_this_turn = true

	# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw_card():
	if card_draw_this_turn:
		return
		
	card_draw_this_turn = true
	var card_drawn_name = opponent_deck[0]
	opponent_deck.erase(card_drawn_name)
	
	if opponent_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		$RichTextLabel.visible = false
		
	$RichTextLabel.text = str(opponent_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	var card_img_path = str("res://Assets/" + str(card_drawn_name) + "Card.png")
	new_card.get_node("CardImage").texture = load(card_img_path)
	new_card.get_node("Attack").text = str(card_database_reference.CARDS[card_drawn_name][0])
	new_card.get_node("Health").text = str(card_database_reference.CARDS[card_drawn_name][1])
	new_card.card_type = card_database_reference.CARDS[card_drawn_name][2]
	new_card.position = Vector2(1780,125)
	$"../CardManager".add_child(new_card)
	new_card.name = "Card"
	$"../OpponentHand".add_card_to_hand(new_card, CARD_DRAW_SPEED)
	#new_card.get_node("AnimationPlayer").play("card_flip")
