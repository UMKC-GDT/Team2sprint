extends Sprite2D

@export var highlight_texture:Texture2D

@onready var main_texture:Texture2D = self.texture

var mouse_on = false

func _on_area_2d_mouse_entered() -> void:
	mouse_on = true
	self.texture = highlight_texture

func _on_area_2d_mouse_exited() -> void:
	mouse_on = false
	self.texture = main_texture

var text = ["beep boop", "imma rug", "ooOOooOOo spooky", "hahaha"]

#i added thisfor dialogue  -Cameron
#this signal is triggered when anything interacts with the area2D
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if mouse clicks the rug
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		%DialogueBox.trigger_dialogue(text) #trigger dialogue with whatever the rug reveals
