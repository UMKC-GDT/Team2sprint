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

#i added this for dialogue  -Cameron
var text = ["beep boop", "imma rug", "ooOOooOOo spooky"]
var dailogue_run_count = 0
#this signal is triggered when anything interacts with the area2D
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if mouse clicks the rug
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#this triggers dialogue with whatever text the rug reveals, and will only run once
		%DialogueBox.trigger_dialogue(text, dailogue_run_count > 0)
		
		#after running once, it'll increment this count and not run again
		dailogue_run_count = dailogue_run_count + 1
