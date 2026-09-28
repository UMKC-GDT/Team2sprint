extends Node2D

@export var correct_key: Array[int]
var curr_key: Array[int]
signal code_accepted()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curr_key.clear()

func curr_key_add(code:int) -> void:
	curr_key.append(code)
	if curr_key == correct_key:
		print("Code Accepted")
		code_accepted.emit()
		#Here is where the real "win" logic will go
	elif curr_key.size() == correct_key.size():
		curr_key.clear()

func _on_button_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_action_pressed("click")):
		curr_key_add(1)

func _on_button_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_action_pressed("click")):
		curr_key_add(2)
	
func _on_button_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event.is_action_pressed("click")):
		curr_key_add(3)
