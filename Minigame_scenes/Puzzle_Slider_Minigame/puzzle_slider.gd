extends Area2D

var tiles = []
var solved = []
var mouse = false

const GRID_SIZE = 3
const TILE_SIZE = 166.665
const PUZZLE_OFFSET = 250.0

@onready var winning_screen: Sprite2D = $Winning_Screen

func _ready():
	$ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	start_game()

func start_game():
	winning_screen.visible = false

	tiles = [
		$Tile1,
		$Tile2,
		$Tile3,
		$Tile4,
		$Tile5,
		$Tile6,
		$Tile7,
		$Tile8,
		$Tile9
	]

	solved = tiles.duplicate()
	shuffle_tiles()

func shuffle_tiles():
	var board_1 = [
		1, 2, 6,
		4, 3, 9,
		7, 5, 8
	]

	var board_2 = [
		1, 2, 3,
		7, 4, 6,
		5, 9, 8
	]

	var board_3 = [
		1, 2, 9,
		4, 6, 3,
		7, 5, 8
	]

	var board_4 = [
		1, 2, 3,
		9, 4, 6,
		7, 5, 8
	]

	var boards = [
		board_1,
		board_2,
		board_3,
		board_4
	]

	var selected_board = boards[randi() % boards.size()]
	var original_positions = []

	for tile in tiles:
		original_positions.append(tile.position)

	for i in range(9):
		var tile_number = selected_board[i]
		tiles[i] = get_node("Tile" + str(tile_number))

		var row = i / GRID_SIZE
		var col = i % GRID_SIZE
		var original_index = row * GRID_SIZE + col

		tiles[i].position = original_positions[original_index]

func _process(_delta):
	if mouse:
		var mouse_position = mouse
		mouse = false

		var local_x = mouse_position.x - PUZZLE_OFFSET
		var local_y = mouse_position.y - PUZZLE_OFFSET

		if local_x < 0 or local_x >= TILE_SIZE * GRID_SIZE:
			return

		if local_y < 0 or local_y >= TILE_SIZE * GRID_SIZE:
			return

		var row = int(local_y / TILE_SIZE)
		var col = int(local_x / TILE_SIZE)

		check_neighbours(row, col)

		if tiles == solved:
			winning_screen.visible = true
			print("You win!")

func check_neighbours(row, col):
	var pos = row * GRID_SIZE + col

	if row < GRID_SIZE - 1:
		if find_empty(pos + GRID_SIZE, pos):
			return

	if row > 0:
		if find_empty(pos - GRID_SIZE, pos):
			return

	if col < GRID_SIZE - 1:
		if find_empty(pos + 1, pos):
			return

	if col > 0:
		if find_empty(pos - 1, pos):
			return

func find_empty(new_pos, pos):
	if new_pos < 0 or new_pos >= tiles.size():
		return false

	if tiles[new_pos] == $Tile9:
		swap_tiles(pos, new_pos)
		return true

	return false

func swap_tiles(tile_src, tile_dst):
	var temp_pos = tiles[tile_src].position
	tiles[tile_src].position = tiles[tile_dst].position
	tiles[tile_dst].position = temp_pos

	var temp_tile = tiles[tile_src]
	tiles[tile_src] = tiles[tile_dst]
	tiles[tile_dst] = temp_tile

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mouse = event.position


func _on_button_pressed() -> void:
	queue_free()
