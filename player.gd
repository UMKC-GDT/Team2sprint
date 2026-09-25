extends CharacterBody2D


const SPEED = 80

var current_direction

enum direction {
	UP,
	UP_LEFT,
	UP_RIGHT,
	DOWN,
	DOWN_LEFT,
	DOWN_RIGHT,
	LEFT,
	RIGHT,
	IDLE
}


var KEY_UP = false
var KEY_DOWN= false
var KEY_LEFT= false
var KEY_RIGHT= false

func _process(_delta: float)-> void:
	get_input()
	set_direction()
	 
	move()
	
	
	
func get_input():
	if Input.is_action_pressed("move_up"): KEY_UP = true
	else: KEY_UP = false
	
	if Input.is_action_pressed("move_down"): KEY_DOWN = true
	else: KEY_DOWN = false
	
	if Input.is_action_pressed("move_right"): KEY_RIGHT = true
	else: KEY_RIGHT = false

	if Input.is_action_pressed("move_left"): KEY_LEFT = true
	else: KEY_LEFT = false

func set_direction():
	if KEY_UP:
		if KEY_LEFT:
			current_direction = direction.UP_LEFT
		elif KEY_RIGHT:
			current_direction = direction.UP_RIGHT
		else: current_direction = direction.UP
	elif KEY_DOWN:
		if KEY_LEFT:
			current_direction = direction.DOWN_LEFT
		elif KEY_RIGHT:
			current_direction = direction.DOWN_RIGHT
		else: current_direction = direction.DOWN
	elif KEY_LEFT:
		current_direction = direction.LEFT
	elif KEY_RIGHT: 
		current_direction = direction.RIGHT
	else: current_direction = direction.IDLE
		
		
func move():
	match current_direction:
		direction.UP: 
			self.velocity = Vector2(0,-SPEED)
			$AnimatedSprite2D.play("Walk_Up")
		direction.DOWN: 
			self.velocity = Vector2(0,SPEED)
			$AnimatedSprite2D.play("Walk_Down")
		direction.UP_LEFT: 
			self.velocity = cartesian_to_isometric(Vector2(-SPEED,0))
			$AnimatedSprite2D.play("Walk_Up_Left")
		direction.UP_RIGHT: 
			self.velocity = cartesian_to_isometric(Vector2(0,-SPEED))
			$AnimatedSprite2D.play("Walk_Up_Right")
		direction.DOWN_LEFT: 
			self.velocity = cartesian_to_isometric(Vector2(0, SPEED))
			$AnimatedSprite2D.play("Walk_Down_Left")
		direction.DOWN_RIGHT: 
			self.velocity = cartesian_to_isometric(Vector2(SPEED, 0))
			$AnimatedSprite2D.play("Walk_Down_Right")
		direction.RIGHT: 
			self.velocity = Vector2(SPEED,0)
			$AnimatedSprite2D.play("Walk_Right")
		direction.LEFT: 
			self.velocity = Vector2(-SPEED, 0)
			$AnimatedSprite2D.play("Walk_Left")
		direction.IDLE: 
			self.velocity = Vector2(0,0)
			$AnimatedSprite2D.play("Idle_down")
		
	move_and_slide()
		
		
			
			


func cartesian_to_isometric(cartesian):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x+ cartesian.y)/2)
	
	
