extends NinePatchRect

@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	self.pivot_offset = Vector2(size.x / 2, size.y)
	self.modulate.a = 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.isDragging: 
		
		self.show()
		self.position = Vector2(player.position.x - size.x / 2, player.position.y - size.y)
		var centerPos = self.position + self.pivot_offset
		
		var mousePos = get_global_mouse_position()
		
		rotation = centerPos.angle_to_point(mousePos) + deg_to_rad(270)
	else:
		self.hide()
	
