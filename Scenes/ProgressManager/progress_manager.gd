extends Node2D


@onready var Dialogue_Manager: ColorRect = $"../DialogueBox"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("object_clicked", on_clicked)

func on_clicked(text: Array[String], game: String, key: Sprite2D):
	if(text != null):
		Dialogue_Manager.trigger_dialogue(text)
	if(game != null):
		print(game)
	if(key != null):
		print("key!")
		
	
