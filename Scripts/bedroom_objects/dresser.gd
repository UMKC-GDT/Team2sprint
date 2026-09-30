extends Sprite2D

@export var highlight_texture: Texture2D

@onready var main_texture: Texture2D = self.texture

const PUZZLE_SLIDER = preload("uid://cjrohpooys7ow")

var mouse_on = false
var minigame_instantiated = false

var text = [
	"inside of me is a puzzle",
	"slide the tiles to see the picture",
	"be carefulllll"
]

var dialogue_run_count = 0


func _on_area_2d_mouse_entered() -> void:
	mouse_on = true
	self.texture = highlight_texture


func _on_area_2d_mouse_exited() -> void:
	mouse_on = false
	self.texture = main_texture


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			if dialogue_run_count < text.size():
				%DialogueBox.trigger_dialogue(text, dialogue_run_count > 0)
				dialogue_run_count += 1
				return

			if not minigame_instantiated:
				var minigame = PUZZLE_SLIDER.instantiate()
				get_tree().current_scene.add_child(minigame)
				minigame_instantiated = true
