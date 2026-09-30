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
var text = ["im a closet", "definitely dont have any skeletons in here", "no sir"]

#this signal is triggered when anything interacts with the area2D
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if mouse clicks the closet
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#triggers dialogue with whatever text the wardrobe reveals 
		%DialogueBox.trigger_dialogue(text) 
			#unlike the rug, this will keep triggering the same dialogue after it plays once
