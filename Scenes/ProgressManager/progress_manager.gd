extends Node2D


@onready var Dialogue_Manager: ColorRect = $"../DialogueBox"


const PUZZLE_SLIDER = preload("uid://cjrohpooys7ow")
var minigame_instantiated = false

var processing_event = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("object_clicked", on_clicked)
	


func on_clicked(text: Array[String], game: String, key: Sprite2D) -> void:
	if processing_event:
		return
	
	processing_event = true
	await run_event(text, game, key)
	processing_event = false


func run_event(text: Array[String], game: String, key: Sprite2D):
	
	
	if text != null and text.size() > 0:
		Dialogue_Manager.trigger_dialogue(text)
		await Dialogue_Manager.get_child(1).dialogue_done
		
	if game == "slider":
		if not minigame_instantiated:
			var minigame = PUZZLE_SLIDER.instantiate()
			get_tree().current_scene.add_child(minigame)
			minigame_instantiated = true
			minigame.position = Vector2(-1033,-1033)
			minigame.scale = Vector2(2,2)
	
	if key != null:
		key.visible = true 
		
	
