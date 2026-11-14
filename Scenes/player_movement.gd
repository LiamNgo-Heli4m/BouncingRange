extends CharacterBody2D

var isDragging = false
var vector: Vector2

@onready var sprite = $PlaceholderSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isDragging:
		var startPos = self.position
		var endPos = get_local_mouse_position()
			
		vector = startPos - endPos
	else:
		velocity += vector

	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			isDragging = true
		else:
			isDragging = false
