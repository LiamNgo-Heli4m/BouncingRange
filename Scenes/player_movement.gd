extends CharacterBody2D

var isDragging = false
var vector: Vector2
const initialSpeed = 800
var speed = initialSpeed
var direction: Vector2

var wasDragging = false

@onready var sprite = $PlaceholderSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	print(direction, vector)
	if isDragging:
		var startPos = self.position
		var endPos = get_local_mouse_position()
			
		vector = startPos - endPos
	
	if not isDragging and wasDragging:
		direction = vector.normalized()
		
	var collision = move_and_collide(direction * speed * delta)
	
	if collision:
		direction = direction.bounce(collision.get_normal())
		
		
	wasDragging = isDragging
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			isDragging = true
		else:
			isDragging = false
