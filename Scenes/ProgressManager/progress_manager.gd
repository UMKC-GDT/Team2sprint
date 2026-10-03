extends Node2D


@onready var Dialogue_Manager: ColorRect = $"../DialogueBox"


const PUZZLE_SLIDER = preload("uid://cjrohpooys7ow")
var minigame_instantiated = false

var dialogue_event = false
var minigame_event = false
var inventory_event = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("object_clicked", on_clicked)
	

func on_clicked(text: Array[String], game: String, key: Sprite2D):
	print("clicked_PM")
	if(text != null):
		dialogue_event = true

	if(game == "slider"):
		minigame_event = true

	if(key != null):
		inventory_event = true

	
	run_event(text, game, key)
		
		
func run_event(text: Array[String], game: String, key: Sprite2D):
	if(dialogue_event):
		Dialogue_Manager.trigger_dialogue(text)
		await Dialogue_Manager.get_child(1).dialogue_done
		
	if(minigame_event):
		if not minigame_instantiated:
			var minigame = PUZZLE_SLIDER.instantiate()
			get_tree().current_scene.add_child(minigame)
			minigame_instantiated = true
			minigame.position = Vector2(-1033,-1033)
			minigame.scale = Vector2(2,2)
	if(inventory_event):
		key.visible = true
		
	dialogue_event = false
	minigame_event = false
	inventory_event = false
	
