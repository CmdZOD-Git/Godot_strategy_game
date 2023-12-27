extends Node

@export var baseTile:PackedScene
@export var HorizontalRepeat:int = 20
@export var VerticalRepeat:int = 9
@export var HorizontalTileSize:int = 64
@export var VerticalTileSize:int = 64

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in HorizontalRepeat:
		for y in VerticalRepeat:
			var tileToAdd:Node2D = baseTile.instantiate()
			var h:int = HorizontalTileSize / 2 + x * HorizontalTileSize
			var v:int = VerticalTileSize / 2 + y * VerticalTileSize
			tileToAdd.global_position = Vector2(h,v)
			add_child.call_deferred(tileToAdd)
