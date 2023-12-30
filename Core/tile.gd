extends Area2D

class_name Tile

@export var startTile:bool = false

var hasBuilding:bool = false
var canPlaceBuilding:bool = false

var grid_position:Vector2

# components
@onready var highlight: Sprite2D = get_node("TileHighlight")
@onready var buildingIcon: Sprite2D = get_node("BuildingIcon")
@onready var label:Label = get_node("Label")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(grid_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_highlight(value:bool):
	highlight.visible = value
	canPlaceBuilding = value

func place_building(buildingTexture:Texture):
	hasBuilding = true
	buildingIcon.texture = buildingTexture

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
