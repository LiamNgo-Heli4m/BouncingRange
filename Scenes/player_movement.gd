extends CharacterBody2D

var isDragging = false
var vector: Vector2
const initialSpeed = 1000
var speed = initialSpeed
var direction: Vector2

var wasDragging = false

var tween: Tween

@onready var sprite = $PlaceholderSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if isDragging:
		var startPos = self.position
		var endPos = get_viewport().get_mouse_position()
			
		vector = startPos - endPos
	
	if not isDragging and wasDragging:
		direction = vector.normalized()
		
	var collision = move_and_collide(direction * speed * delta)
	
	if collision:
		direction = direction.bounce(collision.get_normal())
		determineBounce(collision.get_normal())
		
	wasDragging = isDragging
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			isDragging = true
		else:
			isDragging = false

func determineBounce(direction: Vector2, duration: float = 0.1):
	var bounceDir: Vector2
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween()
	
	bounceDir = Vector2(abs(direction.x), abs(direction.y))
		
	if abs(direction.x) < 0.5:
		bounceDir.x = 2
	if abs(direction.y) < 0.5:
		bounceDir.y = 2
		
	print(bounceDir)
	
	tween.tween_property(sprite, "scale", bounceDir, duration * 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "scale", Vector2(2, 2), duration * 2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
